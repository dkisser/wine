package org.lf.utils;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

public class EasyuiComboBox<K, V> {
	private Map<K, V> values;

	public EasyuiComboBox(TreeMap<K, V> values) {
		this.values = values;
	}
	
	public List<EasyuiComboBoxItem> getRecords() {
		Iterator<K> it = values.keySet().iterator();
		EasyuiComboBoxItem r;
		List<EasyuiComboBoxItem> rList = new ArrayList<>();
		K key;
		while (it.hasNext()) {
			key = it.next();
			r = new EasyuiComboBoxItem(key.toString(), values.get(key).toString());
			rList.add(r);
		}
		
		return rList;
	}

}
