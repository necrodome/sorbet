# typed: false
sig do # error: Malformed `sig`: No return type specified. Specify one with .returns()
  a&.o[]
# ^^^^ error: Method does not exist on `T::Private::Methods::DeclBuilder`
# ^^^^^^ error: Method `[]` does not exist on `T::Private::Methods::DeclBuilder`
end
def foo
end
