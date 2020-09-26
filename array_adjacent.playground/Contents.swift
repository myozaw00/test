//Expected partition is 4.
//let floor = [[1, 1, 1, 1], [1, 1, 1, 1], [1, 1, 1, 1], [1, 1, 1, 1]]
//Expected partition is 3.
//let floor = [[1, 0, 0, 0], [1, 0, 1, 0], [0, 1, 1, 0], [0, 0, 0, 1]]
//Expected partition is 3.
//let floor = [[1, 0, 0, 0], [0, 1, 1, 0], [0, 1, 1, 0], [0, 0, 0, 1]]
//Expected partition is 3.
//let floor = [[1, 1, 0, 0], [0, 1, 0, 1], [0, 0, 1, 1], [1, 1, 0, 0]]
//Expected partition is 0.
let floor = [[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]]55
var connectedPoints = [[Int]]()
var partitionCount = 0

for(i, _) in floor.enumerated() {
    
    for(j, _) in floor.enumerated() {
        if !connectedPoints.contains([i, j]) {
            if isConnected(x: i, y: j) && floor[i][j] == 1 {
                if !hasCommonPoints(arrayOne: connectedPoints,
                                    arrayTwo: getConnectedPoints(x: i, y: j)) {
                    connectedPoints.append(contentsOf: getConnectedPoints(x: i, y: j))
                    partitionCount += 1
                }else {
                    let tempConnectedPoints = getConnectedPoints(x: i, y: j)
                    let usedPoints: [[Int]] = getUsedPoints(arrayOne: connectedPoints,
                                                  arrayTwo: getConnectedPoints(x: i, y: j))
                    var groupedPoints = [[Int]]()
                    for(m, _) in tempConnectedPoints.enumerated() {
                        for(n, _) in usedPoints.enumerated() {
                            if tempConnectedPoints[m] != usedPoints[n] {
                                groupedPoints.append(tempConnectedPoints[m])
                            }
                        }
                    }
                    if !groupedPoints.isEmpty {
                        connectedPoints.append(contentsOf: groupedPoints)
                        partitionCount += 1
                    }
                    
                }
     
            }
        }
        
     }
}
print("Partitions: \(partitionCount)")

func hasCommonPoints(arrayOne: [[Int]], arrayTwo: [[Int]]) -> Bool {
    var hasCommon = false
    arrayOne.forEach {
        if arrayTwo.contains($0) {
            hasCommon = true
        }
    }

    return hasCommon
}

func getUsedPoints(arrayOne: [[Int]], arrayTwo: [[Int]]) -> [[Int]] {
    var points = [[Int]]()
    arrayOne.forEach {
        if arrayTwo.contains($0) {
            points.append($0)
        }
    }

    return points
}

func getConnectedPoints(x: Int, y: Int) -> [[Int]] {
    var points = [[Int]]()
    
    if y < 3 && x < 3 {
        if floor[x+1][y+1] == 1 {
            points.append([x+1, y+1])
        }
    }
    
    if x < 3 && y > 0 {
        if floor[x+1][y-1] == 1 {
            points.append([x+1, y-1])
        }
    }
    
    if x > 0 && y < 3 {
        if floor[x-1][y+1] == 1{
            points.append([x-1, y+1])
        }
    }
    
    if y > 0 {
        if floor[y-1][x] == 1 {
            points.append([y-1, x])
        }
    }
    
    if y < 3 {
        if floor[y+1][x] == 1 {
            points.append([y+1, x])
        }
    }
    
    if x > 0 {
        if floor[y][x-1] == 1{
            points.append([y, x-1])
        }
    }
    
    if x < 3 {
        if floor[y][x+1] == 1 {
            points.append([y, x+1])
        }
    }
    
    if floor[y][x] == 1 {
        points.append([y, x])
    }
    return points
}

func isConnected(x: Int, y: Int) -> Bool {

    if y > 0 {
        if floor[y-1][x] == 1 {
            return true
        }
    }
    
    if y < 3 {
        if floor[y+1][x] == 1 {
            return true
        }
    }
    
    if x > 0 {
        if floor[y][x-1] == 1{
            return true
        }
    }
    
    if x < 3 {
        if floor[y][x+1] == 1 {
            return true
        }
    }
    
    if floor[y][x] == 1 {
        return true
    }
    
    return false
}


