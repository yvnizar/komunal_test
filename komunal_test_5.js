const isEqual = arr => arr.every(v => v === arr[0])
const summArr = arr => arr.reduce((a, b) => a + b, 0)
var arr = [10, 55, 34]
var i = 0

console.log("Input Daging :", arr)
console.log("Total Daging :", summArr(arr))

if (summArr(arr) % 3 !== 0) 
	return console.log("Mohon Maaf, Input Daging Tidak Bisa Dibagi Rata")

while (!isEqual(arr)) {
	if (arr[0] < arr[1]) {
		arr[0] += 1
		arr[1] -= 1
	} else if (arr[1] < arr[2]) {
		arr[1] += 1
		arr[2] -= 1
	} else if (arr[0] > arr[1]) {
		arr[0] -= 1
		arr[1] += 1
	} else if (arr[1] > arr[2]) {
		arr[1] -= 1
		arr[2] += 1
	}

	i++

	console.log("Langkah", i, ":", arr)
}

return console.log("Total Langkah :", i)