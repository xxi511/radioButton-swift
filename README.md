# radioButton-swift
Very basic radio button    
![](https://github.com/xxi511/radioButton-swift/blob/master/images/img1.png)     

## easy to use    
1. drag `radioButton.swift` to project    
2. drag a `UIButton` to Storyboard
3. click `identity inspector` page, setting Custom class as `radioButton`    
set button style frome `system` to `custom`
![](https://github.com/xxi511/radioButton-swift/blob/master/images/img4.png)    

4. Connect by **IBCollection**    
![](https://github.com/xxi511/radioButton-swift/blob/master/images/img2.png)    
in swift file, it should look like    
`@IBOutlet var btns: [radioButton]!`    

5. Connect every radio button by `Touch up inside` to **SAME** method    
```swift
@IBAction func test(_ sender: UIButton) {
        
        for btn in self.btns {
            if btn == sender {
                btn.isSelected = true
            }
            else {
                btn.isSelected = false
            }
        }
    }
```

All property    
![](https://github.com/xxi511/radioButton-swift/blob/master/images/img3.png)    
* line Color: outter circle line color    
* fill Color: inner circel filled color
* padding: padding between circle and text (maybe not adjust it)    
* line width: outter circle line width
