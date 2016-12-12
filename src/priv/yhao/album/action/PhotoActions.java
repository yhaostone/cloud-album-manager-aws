package priv.yhao.album.action;

import priv.yhao.album.model.PhotoModel;

public class PhotoActions {
	/**
	 * save description
	 * @param photoName
	 * @param description
	 * @return 0-fail; 1-successful
	 */
	public int saveDescription(String photoName, String description){
		int result = 0;
		PhotoModel pm = new PhotoModel();
		result = pm.saveDescription(photoName,description);
		return result;
	}
}
