# ChatterPostService

A new way to build with apex yours chatter posts with chaining mode. With Salesforce ConnectApi Or Chatter in Apex.

## Why ChatterPostService

The actual way of using Salesforce ConnectApi to post feed elements with Apex is very verbose and not so easy to understand at first look. Example:

```java
String communityId = null;
ConnectApi.FeedType feedType = ConnectApi.FeedType.UserProfile;
String userToMention = '005xx000001TDn3';
String subjectId = '005xx000001TDn3';

ConnectApi.MessageBodyInput messageInput = new ConnectApi.MessageBodyInput();
messageInput.messageSegments = new List<ConnectApi.MessageSegmentInput>();

ConnectApi.TextSegmentInput textSegment = new ConnectApi.TextSegmentInput();
textSegment.text = 'Hey there ';
messageInput.messageSegments.add(textSegment);

ConnectApi.MentionSegmentInput mentionSegment = new ConnectApi.MentionSegmentInput();
mentionSegment.id = userToMention;
messageInput.messageSegments.add(mentionSegment);

textSegment = new ConnectApi.TextSegmentInput();
textSegment.text = '. How are you?';
messageInput.messageSegments.add(textSegment);

ConnectApi.FeedItemInput input = new ConnectApi.FeedItemInput();
input.body = messageInput;
input.subjectId = 'me';

ConnectApi.FeedItem fi = ConnectApi.ChatterFeeds.postFeedElement(Network.getNetworkId(), input);

```
