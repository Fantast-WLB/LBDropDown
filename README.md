# LBDropDown
A simple dropdown list in swift.

# Usage
Here is how you can create a dropdown list:

        ///@param BasicButton    determine which button your dropdown list created on
        ///@param ViewDirection sets up your dropdown list direction
        ///@param ViewHeight    sets up your dropdown list height
        ///@param TitleArray  sets up your titles for list
        ///@param ImageArray  sets up your images for list
        self.dropDown!.showDropDown(BasicButton: sender, ViewDirection:direction!, ViewHeight: 100, TitleArray: ["我是第一个","我是第二个","我是第三个","我是第四个"], ImageArray: [])
        self.dropDown!.delegate = self

# LBDropDownDelegate
        
        func choseTheCell(DropDown dropDown: LBDropDown) {
        self.dropDown = nil
        }
        
# Custom the dropdown list

        see code in LBDropDown.swift
        
        
# Effect Picture
![image](https://github.com/Fantast-WLB/LBPullList/blob/master/LBPullList/choose.gif)

![image](https://github.com/Fantast-WLB/LBPullList/blob/master/LBPullList/pull.gif)
