package org.lf.utils;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.SortedMap;
import java.util.TreeMap;

public class PageNavigator<T> {
	private TreeMap<Integer, T> records;
	private int pageSize;
	
	private int currentPageNum;

	/**
	 * 构造函数，用于生成TreeMap
	 * @param values
	 * @param pageSize
	 */
	public PageNavigator(Collection<T> values, int pageSize) {
		//参数检查
		if(values == null){
			throw new IllegalArgumentException("collection shoule be not null.");
		}
		
		if (pageSize <= 0) {
			throw new IllegalArgumentException("new page size should be great than 0.");
		}
		
		this.records = new TreeMap<Integer, T>();
		Iterator<T> it = values.iterator();
		int key = 0;
		while(it.hasNext()){
			key++;
			T value = it.next();
			this.records.put(key, value);
		}
		
		resetPage(pageSize);
	}
	
	/**
	 * 重新通过PageSize来分页
	 * @param newPageSize
	 * @return
	 */
	public PageNavigator<T> resetPage(int newPageSize) {
		//参数检查
		if (newPageSize <= 0) {
			throw new IllegalArgumentException("new page size should be great than 0.");
		}
		
		this.pageSize = newPageSize;
		this.currentPageNum = 1;
		
		return this;
	}
	
	/**
	 * 获取int型的PageSize
	 * @return
	 */
	public int getPageSize() {
		return pageSize;
	}
	
	/**
	 * 获取总共的页数
	 * @return
	 */
	public int getTotalPageCount() {
		return (this.records.size()/this.pageSize + 1);
	}

	/**
	 * 获取当前页页码
	 * @return
	 */
	public int getCurrentPageNum() {
		return currentPageNum;
	}
	
	/**
	 * 获取指定页的内容
	 * @param pageNum
	 * @return
	 */
	public List<T> getPage(int pageNum) {
		//参数检查
		if(pageNum <=0){
			throw new IllegalArgumentException("pageNum should be great than 0.");
		}
		if(pageNum > getTotalPageCount()){
			throw new IllegalArgumentException("pageNum should be small or equal than Total PageCount.");
		}
		
		int n = (pageNum-1)*this.pageSize+1;
		SortedMap<Integer, T> tm = this.records.subMap(n, n+this.pageSize);
		
		return (new ArrayList<T>(tm.values()));
		
	}
	
	/**
	 * 获取指定一页的某一条记录
	 * @param pageNum
	 * @param recordNum
	 * @return
	 */
	public T getRecord(int pageNum, int recordNum) {
		//参数检查
		if(pageNum <=0){
			throw new IllegalArgumentException("pageNum should be great than 0.");
		}
		if(pageNum > getTotalPageCount()){
			throw new IllegalArgumentException("pageNum should be small or equal than Total PageCount.");
		}
		if(recordNum <0){
			throw new IllegalArgumentException("recordNum should be great or equal than 0.");
		}
		if(recordNum > this.pageSize){
			throw new IllegalArgumentException("recordNum should be small or equal than pageSize.");
		}
		
		
		List<T> t = getPage(pageNum);	
		return t.get(recordNum);
	}
	
	/**
	 * 返回当前页信息
	 * @return
	 */
	public List<T> getCurrentPage() {
		int n = (this.currentPageNum-1)*this.pageSize+1;
		SortedMap<Integer, T> tm = this.records.subMap(n, n+this.pageSize);
		
		
		return (new ArrayList<T>(tm.values()));
	}
	
	/**
	 * 跳转到下一页
	 * @return
	 */
	public PageNavigator<T> next() {
		this.currentPageNum +=1;
		return this;
	}
	
	/**
	 * 跳转到前一页
	 * @return
	 */
	public PageNavigator<T> prior() {
		this.currentPageNum -=1;
		return this;
	}
	
	/**
	 * 跳转到第一页
	 * @return
	 */
	public PageNavigator<T> first() {
		this.currentPageNum = 1;
		return this;
	}
	
	/**
	 * 跳转到最后一页
	 * @return
	 */
	public PageNavigator<T> last() {
		this.currentPageNum = this.getTotalPageCount();
		return this;
	}
	
	/**
	 * 跳转到指定页
	 * @param pageNum
	 * @return
	 */
	public PageNavigator<T> go(int pageNum) {
		
		if(pageNum <=0){
			throw new IllegalArgumentException("pageNum should be great than 0.");
		}
		if(pageNum > getTotalPageCount()){
			throw new IllegalArgumentException("pageNum should be small or equal than Total PageCount.");
		}
		
		this.currentPageNum = pageNum;
		return this;
	}
}
