
/**
 * @Author Elias Pinheiro
 * @Github @bmodeprogrammer
 * @Date 23/03/2019
 * @Desc Service class to help build chatter posts less verbose and easier
 */
global inherited sharing class ChatterPostService {
    
    private ConnectApi.FeedItemInput feedItemInput;
    private List<ConnectApi.MessageSegmentInput> messageSegments;
    global static Boolean TRHOW_EXCEPTIONS = true;
    
    global ChatterPostService(String subjectId, ConnectApi.FeedElementType elementType) {
        if (TRHOW_EXCEPTIONS) checkId(subjectId, 'subjectId');
        this.feedItemInput = new ConnectApi.FeedItemInput();
        this.feedItemInput.feedElementType = elementType;
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
        if (TRHOW_EXCEPTIONS) checkId(entityId, 'entityId');
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
        if (TRHOW_EXCEPTIONS) checkId(userOrGroupId, 'userOrGroupId');
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
        if (TRHOW_EXCEPTIONS) isNullOrBlank(tag, 'tag');
        ConnectApi.HashtagSegmentInput hashtagSegment = new ConnectApi.HashtagSegmentInput();
        hashtagSegment.tag = tag;
        this.messageSegments.add(hashtagSegment);
        return this;
    }

    /**
     * Begins an markup block
     * @return  this instance of the object for chaining purpose 
     * @see https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_connectapi_input_markup_begin_segment.htm
     */
    global ChatterPostService beginMarkupBlock(ConnectApi.MarkupType markupType) {
        ConnectApi.MarkupBeginSegmentInput markupBegin = new ConnectApi.MarkupBeginSegmentInput();
        markupBegin.markupType = markupType;
        this.messageSegments.add(markupBegin);
        return this;
    }

    /**
     * Ends an markup block
     * @return  this instance of the object for chaining purpose 
     * @see https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_connectapi_input_markup_end_segment.htm
     */
    global ChatterPostService endMarkupBlock() {
        this.messageSegments.add(new ConnectApi.MarkupEndSegmentInput());
        return this;
    }

    /**
     * Add a link to the chatter post
     * @param  url Link of the website/something
     * @return this instance of the object for chaining purpose 
     * @see https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_connectapi_input_linkMsgSeg.htm
     */
    global ChatterPostService addLink(String url) {
        if (TRHOW_EXCEPTIONS) isNullOrBlank(url, 'url');
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
        if (TRHOW_EXCEPTIONS) checkId(fileId, 'fileId');
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
    
    /**
     * Check the ids passed on the several methods of this class, if is invalid, sends an exception
     * @param  idStr  id to check
     * @param  idDesc what is that id, example: subjectId
     */
    private static void checkId(String idStr, String idDesc) {
        if (IdService.isValidId(idStr)) return;
        throw new ChatterPostServiceException(
            'The Id ' + idDesc + ' passed is invalid'
        );
    }

    /**
     * Check if a string is blank, if it is, throw an exception
     * @param  str            string to be checked
     * @param  whatCanBeBlank what is the string. Example: tag
     */
    private static void isNullOrBlank(String str, String whatCanBeBlank) {
        if (String.isBlank(str)) {
            throw new ChatterPostServiceException(
                'The ' + whatCanBeBlank + ' is null or blank'
            );
        }
    }

    private class ChatterPostServiceException extends Exception {}

}
