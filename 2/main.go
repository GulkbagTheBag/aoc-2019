package main

import (
  "fmt"
  "strconv"
  "log"
  "io"
  "os"
  "encoding/csv"
)

func main() {
  csv_file, _ := os.Open("input.txt")
  r := csv.NewReader(csv_file)
  pos := 0;
  var progInt = []int{}

  for {
    progStr, err := r.Read()
    if err == io.EOF {
      break
    }
    if err != nil {
      log.Fatal(err)
    }

    for _, i := range progStr {
      j, err := strconv.Atoi(i)
      if err != nil {
        panic(err)
      }
      progInt = append(progInt, j)
    }

    progInt[1] = 12;
    progInt[2] = 2;

    for progInt[pos] != 99 {
      opcode := progInt[pos];
      input1 := progInt[progInt[pos + 1]];
      input2 := progInt[progInt[pos + 2]];
      output := progInt[pos + 3];

      if opcode == 1 {
        progInt[output] = input1 + input2;
      } else if opcode == 2 {
        progInt[output] = input1 * input2;
      }

      pos += 4;
    }

    fmt.Println(progInt[0])
  }
}
