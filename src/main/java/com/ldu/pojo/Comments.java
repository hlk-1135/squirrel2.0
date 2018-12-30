package com.ldu.pojo;
/**
 * 评论
 * @author lyq
 *
 */
public class Comments {
    private Integer id;
    private User user;
    private String createAt;
    private Integer goodsId;
    private Goods goods;
    private String content;
    
    public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	public Integer getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(Integer goodsId) {
		this.goodsId = goodsId;
	}


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	
    public String getCreateAt() {
        return createAt;
    }

    public void setCreateAt(String createAt) {
        this.createAt = createAt == null ? null : createAt.trim();
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

	@Override
	public String toString() {
		return "Comments [id=" + id + ", user=" + user + ", createAt=" + createAt + ", goodsId=" + goodsId + ", goods="
				+ goods + ", content=" + content + "]";
	}


 
	
    
    
}