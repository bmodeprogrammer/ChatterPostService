/**
 * @Author Elias Pinheiro
 * @Github @bmodeprogrammer
 * @Date 23/03/2019
 * @Desc Service class to help build chatter posts less verbose and easier
 */
global inherited sharing class ChatterPostService {
    
    private ConnectApi.FeedItemInput feedItemInput;
    private List<ConnectApi.MessageSegmentInput> messageSegments;
    
    global ChatterPostService(String subjectId, ConnectApi.FeedElementType elementType) {
        this.feedItemInput = new ConnectApi.FeedItemInput();
        this.feedItemInput.feedElementType = elementType;
        this.feedItemInput.subjectId = subjectId;
        this.feedItemInput.body = new ConnectApi.MessageBodyInput();
        this.messageSegments = new List<ConnectApi.MessageSegmentInput>();
    }
    
    /**
     * Add simple text into the post
     * @param  text String that contains the text
     * @return this instance of the object for chaining purpose
     * @see https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_connectapi_input_TxtMsgSeg.htm
     */
    global ChatterPostService addText(String text) {
        ConnectApi.TextSegmentInput textSegment = new ConnectApi.TextSegmentInput();
        textSegment.text = text;
        this.messageSegments.add(textSegment);
        return this;
    }
    
    /**
     * Link a SObject, it will appear the Name of the object like an url,
     * when the user click the page will be redirected to the SObject record home.
     * @param  entityId SObject Id. 
     * @return this instance of the object for chaining purpose
     * @see https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_connectapi_input_entity_link_segment.htm
     */
    global ChatterPostService addLinkToSObject(String entityId) {
        ConnectApi.EntityLinkSegmentInput entityLink = new ConnectApi.EntityLinkSegmentInput();
        entityLink.entityId = entityId;
        this.messageSegments.add(entityLink);
        return this;
    }
    
    /**
     * @mention an user or a group by id
     * @param  userOrGroupId Id of the user or group to mention
     * @return this instance of the object for chaining purpose
     * @see https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_connectapi_input_mentionMsgSeg.htm
     */
    global ChatterPostService addUserOrGroupMentionById(String userOrGroupId) {
        ConnectApi.MentionSegmentInput mentionSegment = new ConnectApi.MentionSegmentInput();
        mentionSegment.id = userOrGroupId;
        this.messageSegments.add(mentionSegment);
        return this;
    }

    /**
     * Add a hastag into the chatter post
     * @param  tag String that will be transformed into #str
     * @return this instance of the object for chaining purpose
     * @see https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_connectapi_input_hashtag.htm
     */
    global ChatterPostService addHashtag(String tag) {
        ConnectApi.HashtagSegmentInput hashtagSegment = new ConnectApi.HashtagSegmentInput();
        hashtagSegment.tag = tag;
        this.messageSegments.add(hashtagSegment);
        return this;
    }

     /**
     * Begins bold <b>
     * @return  this instance of the object for chaining purpose 
     * @see https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_connectapi_input_markup_begin_segment.htm
     */
    global ChatterPostService beginBold() {
        return this.beginMarkup(ConnectApi.MarkupType.Bold);
    }

    /**
     * End Bold </b>
     * @return  this instance of the object for chaining purpose 
     * @see https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_connectapi_input_markup_begin_segment.htm
     */
    global ChatterPostService endBold() {
        return this.endMarkup(ConnectApi.MarkupType.Bold);
    }

     /**
     * Begins Code <code>
     * @return  this instance of the object for chaining purpose 
     * @see https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_connectapi_input_markup_begin_segment.htm
     */
    global ChatterPostService beginCode() {
        return this.beginMarkup(ConnectApi.MarkupType.Code);
    }

    /**
     * End Code </code>
     * @return  this instance of the object for chaining purpose 
     * @see https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_connectapi_input_markup_begin_segment.htm
     */
    global ChatterPostService endCode() {
        return this.endMarkup(ConnectApi.MarkupType.Code);
    }

    /**
     * Begins Italic <i>
     * @return  this instance of the object for chaining purpose 
     * @see https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_connectapi_input_markup_begin_segment.htm
     */
    global ChatterPostService beginItalic() {
        return this.beginMarkup(ConnectApi.MarkupType.Italic);
    }

    /**
     * End Italic </i>
     * @return  this instance of the object for chaining purpose 
     * @see https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_connectapi_input_markup_begin_segment.htm
     */
    global ChatterPostService endItalic() {
        return this.endMarkup(ConnectApi.MarkupType.Italic);
    }

    /**
     * Begins ListItem <li>
     * @return  this instance of the object for chaining purpose 
     * @see https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_connectapi_input_markup_begin_segment.htm
     */
    global ChatterPostService beginListItem() {
        return this.beginMarkup(ConnectApi.MarkupType.ListItem);
    }

    /**
     * End ListItem </li>
     * @return  this instance of the object for chaining purpose 
     * @see https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_connectapi_input_markup_begin_segment.htm
     */
    global ChatterPostService endListItem() {
        return this.endMarkup(ConnectApi.MarkupType.ListItem);
    }

    /**
     * Begins OrderedList <ol>
     * @return  this instance of the object for chaining purpose 
     * @see https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_connectapi_input_markup_begin_segment.htm
     */
    global ChatterPostService beginOrderedList() {
        return this.beginMarkup(ConnectApi.MarkupType.OrderedList);
    }

    /**
     * End OrderedList </ol>
     * @return  this instance of the object for chaining purpose 
     * @see https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_connectapi_input_markup_begin_segment.htm
     */
    global ChatterPostService endOrderedList() {
        return this.endMarkup(ConnectApi.MarkupType.OrderedList);
    }

    /**
     * Begins Paragraph <p>
     * @return  this instance of the object for chaining purpose 
     * @see https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_connectapi_input_markup_begin_segment.htm
     */
    global ChatterPostService beginParagraph() {
        return this.beginMarkup(ConnectApi.MarkupType.Paragraph);
    }

    /**
     * End Paragraph </p>
     * @return  this instance of the object for chaining purpose 
     * @see https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_connectapi_input_markup_begin_segment.htm
     */
    global ChatterPostService endParagraph() {
        return this.endMarkup(ConnectApi.MarkupType.Paragraph);
    }

    /**
     * Begins Strike <strike>
     * @return  this instance of the object for chaining purpose 
     * @see https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_connectapi_input_markup_begin_segment.htm
     */
    global ChatterPostService beginStrike() {
        return this.beginMarkup(ConnectApi.MarkupType.Strikethrough);
    }

    /**
     * End Strike </strike>
     * @return  this instance of the object for chaining purpose 
     * @see https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_connectapi_input_markup_begin_segment.htm
     */
    global ChatterPostService endStrike() {
        return this.endMarkup(ConnectApi.MarkupType.Strikethrough);
    }

    /**
     * Begins Underline <u>
     * @return  this instance of the object for chaining purpose 
     * @see https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_connectapi_input_markup_begin_segment.htm
     */
    global ChatterPostService beginUnderline() {
        return this.beginMarkup(ConnectApi.MarkupType.Underline);
    }

    /**
     * End Underline </u>
     * @return  this instance of the object for chaining purpose 
     * @see https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_connectapi_input_markup_begin_segment.htm
     */
    global ChatterPostService endUnderline() {
        return this.endMarkup(ConnectApi.MarkupType.Underline);
    }

    /**
     * Begins UnorderedList <ul>
     * @return  this instance of the object for chaining purpose 
     * @see https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_connectapi_input_markup_begin_segment.htm
     */
    global ChatterPostService beginUnorderedList() {
        return this.beginMarkup(ConnectApi.MarkupType.UnorderedList);
    }

    /**
     * End UnorderedList </ul>
     * @return  this instance of the object for chaining purpose 
     * @see https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_connectapi_input_markup_begin_segment.htm
     */
    global ChatterPostService endUnorderedList() {
        return this.endMarkup(ConnectApi.MarkupType.UnorderedList);
    }

    /**
     * Begins Hyperlink <a href="">
     * @param url receives an string to be an url, needs to begin with http/https
     * @return  this instance of the object for chaining purpose 
     * @see https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_connectapi_input_markup_begin_segment.htm
     */
    global ChatterPostService beginHyperlink(String url) {
        ConnectApi.MarkupBeginSegmentInput markupBegin = new ConnectApi.MarkupBeginSegmentInput();
        markupBegin.url = url;
        markupBegin.markupType = ConnectApi.MarkupType.Hyperlink;
        this.messageSegments.add(markupBegin);
        return this;
    }

    /**
     * Begins Hyperlink <a href="" title="">
     * @param url receives an string to be an url, needs to begin with http/https
     * @param altText receives an string that appears on mouse hover of the link
     * @return  this instance of the object for chaining purpose 
     * @see https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_connectapi_input_markup_begin_segment.htm
     */
    global ChatterPostService beginHyperlink(String url, String altText) {
        ConnectApi.MarkupBeginSegmentInput markupBegin = new ConnectApi.MarkupBeginSegmentInput();
        markupBegin.url = url;
        markupBegin.altText = altText;
        markupBegin.markupType = ConnectApi.MarkupType.Hyperlink;
        this.messageSegments.add(markupBegin);
        return this;
    }

    /**
     * End Hyperlink <a/>
     * @return  this instance of the object for chaining purpose 
     * @see https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_connectapi_input_markup_begin_segment.htm
     */
    global ChatterPostService endHyperlink() {
        return this.endMarkup(ConnectApi.MarkupType.Hyperlink);
    }

    /**
     * End Markup
     * @param markup type of the markup segment
     * @return  this instance of the object for chaining purpose 
     * @see https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_connectapi_input_markup_begin_segment.htm
     */
    private ChatterPostService beginMarkup(ConnectApi.MarkupType markupType) {
        ConnectApi.MarkupBeginSegmentInput beginMarkup = new ConnectApi.MarkupBeginSegmentInput();
        beginMarkup.markupType = markupType;
        this.messageSegments.add(beginMarkup);
        return this;
    }

    /**
     * End Markup
     * @param markup type of the markup segment
     * @return  this instance of the object for chaining purpose 
     * @see https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_connectapi_input_markup_begin_segment.htm
     */
    private ChatterPostService endMarkup(ConnectApi.MarkupType markupType) {
        ConnectApi.MarkupEndSegmentInput endMarkup = new ConnectApi.MarkupEndSegmentInput();
        endMarkup.markupType = markupType;
        this.messageSegments.add(endMarkup);
        return this;
    }

    /**
     * Add a link to the chatter post
     * @param  url Link of the website/something
     * @return this instance of the object for chaining purpose 
     * @see https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_connectapi_input_linkMsgSeg.htm
     */
    global ChatterPostService addLink(String url) {
        ConnectApi.LinkSegmentInput  urlSegment = new ConnectApi.LinkSegmentInput ();
        urlSegment.url = url;
        this.messageSegments.add(urlSegment);
        return this;
    }

    /**
     * Add an inline image 
     * @param  fileId  Id of the file where is your image
     * @param  altText A message that will show on mouseover your image
     * @return  this instance of the object for chaining purpose 
     * @see https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_connectapi_input_inline_image_segment.htm
     */
    global ChatterPostService addImage(String fileId, String altText) {
        ConnectApi.InlineImageSegmentInput imageSegment = new ConnectApi.InlineImageSegmentInput();
        imageSegment.altText = altText;
        imageSegment.fileId = fileId;
        this.messageSegments.add(imageSegment);
        return this;
    }
    
    /**
     * get the instance of the feedItemInput
     * @return   ConnectApi.FeedItemInput
     * @see https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_connectapi_input_feedItem.htm
     */
    global ConnectApi.FeedItemInput getFeedItemInput() {
        this.feedItemInput.body.messageSegments = this.messageSegments;
        return feedItemInput;
    }

}