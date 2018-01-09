package data;

import com.sun.rowset.CachedRowSetImpl;

public class allForum {
    CachedRowSetImpl rs_mainForum,rs_sub_forum;
    public CachedRowSetImpl getRs_mainForum() {
        return rs_mainForum;
    }

    public void setRs_mainForum(CachedRowSetImpl rs_mainForum) {
        this.rs_mainForum = rs_mainForum;
    }

    public CachedRowSetImpl getRs_sub_forum() {
        return rs_sub_forum;
    }

    public void setRs_sub_forum(CachedRowSetImpl rs_sub_forum) {
        this.rs_sub_forum = rs_sub_forum;
    }




}
