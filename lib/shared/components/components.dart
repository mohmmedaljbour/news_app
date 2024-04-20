
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view_screen.dart';
import 'package:news_app/shared/cubit/cubit.dart';

Widget myDivider ()=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);
Widget buildArticleItem(article , context)=>InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(article['url']));
  },
  child:   Padding(
  
    padding: const EdgeInsets.all(20.0),
  
    child: Row(
  
      children: [
  
        Container(
  
          width: 120.0,
  
          height: 120.0,
  
          decoration: BoxDecoration(
  
              borderRadius: BorderRadius.circular(10.0),
  
              image: DecorationImage(
  
                  image: NetworkImage('${article['urlToImage']}'),
  
                  fit: BoxFit.cover
  
              )
          ),
        ),
  
        const SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Container(
            height: 120.0,
            child: Column(
  
              mainAxisAlignment: MainAxisAlignment.start,
  
              crossAxisAlignment: CrossAxisAlignment.start,
  
              children: [
  
                Expanded(
  
                  child: Text(
                    '${article['title']}',
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
  
                ),
  
                Text(
  
                  '${article['publishedAt']}',
  
                  style: TextStyle(
  
                    color: Colors.grey,
  
                  ),
  
                ),
  
              ],
  
            ),
  
          ),
  
        )
  
      ],
  
    ),
  
  ),
);
Widget articleBuilder(list , context, {isSearch = false})=>ConditionalBuilder(
    condition: list.length > 0 ,
    builder: (context)=>ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context,index)=>buildArticleItem(list[index] , context),
        separatorBuilder: (context,index)=>myDivider(),
        itemCount: 10 ),
    fallback: (context)=> isSearch ? Container() : Center(child: CircularProgressIndicator()));
Widget defaultTextForm({
  required TextEditingController controller,
  required TextInputType type ,
  var onSubmit,
  var onChanged,
  var onTap,
  required var validate,
  required String? label,
  required IconData prefix,
  IconData? suffix,
  var suffixPressed,
  bool isPassword = false

})=>TextFormField(
  validator: validate,

  controller: controller,
  keyboardType: type,
  onFieldSubmitted: onSubmit,
  onChanged: onChanged,
  obscureText: isPassword,
  onTap: onTap ,
  decoration:  InputDecoration(
    labelText: label,
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: suffix != null ? IconButton(
      onPressed: suffixPressed,
      icon: Icon(
        suffix,
      ),
    ) : null,
    border: OutlineInputBorder(),

  ),
);
void navigateTo( context , widget)=>Navigator.push(
    context,
    MaterialPageRoute(builder: (context)=>widget,
    )
);