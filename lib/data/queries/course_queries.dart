final String getCoursesQuery = r'''
query getCoursesQuery ($lang_slug: String!, $start: Int!, $limit: Int!){
    LangCourse: courses (start: $start, limit: $limit,where:{
      _where:[{language:{slug:$lang_slug}}
        ]
    }){
        questions{
          id
        }
        slides{
          id
        }
    title
    description
    publisher{
      name
      avatar{
        url
      }
    }
    category{
      cover_photo{
        url
      }
      category_name
    }
    is_recommended
    course_group{
      slug
    }
  }
}
''';

final String getCourse = r'''
query getCourseQuery ($group_slug: String!, $lang_slug: String!){
    courses (where:{
      _where:[{
        language:{slug:$lang_slug}
      }
        {
          course_group:{slug:$group_slug}
        }]
    }){
        questions{
            question
            alternatives{
                alternative_text
                image{
                    url
                }
                is_correct
            }
            clarification
        }
        slides{
            title
            description
            media{
                url
            }
        }
    title
    description
    language{
      language_full_name
      slug
    }
    publisher{
      name
      avatar{
        url
      }
    }
    category{
      cover_photo{
        url
      }
      category_name
    }
    is_recommended
    course_group{
      name
      slug
    }
    }
}
''';

final String getRecommendedCoursesQuery = r'''
query getRecommendedCoursesQuery ($lang_slug: String!, $start: Int!, $limit: Int!){
    LangCourse: courses (start: $start, limit: $limit,where:{
      _where:[
        {language:{slug:$lang_slug}}
        {is_recommended:true}
        ]
    }){
        questions{
          id
        }
        slides{
          id
        }
    title
    description
    publisher{
      name
      avatar{
        url
      }
    }
    category{
      cover_photo{
        url
      }
      category_name
    }
    is_recommended
    course_group{
      slug
    }
  }
}
''';
