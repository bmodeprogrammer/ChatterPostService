/**
 * @Author Elias Pinheiro
 * @Github @bmodeprogrammer
 * @Date 23/03/2019
 * @Desc Testing IdService class
 */
@isTest(isParallel=true)
public class IdServiceTest {
    
    @isTest
    static void testIsValidId() {
        //testing real salesforce id 15 characters
        System.assertEquals(true, IdService.isValidId('0061r00000wyZHH'));
        //testing real salesforce id 18 characters
        System.assertEquals(true, IdService.isValidId('0061r00000wyZHHAA2'));
        //testing invalid salesforce id 18 characters
        System.assertEquals(false, IdService.isValidId('a5s4d5aw8AS78A-KLP'));
        //testing invalid salesforce id 15 characters
        System.assertEquals(false, IdService.isValidId('a5s4d5aw8AS78A-'));
        //testing null
        System.assertEquals(false, IdService.isValidId(null));
        //testing other lenght of carachters
        System.assertEquals(false, IdService.isValidId('1234567891'));
    }

}
