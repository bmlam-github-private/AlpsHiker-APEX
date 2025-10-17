CREATE OR REPLACE function remove_xml_element (
	pi_text CLOB
	,pi_element_path VARCHAR2 
) RETURN CLOB 
AS 
	l_tmp_xml_in 	XMLType;
	l_tmp_xml_out 	XMLType;
BEGIN
    l_tmp_xml_in := XMLType( pi_text);
    l_tmp_xml_out := l_tmp_xml_in.deleteXML( pi_element_path );
    RETURN l_tmp_xml_out.getClobVal;

END;
/
show errors 

try this xsl approach, basic idea: the xlst itself is xmlType, does need valid names spaces, it process another xmlType using "brute" force


DECLARE
  l_xsl XMLTYPE := XMLTYPE(
    '<?xml version="1.0" encoding="UTF-8"?>
     <xsl:stylesheet version="1.0"
       xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

       <!-- Identity transform: copy everything -->
       <xsl:template match="@*|node()">
         <xsl:copy>
           <xsl:apply-templates select="@*|node()"/>
         </xsl:copy>
       </xsl:template>

       <!-- Template to remove attributes that start with "ab:" -->
       <xsl:template match="@*[starts-with(name(), ''ab:'')]"/>

     </xsl:stylesheet>'
  );
BEGIN
  UPDATE my_table t
  SET xml_col = XMLTRANSFORM(t.xml_col, l_xsl);
END;
/