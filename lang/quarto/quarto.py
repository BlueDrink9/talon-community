from talon import Context, Module, actions, settings

from ..tags.operators import Operators

ctx = Context()

ctx.matches = r"""
code.language: quarto
"""
