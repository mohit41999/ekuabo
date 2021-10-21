class MostRecentBlog{
  bool status;
  String message;
  List<MostRecentBlogData> data=[];

  MostRecentBlog(this.status, this.message, this.data);
  MostRecentBlog.fromJson(Map<String, dynamic> json) {
    data=[];
    status = json['status'];
    message = json['message'];
    if(json['data']!=null)
      {
        json['data'].forEach((v) {
          data.add(MostRecentBlogData.fromJson(v));
        });
      }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['data'] = this.data;

    return data;
  }
}
class MostRecentBlogData{
  String blog_id,blog_title,blog_image,created,blog_desc;

  MostRecentBlogData(this.blog_id, this.blog_title, this.blog_image,
      this.created, this.blog_desc);
  MostRecentBlogData.fromJson(Map<String, dynamic> json) {
    blog_id = json['blog_id'];
    blog_title = json['blog_title'];
    blog_image = json['blog_image'];
    created = json['created'];
    blog_desc = json['blog_desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['blog_id'] = this.blog_id;
    data['blog_title'] = this.blog_title;
    data['blog_image'] = this.blog_image;
    data['created'] = this.created;
    data['blog_desc'] = this.blog_desc;
    return data;
  }
}