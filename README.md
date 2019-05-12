# ChatterPostService

A new way to build with apex yours chatter posts with chaining mode, and in my opnion is very clean and readable. With Salesforce ConnectApi Or Chatter in Apex.

Right now, has a test class that provides 89% of code coverage and manual tests results in manualTest folder on this repository.

## Why ChatterPostService

The actual way of using Salesforce ConnectApi to post feed elements with Apex is very verbose and not so easy to understand at first look. Example:
For this result:</br>
![Result](https://github.com/bmodeprogrammer/ChatterPostService/blob/master/img/ChatterPostResult.JPG?raw=true) </br>
You need this code:
```java
Lead l = trigger.new[0];

    ConnectApi.FeedType feedType = ConnectApi.FeedType.UserProfile;

    ConnectApi.MessageBodyInput messageInput = new ConnectApi.MessageBodyInput();
    messageInput.messageSegments = new List<ConnectApi.MessageSegmentInput>();
    //stating with hey there
    ConnectApi.TextSegmentInput textSegment = new ConnectApi.TextSegmentInput();
    textSegment.text = 'Hey there ';
    messageInput.messageSegments.add(textSegment);
    //mention the user
    ConnectApi.MentionSegmentInput mentionSegment = new ConnectApi.MentionSegmentInput();
    mentionSegment.id = l.OwnerId;
    messageInput.messageSegments.add(mentionSegment);
    //complement the phrase
    textSegment = new ConnectApi.TextSegmentInput();
    textSegment.text = '. How are you?';
    messageInput.messageSegments.add(textSegment);
    //starting an ordered list
    ConnectApi.MarkupBeginSegmentInput markupBegin = new ConnectApi.MarkupBeginSegmentInput();
    markupBegin.markupType = ConnectApi.MarkupType.OrderedList;
    messageInput.messageSegments.add(markupBegin);

    markupBegin = new ConnectApi.MarkupBeginSegmentInput();
    markupBegin.markupType = ConnectApi.MarkupType.ListItem;
    messageInput.messageSegments.add(markupBegin);

    markupBegin = new ConnectApi.MarkupBeginSegmentInput();
    markupBegin.markupType = ConnectApi.MarkupType.Italic;
    messageInput.messageSegments.add(markupBegin);

    markupBegin = new ConnectApi.MarkupBeginSegmentInput();
    markupBegin.markupType = ConnectApi.MarkupType.Bold;
    messageInput.messageSegments.add(markupBegin);
    //this text will be in italic and bold, and the first item of the list
    textSegment = new ConnectApi.TextSegmentInput();
    textSegment.text = 'test bold and italic';
    messageInput.messageSegments.add(textSegment);

    ConnectApi.MarkupEndSegmentInput markupEndSegment = new ConnectApi.MarkupEndSegmentInput();
    markupEndSegment.markupType = ConnectApi.MarkupType.Bold;
    messageInput.messageSegments.add(markupEndSegment);

    markupEndSegment = new ConnectApi.MarkupEndSegmentInput();
    markupEndSegment.markupType = ConnectApi.MarkupType.Italic;
    messageInput.messageSegments.add(markupEndSegment);

    markupEndSegment = new ConnectApi.MarkupEndSegmentInput();
    markupEndSegment.markupType = ConnectApi.MarkupType.ListItem;
    messageInput.messageSegments.add(markupEndSegment);

    markupBegin = new ConnectApi.MarkupBeginSegmentInput();
    markupBegin.markupType = ConnectApi.MarkupType.ListItem;
    messageInput.messageSegments.add(markupBegin);

    //creating a link hidden behind the text and the second item of the list
    markupBegin = new ConnectApi.MarkupBeginSegmentInput();
    markupBegin.markupType = ConnectApi.MarkupType.Hyperlink;
    markupBegin.url = System.URL.getSalesforceBaseUrl().toExternalForm() + '/' + l.Id; 
    markupBegin.altText = l.LastName; 
    messageInput.messageSegments.add(markupBegin);
    
    textSegment = new ConnectApi.TextSegmentInput();
    textSegment.text = 'Click o the lead ' + l.LastName;
    messageInput.messageSegments.add(textSegment);

    markupEndSegment = new ConnectApi.MarkupEndSegmentInput();
    markupEndSegment.markupType = ConnectApi.MarkupType.Hyperlink;
    messageInput.messageSegments.add(markupEndSegment);

    markupEndSegment = new ConnectApi.MarkupEndSegmentInput();
    markupEndSegment.markupType = ConnectApi.MarkupType.ListItem;
    messageInput.messageSegments.add(markupEndSegment);

    markupBegin = new ConnectApi.MarkupBeginSegmentInput();
    markupBegin.markupType = ConnectApi.MarkupType.ListItem;
    messageInput.messageSegments.add(markupBegin);
    //list item of the list a link
    ConnectApi.LinkSegmentInput urlSegment = new ConnectApi.LinkSegmentInput();
    urlSegment.url = System.URL.getSalesforceBaseUrl().toExternalForm() + '/' + l.Id;
    messageInput.messageSegments.add(urlSegment);

    markupEndSegment = new ConnectApi.MarkupEndSegmentInput();
    markupEndSegment.markupType = ConnectApi.MarkupType.ListItem;
    messageInput.messageSegments.add(markupEndSegment);

    markupEndSegment = new ConnectApi.MarkupEndSegmentInput();
    markupEndSegment.markupType = ConnectApi.MarkupType.OrderedList;
    messageInput.messageSegments.add(markupEndSegment);
    // build the feed item
    ConnectApi.FeedItemInput input = new ConnectApi.FeedItemInput();
    input.body = messageInput;
    input.subjectId = l.Id;
    input.feedElementType = ConnectApi.FeedElementType.FeedItem;
    // post it
    ConnectApi.FeedElement fi = ConnectApi.ChatterFeeds.postFeedElement(Network.getNetworkId(), input);

```

With chainning mode that this service offers:

```java
 ConnectApi.ChatterFeeds.postFeedElement(Network.getNetworkID(), 
        new ChatterPostService(l.Id, ConnectApi.FeedElementType.FeedItem)
            .addText('Hey there ')
            .addUserOrGroupMentionById(l.OwnerId)
            .addText('. How are you?')
            .beginOrderedList()
            //first item
            .beginListItem()
            .beginItalic()
            .beginBold()
            .addText('test bold and italic')
            .endBold()
            .endItalic()
            .endListItem()
            //second item
            .beginListItem()
            .beginHyperlink(System.URL.getSalesforceBaseUrl().toExternalForm() + '/' + l.Id, l.LastName)
            .addText('Click o the lead ' + l.LastName)
            .endHyperlink()
            .endListItem()
            //third item
            .beginListItem()
            .addLink(System.URL.getSalesforceBaseUrl().toExternalForm() + '/' + l.Id)
            .endListItem()
            .endOrderedList()
            //get the input for sending
            .getFeedItemInput()
    );

```
