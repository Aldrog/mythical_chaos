"""
Preprocessor class
"""

import codecs
import copy
import os
import re
from io import StringIO, TextIOWrapper


class Symbol(str):
    """Symbol token"""


class StringLiteral(str):
    """String literal token"""


class Integer(int):
    """Integer literal token"""


class Float(float):
    """Floating point literal token"""


type Number = Integer | Float


class Operator(str):
    """Operator token"""

    VALID_SYMBOLS = "#!&|^<>*/=+-"


class OpeningBracket:
    """Opening bracket '(' token"""


class ClosingBracket:
    """Closing bracket ')' token"""


class ArgumentSeparator:
    """Argument separator ',' token"""


type Token = Symbol | StringLiteral | Number | Operator | OpeningBracket | ClosingBracket | ArgumentSeparator


def escape_string(string: StringLiteral | str) -> str:
    """Escape special symbols to produce a valid string literal"""
    return string.replace("\\", "\\\\").replace('"', '\\"')


def unescape_string(string: str) -> StringLiteral:
    """Unescape a string literal"""
    return StringLiteral(
        codecs.escape_decode(bytes(string, "utf-8"))[0].decode("utf-8")
    )


def typed_token(token: str) -> Token:
    """Convert string to a properly typed token"""

    if token[0] == '"' and token[-1] == '"':
        return unescape_string(token[1:-1])
    elif token.isdecimal():
        return Integer(token)
    elif token[0].isdecimal():
        return Float(token)
    elif token == "(":
        return OpeningBracket()
    elif token == ")":
        return ClosingBracket()
    elif token == ",":
        return ArgumentSeparator()
    elif re.match(rf"[{Operator.VALID_SYMBOLS}]+", token):
        return Operator(token)
    else:
        return Symbol(token)


class Preprocessor:
    """
    Preprocessor for XS scripts.
    Supported directives:
    #define MACRO VALUE
        standard, functional macros are not supported.
    #wrap_include function "path"
        custom, process source at the given path and include each line as a string
        argument to the given function.
        The included source is preprocessed independently, macros #defined in the
        including source not affecting processing of the included source and vice versa.
    include "path";
        standard, multiple statements on a single line are not supported.
    """

    def __init__(
        self,
        defines: dict[str, str],
        input_file: TextIOWrapper,
        output_file: TextIOWrapper,
        current_directory: str,
        original_defines: dict[str, str] | None = None,
    ):
        self.original_defines = original_defines if original_defines else defines
        self.defines = copy.copy(defines)
        self.input_file = input_file
        self.output_file = output_file
        self.current_directory = current_directory
        self.continuation_line = ""

    def run(self):
        """Run preprocessing on the whole file"""
        for line in self.input_file:
            self.output_file.write(self._process_line(line))

    def _process_line(self, line: str) -> str:
        """Process a single line of the input source"""
        stripped = line.strip()

        # A hack to support include directive which doesn't use preprocessor syntax
        first_token, _ = self._get_next_token(stripped)
        if (
            stripped.startswith("#")
            or self.continuation_line
            or (isinstance(first_token, Symbol) and first_token == "include")
        ):
            if stripped.endswith("\\"):
                self.continuation_line += stripped[:-1]
                return ""
            combined_line = self.continuation_line + stripped
            self.continuation_line = ""
            return self._process_directive(combined_line)

        for key, val in self.defines.items():
            line = re.sub(rf"\b{key}\b", val, line)

        return line

    def _get_next_token(self, line: str) -> tuple[Token | None, str]:
        """
        Extract the first token from 'line', return the extracted token and the
        remaining line.
        """
        start_pos = None
        for i, char in enumerate(line):
            if start_pos is None:
                if not char.isspace():
                    start_pos = i
                continue
            if line[start_pos] in "(),":
                return (typed_token(line[start_pos:i]), line[i:])
            elif line[start_pos] in Operator.VALID_SYMBOLS:
                if not char in Operator.VALID_SYMBOLS:
                    return (typed_token(line[start_pos:i]), line[i:])
            elif line[start_pos] == '"':
                if char == '"' and line[i - 1] != "\\":
                    return (typed_token(line[start_pos : i + 1]), line[i + 1 :])
            elif line[start_pos].isdecimal() or line[start_pos] == ".":
                if not char.isdecimal() and not char == ".":
                    return (typed_token(line[start_pos:i]), line[i:])
            elif line[start_pos].isalpha() or line[start_pos] == "_":
                if not char.isalnum() and not char == "_":
                    return (typed_token(line[start_pos:i]), line[i:])
        if start_pos is None:
            return (None, line)
        return (typed_token(line[start_pos:]), "")

    def _process_directive(self, source_line: str) -> str:
        """Process preprocessor directive"""
        directive, line = self._get_next_token(source_line.removeprefix("#"))
        assert isinstance(directive, Symbol)

        if directive == "define":
            key, value = self._get_next_token(line)
            assert isinstance(key, Symbol)
            assert not value or value[0].isspace(), "bad or unsupported define syntax"
            self.defines[key] = value.strip()

        if directive == "include":
            path, line = self._get_next_token(line)
            assert isinstance(path, StringLiteral) and line.strip() == ";"
            full_path = os.path.join(self.current_directory, path)
            if not os.path.exists(full_path):
                # Unresolved include
                # TODO: produce a warning
                return source_line + "\n"
            with open(full_path, mode="r", encoding="utf-8") as include_file:
                preprocessor = Preprocessor(
                    self.defines,
                    include_file,
                    self.output_file,
                    os.path.dirname(full_path),
                    original_defines=self.original_defines,
                )
                preprocessor.run()
                self.defines = preprocessor.defines
                return ""

        if directive == "wrap_include":
            function, line = self._get_next_token(line)
            path, line = self._get_next_token(line)
            none, line = self._get_next_token(line)
            assert (
                isinstance(path, StringLiteral)
                and isinstance(function, Symbol)
                and none is None
            )
            full_path = os.path.join(self.current_directory, path)
            with (
                open(full_path, mode="r", encoding="utf-8") as include_file,
                StringIO() as output,
            ):
                preprocessor = Preprocessor(
                    self.original_defines,
                    include_file,
                    output,
                    os.path.dirname(full_path),
                )
                preprocessor.run()
                result = ""
                for line in output.getvalue().splitlines():
                    result += function + '("' + escape_string(line) + '");\n'
                return result

        return source_line + "\n"
