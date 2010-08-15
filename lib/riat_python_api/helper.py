def parse_named_param(string):
    """Given a string of the form key=value will return the key value in an array"""
    k, v = string.split("=")
    if k == "bbox":
        val = eval(v)
        v = val
    return [k, v]