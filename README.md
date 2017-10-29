# CostCalculator
[![swift-version](https://img.shields.io/badge/swift-1-orange.svg)]() [![license](https://img.shields.io/github/license/suesu123456/CostCalculator.svg)]() [![platform](https://img.shields.io/cocoapods/p/BadgeSwift.svg)]()

A calculator with Swift program language that calculates the cost of living.

## Usage

### Step1: configure the participants

```swift
var xMan = ["Anne", "Sue", "Tommao", "Lagel", "Peach"]
```

### Step2: configure the details of each costs

Each cost is describe as a dictionary data structure, it must contains the following properties:

| Property | Type   | Description                              |
| -------- | ------ | ---------------------------------------- |
| name     | String | The name of current cost.                |
| allM     | String | The price of current cost.               |
| who      | String | The payer of current cost.               |
| share    | Array  | The participants of current cost, each item is the index of participant in `xMan` array. |

And we need to put all costs into an array, for example:

```swift
var consume = [
  ["name": "dinner", "allM": "128.0", "who": "Sue", "share": [0, 1, 2]],
  ["name": "train", "allM": "368.0", "who": "Peach", "share": [1, 4]]
]
```

### Step3: run program and get result

## License

MIT License

Copyright (c) 2017 Sue

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
