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