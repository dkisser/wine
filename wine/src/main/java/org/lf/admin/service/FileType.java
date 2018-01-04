package org.lf.admin.service;
/** 
 * @author  wenchen 
 * @date 创建时间：2018年1月4日 下午2:19:04 
 * @version 1.0 
 * @parameter
 */
public enum FileType {

	JPEG("ffd8ffe000104a464946"),PNG("89504e470d0a1a0a0000"),GIF("47494638396126026f01"),
	HTML("3c21444f435459504520"),CSS("48544d4c207b0d0a0942"),JS("48544d4c207b0d0a0942"),
	XLSX("504b0304"),JAVA("7061636b616765207765"),SQL("494e5345525420494e54"),
	JSP("3c25402070616765206c"),JAR("504b03040a0000000000"),RAR("526172211a0700cf9073"),
	ZIP("526172211a0700cf9073"),MP3("49443303000000002176"),MP4("00000020667479706d70"),
	TXT("75736167"),DOC("d0cf11e0a1b11ae10000"),CLASS("cafebabe0000002e0041"),
	PROPERTIES("6c6f67346a2e726f6f74"),WPS("d0cf11e0a1b11ae10000");
	
	private String value;

	private FileType(String value) {
		this.value = value;
	}
	
	public String getValue(){
		return value;
	}
	
	public static FileType valueOf(int value) {
		return FileType.values()[value];
	}
	
}
