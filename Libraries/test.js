function selectedValue(ele, index){
    $(ele).prev('ul').find('li:eq('+ index +') label').click()
}


