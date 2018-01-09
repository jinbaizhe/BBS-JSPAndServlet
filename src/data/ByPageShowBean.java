package data;
import com.sun.rowset.*;
public class ByPageShowBean {
	CachedRowSetImpl rowset = null;
	int pageSize = 5;
	int totalPages = 1;
	int currentPage = 1;
	public CachedRowSetImpl getRowset() {
		return rowset;
	}
	public void setRowset(CachedRowSetImpl rowset) {
		this.rowset = rowset;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getTotalPages() {
		return totalPages;
	}
	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

}
