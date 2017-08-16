# radioButton-swift
Very basic radio button    
![](https://github.com/xxi511/radioButton-swift/blob/master/images/img1.png)     

## easy to use    
1. drag `radioButton.swift` to project    
2. drag a `UIView` to Storyboard
3. click `identity inspector` page, setting Custom class as `radioButton`      
![](https://github.com/xxi511/radioButton-swift/blob/master/images/img4.png)    

4. Connect by **IBCollection**    
![](https://github.com/xxi511/radioButton-swift/blob/master/images/img2.png)    
in swift file, it should look like    
`@IBOutlet var btns: [radioButton]!`    

5. Connect every radio button by `Touch up inside` to **SAME** method    
```swift
@IBAction func test(_ sender: radioButton) {  
    for btn in self.btns {
        btn.radioSelected = (btn == sender) ? true: false
    }
}
```

All property    
![](https://github.com/xxi511/radioButton-swift/blob/master/images/img3.png)      
* title: button title    
* Color: text color and outter circle color    
* Fill Color: inner circle color     
* padding: padding between text and circle, it work fine if button auto resize by itself    
* line width: line widht of outter circle    
* inner Multiple: CGFloat, how big the inner circle is    
can set [0~1] 1 means as big as outter circle, 0.5 meas half of outter circle    
* Text size: text size    
* Radio Selected: the selected status of radio button    
