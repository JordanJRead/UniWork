def is_valid_number(num: str) -> bool:
    """
    Returns True if and only if num is represents a valid number.
    See the corresponding .pdf for a definition of what a valid number
    would be.

    >>> is_valid_number("10")
    True
    >>> is_valid_number("-124")
    True
    >>> is_valid_number("12.9")
    True
    >>> is_valid_number("12.9.0")
    False
    >>> is_valid_number("abc")
    False
    """

    if len(num) == 0:
        return False
    
    # Remove sign
    if (num[0] in ['+', '-']):
        num = num[1:]
    
    # Simple case, where there is no decimal
    if (num.isnumeric()):
        return True
    # Now, number should have the format ####.####

    if (num.count('.') != 1):
        return False
    
    # Make sure dot is in the middle of the string
    if num.index('.') in [0, len(num) - 1]:
        return False
    
    nums = num.split('.')

    if (len(nums) != 2):
        return False # Shouldn't ever happen anyways
    
    return nums[0].isnumeric() and nums[1].isnumeric()


def is_valid_term(term: str) -> bool:
    """
    Returns True if and only if num is represents a valid term.
    See the corresponding .pdf for a definition of a valid term.

    >>> is_valid_term("44.4x^6")
    True
    >>> is_valid_term("-7x")
    True
    >>> is_valid_term("9.9")
    True
    >>> is_valid_term("7y**8")
    False
    >>> is_valid_term("7x^8.8")
    False
    >>> is_valid_term("7*x^8.8")
    False
    >>> is_valid_term("7x^ 8.8")
    False
    """

    # Degree 0
    if is_valid_number(term):
        return True
    
    # Degree 1
    allButLast = term[0:len(term) - 1]
    if is_valid_number(allButLast) and term[-1] == 'x':
        return True
    
    # Degree > 1
    if term.count('x') != 1:
        return False
    
    num, exp = term.split('x')

    if not is_valid_number(num):
        return False

    if len(exp) < 2:
        return False

    if (exp[0] != '^'):
        return False
    
    afterCaret = exp[1:]
    if (afterCaret.isnumeric() and afterCaret not in [0, 1]): # Assuming that degree 0 and 1 must not have an exponent
        return True

    
def approx_equal(x: float, y: float, tol: float) -> bool:
    """
    Returns True if and only if x and y are within tol of each other.

    >>> approx_equal(5, 4, 1)
    True
    >>> approx_equal(5, 3, 1)
    False
    >>> approx_equal(0.999, 1, 0.0011)
    True
    >>> approx_equal(0.999, 1, 0.0001)
    False
    """

    return abs(x - y) <= tol


def degree_of(term: str) -> int:
    """
    Returns the degree of term, it is assumed that term is a valid term.
    See the corresponding .pdf for a definition of a valid term.

    >>> degree_of("55x^6")
    6
    >>> degree_of("-1.5x")
    1
    >>> degree_of("252.192")
    0
    """

    if (is_valid_number(term)):
        return 0
    if (term[-1] == 'x'):
        return 1
    
    caretIndex = term.index('^')
    return int(term[caretIndex + 1:])


def get_coefficient(term: str) -> float:
    """
    Returns the coefficient of term, it is assumed that term is a valid term.
    See the corresponding .pdf for a definition of a valid term.

    >>> get_coefficient("55x^6")
    55
    >>> get_coefficient("-1.5x")
    -1.5
    >>> get_coefficient("252.192")
    252.192
    """
    return float(term.split('x')[0])



#Do not worry about the code past this point. 
#********************************************

def derive(poly):
    derivative = []
    degree = 1
    for coefficient in poly[1:]:
        derivative.append(coefficient*degree)
        degree += 1
    return derivative

def get_coefficients(terms):
    poly = []
    degree = 0
    for term in terms:
        while degree != degree_of(term):
            poly.append(0)
            degree += 1
        poly.append(get_coefficient(term))
        degree +=1
    return poly

def evaluate(poly, x):
    value = 0
    degree = 0
    for coefficient in poly:
        degree += 1
        value += coefficient * x**degree
    return value
        

if __name__ == "__main__":
    poly_string = input("Please enter a polynomial: ")
    terms = poly_string.strip().split("+")

    valid_poly = True
    for term in terms:
        if not is_valid_term(term):
            valid_poly = False

    while not valid_poly:
        poly_string = input("Incorrect format. Please enter a polynomial: ")
        terms = poly_string.strip().split("+")

        valid_poly = True
        for term in terms:
            if not is_valid_term(term):
                valid_poly = False
            
    poly = get_coefficients(terms)
    derivative = derive(poly)
    current_value = float(input("Please enter a starting point: "))
    tol = float(input("Please enter a tolerance: "))
    
    next_value = current_value - (evaluate(poly, current_value)/evaluate(derivative, current_value))
    while not(approx_equal(current_value, next_value, tol)):
        current_value = next_value
        next_value = current_value - (evaluate(poly, current_value)/evaluate(derivative, current_value))
    print("The polynoimal has a 'zero' approximately at: " + str(next_value))
    
