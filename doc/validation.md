#pig使用Hibernate Validator 校验参数说明
###简单参数校验使用

1. 在model实体类需要校验的字段增加注解
    ~~~
    @Data
    public class SysLog implements Serializable {
    
        private static final long serialVersionUID = 1L;
    
        /**
         * 编号
         */
        @TableId(value = "id", type = IdType.AUTO)
        @ApiModelProperty(value = "日志编号")
        @JsonSerialize(using = ToStringSerializer.class)
        private Long id;
    
        /**
         * 日志类型
         */
        @NotBlank(message = "日志类型不能为空")
        @ApiModelProperty(value = "日志类型")
        private String type;
    
        /**
         * 日志标题
         */
        @NotBlank(message = "日志标题不能为空")
        @ApiModelProperty(value = "日志标题")
        private String title;
        
        //略
        
    }
    ~~~
2. Controller 中需要校验的参数Bean前添加 @Valid 开启校验功能
    ~~~
   //controller增加@Valid注解校验
    @Inner
	@PostMapping
	public R save(@Valid @RequestBody SysLog sysLog) {
		return R.ok(sysLogService.save(sysLog));
	}
   ~~~
### 内置注解
1. Bean Validation 中内置的 constraint

   | Constraint | 详细信息 |
   | ---------- | -------- |
   | @Null                       | 被注释的元素必须为 null                                  |
| @NotNull                    | 被注释的元素必须不为 null                                |
| @AssertTrue                 | 被注释的元素必须为 true                                  |
| @AssertFalse                | 被注释的元素必须为 false                                 |
| @Min(value)                 | 被注释的元素必须是一个数字，其值必须大于等于指定的最小值 |
| @Max(value)                 | 被注释的元素必须是一个数字，其值必须小于等于指定的最大值 |
| @DecimalMin(value)          | 被注释的元素必须是一个数字，其值必须大于等于指定的最小值 |
| @DecimalMax(value)          | 被注释的元素必须是一个数字，其值必须小于等于指定的最大值 |
| @Size(max, min)             | 被注释的元素的大小必须在指定的范围内                     |
| @Digits (integer, fraction) | 被注释的元素必须是一个数字，其值必须在可接受的范围内     |
| @Past                       | 被注释的元素必须是一个过去的日期                         |
| @Future                     | 被注释的元素必须是一个将来的日期                         |
| @Pattern(value)             | 被注释的元素必须符合指定的正则表达式                     |

2. Hibernate Validator 附加的 constraint

   | Constraint | 详细信息                               |
   | ---------- | :------------------------------------- |
   | @Email     | 被注释的元素必须是电子邮箱地址         |
   | @Length    | 被注释的字符串的大小必须在指定的范围内 |
   | @NotEmpty  | 被注释的字符串的必须非空               |
   | @Range     | 被注释的元素必须在合适的范围内         |

###分组校验使用

1. 指定添加和更新两个分组

   ~~~java
   public class Groups {
       public interface Add{}
       public interface  Update{}
   }
   ~~~

2. 给参数对象的校验注解添加分组

   ~~~java
    @Data
       public class User {
           //注解指定groups
           @Null(message = "新增不需要指定id" , groups = Groups.Add.class)
           @NotNull(message = "修改需要指定id" , groups = Groups.Update.class)
           private Integer id;
           @NotBlank(message = "用户名不能为空")
           @NotNull
           private String username;
           private String password;
           @Email
           private String email;
           private Integer gender;
       }
   ~~~

3. Controller 中原先的@Valid不能指定分组 ，需要替换成@Validated

   ~~~java
   @RestController
   @RequestMapping("/user")
   public class UserController {
       @PostMapping("")
       public Result save (@Validated({Groups.Add.class}) User user)  {
           return Result.ok();
       }
   
   }
   ~~~

###自定义注解
 ####例如User中的gender，用 1代表男 2代表女，我们自定义一个校验注解@ListValue，指定取值只能1和2

1. 创建约束规则

   ~~~java
   @Documented
   @Constraint(validatedBy = { ListValueConstraintValidator.class })
   @Target({ METHOD, FIELD, ANNOTATION_TYPE })
   @Retention(RUNTIME)
   public @interface ListValue {
        String message() default "";
       Class<?>[] groups() default { };
   
       Class<? extends Payload>[] payload() default { };
   
       int[] vals() default { };
    }
   ~~~

+ @Target({ METHOD, FIELD, ANNOTATION_TYPE }): 表示此注解可以被用在方法, 字段或者
      annotation声明上。
+ @Retention(RUNTIME): 表示这个标注信息是在运行期通过反射被读取的.
+ @Constraint(validatedBy = ListValueConstraintValidator.class): 指明使用哪个校验器(类) 去校验使用了此标注的元素.
+ @Documented: 表示在对使用了该注解的类进行javadoc操作到时候, 这个标注会被添加到
      javadoc当中.

 2. 创建约束校验器

    ~~~java
    import javax.validation.ConstraintValidator;
    import javax.validation.ConstraintValidatorContext;
    import java.util.HashSet;
    import java.util.Set;
    
    public class ListValueConstraintValidator implements ConstraintValidator<ListValue,Integer> {
    
        private Set<Integer> set = new HashSet<>();
        /**
         * 初始化方法
         */
        @Override
        public void initialize(ListValue constraintAnnotation) {
    
            int[] vals = constraintAnnotation.vals();
            for (int val : vals) {
                set.add(val);
            }
    
        }
    
        /**
         * 判断是否校验成功
         *
         * @param value 需要校验的值
         * @param context
         * @return
         */
        @Override
        public boolean isValid(Integer value, ConstraintValidatorContext context) {
    
            return set.contains(value);
        }
    }
    ~~~

 3. model中使用

    ~~~java
    @Data
        public class User {
        
            @Null(message = "新增不需要指定id" , groups = Groups.Add.class)
            @NotNull(message = "修改需要指定id" , groups = Groups.Update.class)
            private Integer id;
            @NotBlank(message = "用户名不能为空")
            @NotNull
            private String username;
            @Pattern(regexp = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$", message = "密码必须为8~16个字母和数字组合")
            private String password;
            @Email
            private String email;
            @ListValue( message = "性别应指定相应的值" , vals = {1,2} , groups = {Groups.Add.class , Groups.Update.class})
            private Integer gender;
        
        }
    ~~~

 4. Controller中需要校验的参数Bean前添加@Valid开启校验功能即可

