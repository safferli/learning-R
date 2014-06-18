## Put comments here that give an overall description of what your
## functions do

## create a inversable matrix

makeCacheMatrix <- function(x = matrix()) {
    value <- NULL
    set <- function(y) {
        x <<- y
        value <<- NULL
    }
    get <- function() x
    setinverse <- function(solve) value <<- solve
    getinverse <- function() value
    list(set = set, get = get,
         setinverse = setinverse,
         getinverse = getinverse)
}


## inverse a matrix, if the matrix is inversed already, return the cached-inversed one,
## otherwise, inverse it and save the inversed matrix in cache and return it

cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    value <- x$getinverse()
    if(!is.null(value)) {
        message("getting cached data")
        return(value)
    }
    data <- x$get()
    value <- solve(data, ...)
    x$setinverse(value)
    value
}


## solution could be: 
# makeCacheMatrix: Creates a special "matrix" object that can cache its inverse
# makeCacheMatrix() return a list of functions to:
# 1. Set the value of the matrix
# 2. Get the value of the matrix
# 3. Set the value of the inverse
# 4. Get the value of the inverse


makeCacheMatrix <- function(x = matrix()) {
    # inv will store the cached inverse matrix
    inv <- NULL
    # Setter for the matrix
    set <- function(y) {
        x <<- y
        inv <<- NULL
    }
    # Getter for the matrix
    get <- function() x
    # Setter for the inverse
    setinv <- function(inverse) inv <<- inverse
    # Getter for the inverse
    getinv <- function() inv
    # Return the matrix with our newly defined functions
    list(set = set, get = get, setinv = setinv, getinv = getinv)
}


# cacheSolve: Computes the inverse of the special "matrix" returned by makeCacheMatrix above.
# If the inverse has already been calculated (and the matrix has not changed),
# then the cachesolve should retrieve the inverse from the cache.

cacheSolve <- function(x, ...) {
    inv <- x$getinv()
    # If the inverse is already calculated, return it
    if (!is.null(inv)) {
        message("getting cached data")
        return(inv)
    }
    # The inverse is not yet calculated, so we calculate it
    data <- x$get()
    inv <- solve(data, ...)
    # Cache the inverse
    x$setinv(inv)
    # Return a matrix that is the inverse of 'x'
    inv
}



# NOT RUN Example:
# n <- 4
# x <- matrix(rnorm(n^2), nrow = n) // Create a square matrix x
# cx <- makeCacheMatrix(x) // Create our special matrix
# cx$get() // Return the matrix
# cacheSolve(cx) // Return the inverse
# cacheSolve(cx) == solve(x)