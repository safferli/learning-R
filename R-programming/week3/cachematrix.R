## Put comments here that give an overall description of what your
## functions do

## create a inversable matrix


# makeCacheMatrix: Creates a special "matrix" object that can cache its inverse
# makeCacheMatrix() returns a list of functions to:
# 1. Set the value of the matrix
# 2. Get the value of the matrix
# 3. Set the value of the inverse
# 4. Get the value of the inverse
# x=matrix() forces the input into a matrix
makeCacheMatrix <- function(x = matrix()) {
    # inv will store the cached inverse matrix
    # initialise it as empty (NULL)
    inv <- NULL
    # 1) set the value of the matrix
    set <- function(y) {
        x <<- y
        inv <<- NULL
    }
    # 2) get the value of the matrix
    get <- function() x
    # 3) set the value of the inverse
    setinv <- function(inverse) inv <<- inverse
    # 4) get the value of the inverse
    getinv <- function() inv
    # return this, the last "output element"
    list(set = set, 
         get = get, 
         setinv = setinv, 
         getinv = getinv
         )
}

# cacheSolve: Computes the inverse of the special "matrix" returned by makeCacheMatrix above.
# If the inverse has already been calculated (and the matrix has not changed),
# then the cachesolve will retrieve the inverse from the cache.
cacheSolve <- function(x, ...) {
    inv <- x$getinv()
    # if the inverse is already calculated, return it
    # !is.null -> not null -> "inverse" exists
    if (!is.null(inv)) {
        message("getting cached data")
        return(inv)
    }
    # else: inverse is not yet calculated, so we calculate and return it
    data <- x$get()
    # solve() gets the inverse of a matrix
    inv <- solve(data, ...)
    # cache the inverse
    x$setinv(inv)
    # return this, the last "output element" -- the inverse
    inv
}


# NOT RUN Example:
n <- 4
x <- matrix(rnorm(n^2), nrow = n) # Create a square matrix x
cx <- makeCacheMatrix(x) # Create our special matrix
cx$get() # Return the matrix
cacheSolve(cx) # Return the inverse
cacheSolve(cx) == solve(x)
