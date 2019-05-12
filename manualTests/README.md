# ChatterPostService Manual Test

Here is a manual test

## Code in Lead trigger

```
String firstText = 'Hey there ';
String tag = 'salesforce';
String firstUrl = System.URL.getSalesforceBaseUrl().toExternalForm() + '/' + UserInfo.getUserId();
ConnectApi.ChatterFeeds.postFeedElement(Network.getNetworkId(), new ChatterPostService(l.Id, ConnectApi.FeedElementType.FeedItem)
    .addText('Hey there ') //0
    .addUserOrGroupMentionById(UserInfo.getUserId())//1
    .addText('. How are you?')//2
    .beginOrderedList()//3
    //first item
    .beginListItem()//4
    .beginItalic()//5
    .beginBold()//6
    .addText('test bold and italic')//7
    .endBold()//8
    .endItalic()//9
    .endListItem()//10
    //second item
    .beginListItem()//11
    .beginHyperlink(firstUrl, UserInfo.getLastName())//12
    .addText('Click o the lead ' + UserInfo.getLastName())//13
    .endHyperlink()//14
    .endListItem()//15
    //third item
    .beginListItem()//16
    .addLink(firstUrl)//17
    .endListItem()//18
    .endOrderedList()//19
    .beginParagraph()//20
    .beginStrike()//21
    .beginUnderline()//22
    .addText('My Paragraph with text striked and with underline')//23
    .endUnderline()//24
    .endStrike()//25
    .endParagraph()//26
    .addHashtag(tag)//27
    .beginCode()//28
    .addText('() => {} //arrow functions')//29
    .endCode()//30
    .beginUnorderedList()//31
    .beginListItem()
    .addText('myUnorderedList')
    .endListItem()
    .endUnorderedList()//32
    .beginHyperlink(firstUrl)//33
    .endHyperlink()//34
    .addImage('0691r00000930vhAAA', 'bike')
    //get the input for sending
    .getFeedItemInput()
);

```

## Result

![Result](https://github.com/bmodeprogrammer/ChatterPostService/blob/master/img/test2.jpg?raw=true) </br>