/**
 * @Author Elias Pinheiro
 * @Github @bmodeprogrammer
 * @Date 23/03/2019
 * @Desc Helper methods related with Id
 */
global inherited sharing class IdService {

    /**
     * Check if an string has a possible valid Id
     * @param  id String to make the test
     * @return  if the string id is valid return true, else false
     */
    global static Boolean isValidId(String idStr) {
        return String.isNotBlank(idStr) && idStr instanceOf Id;
    }

}
