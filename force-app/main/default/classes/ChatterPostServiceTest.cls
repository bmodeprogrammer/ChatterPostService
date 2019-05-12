/**
MIT License

Copyright (c) 2019 Elias Pinheiro

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/
/**
 * @Author Elias Pinheiro
 * @Github @bmodeprogrammer
 * @Date 23/03/2019
 * @Desc Testing ChaterPostService class
 */
@isTest
public class ChatterPostServiceTest {
    
    @isTest
    static void testPost() {

        String firstText = 'Hey there ';
        String tag = 'salesforce';
        String firstUrl = System.URL.getSalesforceBaseUrl().toExternalForm() + '/' + UserInfo.getUserId();
        ConnectApi.FeedItemInput fItemInput =  new ChatterPostService(UserInfo.getUserId(), ConnectApi.FeedElementType.FeedItem)
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
            .endUnorderedList()//32
            .beginHyperlink(firstUrl)//33
            .endHyperlink()//34
            //get the input for sending
            .getFeedItemInput();

        System.assertEquals(35, fItemInput.body.messageSegments.size());

        //testing addText
        System.assert(fItemInput.body.messageSegments[0] instanceof ConnectApi.TextSegmentInput);
        ConnectApi.TextSegmentInput tInput = (ConnectApi.TextSegmentInput) fItemInput.body.messageSegments[0];
        System.assertEquals(firstText, tInput.text);

        //testing addUserOrGroupMentionById
        System.assert(fItemInput.body.messageSegments[1] instanceof ConnectApi.MentionSegmentInput);
        ConnectApi.MentionSegmentInput mentionSegment = (ConnectApi.MentionSegmentInput) fItemInput.body.messageSegments[1];
        System.assertEquals(UserInfo.getUserId(), mentionSegment.Id);

        //testing beginOrderedList
        System.assert(fItemInput.body.messageSegments[3] instanceof ConnectApi.MarkupBeginSegmentInput);
        ConnectApi.MarkupBeginSegmentInput olBegin = (ConnectApi.MarkupBeginSegmentInput) fItemInput.body.messageSegments[3];
        System.assertEquals(ConnectApi.MarkupType.OrderedList, olBegin.markupType);

        //testing beginListItem
        System.assert(fItemInput.body.messageSegments[4] instanceof ConnectApi.MarkupBeginSegmentInput);
        ConnectApi.MarkupBeginSegmentInput liBegin = (ConnectApi.MarkupBeginSegmentInput) fItemInput.body.messageSegments[4];
        System.assertEquals(ConnectApi.MarkupType.ListItem, liBegin.markupType);

        //testing beginItalic
        System.assert(fItemInput.body.messageSegments[5] instanceof ConnectApi.MarkupBeginSegmentInput);
        ConnectApi.MarkupBeginSegmentInput italicBegin = (ConnectApi.MarkupBeginSegmentInput) fItemInput.body.messageSegments[5];
        System.assertEquals(ConnectApi.MarkupType.Italic, italicBegin.markupType);
        
        //testing beginBold
        System.assert(fItemInput.body.messageSegments[6] instanceof ConnectApi.MarkupBeginSegmentInput);
        ConnectApi.MarkupBeginSegmentInput boldBegin = (ConnectApi.MarkupBeginSegmentInput) fItemInput.body.messageSegments[6];
        System.assertEquals(ConnectApi.MarkupType.Bold, boldBegin.markupType);
       
        //testing endBold
        System.assert(fItemInput.body.messageSegments[8] instanceof ConnectApi.MarkupEndSegmentInput);
        ConnectApi.MarkupEndSegmentInput endBold = (ConnectApi.MarkupEndSegmentInput) fItemInput.body.messageSegments[8];
        System.assertEquals(ConnectApi.MarkupType.Bold, endBold.markupType);
        
        //testing endItalic
        System.assert(fItemInput.body.messageSegments[9] instanceof ConnectApi.MarkupEndSegmentInput);
        ConnectApi.MarkupEndSegmentInput endItalic = (ConnectApi.MarkupEndSegmentInput) fItemInput.body.messageSegments[9];
        System.assertEquals(ConnectApi.MarkupType.Italic, endItalic.markupType);
        
        //testing endLI
        System.assert(fItemInput.body.messageSegments[10] instanceof ConnectApi.MarkupEndSegmentInput);
        ConnectApi.MarkupEndSegmentInput endLI = (ConnectApi.MarkupEndSegmentInput) fItemInput.body.messageSegments[10];
        System.assertEquals(ConnectApi.MarkupType.ListItem, endLI.markupType);
        
        //testing beginHyperlink
        System.assert(fItemInput.body.messageSegments[12] instanceof ConnectApi.MarkupBeginSegmentInput);
        ConnectApi.MarkupBeginSegmentInput beginHyperlink = (ConnectApi.MarkupBeginSegmentInput) fItemInput.body.messageSegments[12];
        System.assertEquals(ConnectApi.MarkupType.HYPERLINK, beginHyperlink.markupType);
        System.assertEquals(UserInfo.getLastName(), beginHyperlink.altText);
        System.assertEquals(firstUrl, beginHyperlink.url);

        //testing endHyperlink
        System.assert(fItemInput.body.messageSegments[14] instanceof ConnectApi.MarkupEndSegmentInput);
        ConnectApi.MarkupEndSegmentInput endHyperlink = (ConnectApi.MarkupEndSegmentInput) fItemInput.body.messageSegments[14];
        System.assertEquals(ConnectApi.MarkupType.HYPERLINK, endHyperlink.markupType);

        //testing addLink
        System.assert(fItemInput.body.messageSegments[17] instanceof ConnectApi.LinkSegmentInput);
        ConnectApi.LinkSegmentInput addLink = (ConnectApi.LinkSegmentInput) fItemInput.body.messageSegments[17];
        System.assertEquals(firstUrl, addLink.url);

        //testing beginParagraph
        System.assert(fItemInput.body.messageSegments[20] instanceof ConnectApi.MarkupBeginSegmentInput);
        ConnectApi.MarkupBeginSegmentInput beginParagraph = (ConnectApi.MarkupBeginSegmentInput) fItemInput.body.messageSegments[20];
        System.assertEquals(ConnectApi.MarkupType.PARAGRAPH, beginParagraph.markupType);

        //testing beginStrike
        System.assert(fItemInput.body.messageSegments[21] instanceof ConnectApi.MarkupBeginSegmentInput);
        ConnectApi.MarkupBeginSegmentInput beginStrike = (ConnectApi.MarkupBeginSegmentInput) fItemInput.body.messageSegments[21];
        System.assertEquals(ConnectApi.MarkupType.STRIKETHROUGH, beginStrike.markupType);

        //testing beginUnderline
        System.assert(fItemInput.body.messageSegments[22] instanceof ConnectApi.MarkupBeginSegmentInput);
        ConnectApi.MarkupBeginSegmentInput beginUnderline = (ConnectApi.MarkupBeginSegmentInput) fItemInput.body.messageSegments[22];
        System.assertEquals(ConnectApi.MarkupType.UNDERLINE, beginUnderline.markupType);

        //testing endUnderline
        System.assert(fItemInput.body.messageSegments[24] instanceof ConnectApi.MarkupEndSegmentInput);
        ConnectApi.MarkupEndSegmentInput endUnderline = (ConnectApi.MarkupEndSegmentInput) fItemInput.body.messageSegments[24];
        System.assertEquals(ConnectApi.MarkupType.UNDERLINE, endUnderline.markupType);

        //testing endStrike
        System.assert(fItemInput.body.messageSegments[25] instanceof ConnectApi.MarkupEndSegmentInput);
        ConnectApi.MarkupEndSegmentInput endStrike = (ConnectApi.MarkupEndSegmentInput) fItemInput.body.messageSegments[25];
        System.assertEquals(ConnectApi.MarkupType.STRIKETHROUGH, endStrike.markupType);

        //testing endParagraph
        System.assert(fItemInput.body.messageSegments[26] instanceof ConnectApi.MarkupEndSegmentInput);
        ConnectApi.MarkupEndSegmentInput endParagraph = (ConnectApi.MarkupEndSegmentInput) fItemInput.body.messageSegments[26];
        System.assertEquals(ConnectApi.MarkupType.PARAGRAPH, endParagraph.markupType);

        //testing addHashtag
        System.assert(fItemInput.body.messageSegments[27] instanceof ConnectApi.HashtagSegmentInput);
        ConnectApi.HashtagSegmentInput addHashtag = (ConnectApi.HashtagSegmentInput) fItemInput.body.messageSegments[27];
        System.assertEquals(tag, addHashtag.tag);

        //testing beginCode
        System.assert(fItemInput.body.messageSegments[28] instanceof ConnectApi.MarkupBeginSegmentInput);
        ConnectApi.MarkupBeginSegmentInput beginCode = (ConnectApi.MarkupBeginSegmentInput) fItemInput.body.messageSegments[28];
        System.assertEquals(ConnectApi.MarkupType.CODE, beginCode.markupType);
        
        //testing endCode
        System.assert(fItemInput.body.messageSegments[30] instanceof ConnectApi.MarkupEndSegmentInput);
        ConnectApi.MarkupEndSegmentInput endCode = (ConnectApi.MarkupEndSegmentInput) fItemInput.body.messageSegments[30];
        System.assertEquals(ConnectApi.MarkupType.CODE, endCode.markupType);
        
        //testing beginUnorderedList
        System.assert(fItemInput.body.messageSegments[31] instanceof ConnectApi.MarkupBeginSegmentInput);
        ConnectApi.MarkupBeginSegmentInput beginUnorderedList = (ConnectApi.MarkupBeginSegmentInput) fItemInput.body.messageSegments[31];
        System.assertEquals(ConnectApi.MarkupType.UNORDEREDLIST, beginUnorderedList.markupType);
        
        //testing endUnorderedList
        System.assert(fItemInput.body.messageSegments[32] instanceof ConnectApi.MarkupEndSegmentInput);
        ConnectApi.MarkupEndSegmentInput endUnorderedList = (ConnectApi.MarkupEndSegmentInput) fItemInput.body.messageSegments[32];
        System.assertEquals(ConnectApi.MarkupType.UNORDEREDLIST, endUnorderedList.markupType);

        //testing beginHyperlink without altText
        System.assert(fItemInput.body.messageSegments[33] instanceof ConnectApi.MarkupBeginSegmentInput);
        beginHyperlink = (ConnectApi.MarkupBeginSegmentInput) fItemInput.body.messageSegments[33];
        System.assertEquals(ConnectApi.MarkupType.HYPERLINK, beginHyperlink.markupType);
        System.assertEquals(null, beginHyperlink.altText);
        System.assertEquals(firstUrl, beginHyperlink.url);

        //testing endHyperlink without altText
        System.assert(fItemInput.body.messageSegments[34] instanceof ConnectApi.MarkupEndSegmentInput);
        endHyperlink = (ConnectApi.MarkupEndSegmentInput) fItemInput.body.messageSegments[34];
        System.assertEquals(ConnectApi.MarkupType.HYPERLINK, endHyperlink.markupType);
        
    }

}