From: Rusty Russell <rusty@rustcorp.com.au>
Date: Mon, 28 Jul 2014 11:43:27 +0000
Subject: Re: [rusty:modules-next 4/7] include/linux/sysfs.h:75:12: note: in expansion of macro 'VERIFY_OCTAL_
Message-Id: <87k36xwwhc.fsf@rustcorp.com.au>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Thanks robot!

Looks like drivers/video/fbdev/s3c2410fb.c has a world-writable debug
file.  If you really want this I'll have to make an exception,
otherwise, please ack this patch:


drivers/video/fbdev/s3c2410fb.c: don't make debug world-writable.

We don't want random users to be able to spam the logs, and commit
37549e94c77a94a9c32b5ae3313a3801cb66adf9 (sysfs: disallow
world-writable files.) finally makes this a build error.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>.    

diff --git a/drivers/video/fbdev/s3c2410fb.c b/drivers/video/fbdev/s3c2410fb.c
index 81af5a63e9e1..6796d9d6c871 100644
--- a/drivers/video/fbdev/s3c2410fb.c
+++ b/drivers/video/fbdev/s3c2410fb.c
@@ -616,7 +616,7 @@ static int s3c2410fb_debug_store(struct device *dev,
 	return len;
 }
 
-static DEVICE_ATTR(debug, 0666, s3c2410fb_debug_show, s3c2410fb_debug_store);
+static DEVICE_ATTR(debug, 0664, s3c2410fb_debug_show, s3c2410fb_debug_store);
 
 static struct fb_ops s3c2410fb_ops = {
 	.owner		= THIS_MODULE,

Cheers,
Rusty.

kbuild test robot <fengguang.wu@intel.com> writes:

> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/rusty/linux.git modules-next
> head:   2e3a10a1551d6ceea005e6a62ca58183b8976217
> commit: 37549e94c77a94a9c32b5ae3313a3801cb66adf9 [4/7] sysfs: disallow world-writable files.
> config: make ARCH=arm s3c2410_defconfig
>
> All warnings:
>
>    In file included from include/linux/thread_info.h:11:0,
>                     from include/asm-generic/preempt.h:4,
>                     from arch/arm/include/generated/asm/preempt.h:1,
>                     from include/linux/preempt.h:18,
>                     from include/linux/spinlock.h:50,
>                     from include/linux/seqlock.h:35,
>                     from include/linux/time.h:5,
>                     from include/linux/stat.h:18,
>                     from include/linux/module.h:10,
>                     from drivers/video/fbdev/s3c2410fb.c:16:
>    include/linux/bug.h:33:45: error: negative width in bit-field '<anonymous>'
>     #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
>                                                 ^
>    include/linux/kernel.h:853:3: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
>       BUILD_BUG_ON_ZERO((perms) & 2) +    \
>       ^
>>> include/linux/sysfs.h:75:12: note: in expansion of macro 'VERIFY_OCTAL_PERMISSIONS'
>        .mode = VERIFY_OCTAL_PERMISSIONS(_mode) },  \
>                ^
>>> include/linux/device.h:539:45: note: in expansion of macro '__ATTR'
>      struct device_attribute dev_attr_##_name = __ATTR(_name, _mode, _show, _store)
>                                                 ^
>>> drivers/video/fbdev/s3c2410fb.c:619:8: note: in expansion of macro 'DEVICE_ATTR'
>     static DEVICE_ATTR(debug, 0666, s3c2410fb_debug_show, s3c2410fb_debug_store);
>            ^
>
> vim +/VERIFY_OCTAL_PERMISSIONS +75 include/linux/sysfs.h
>
> 6992f533 Eric W. Biederman  2010-02-11  59  
> ^1da177e Linus Torvalds     2005-04-16  60  struct attribute_group {
> 59f69015 Tejun Heo          2007-09-20  61  	const char		*name;
> 587a1f16 Al Viro            2011-07-23  62  	umode_t			(*is_visible)(struct kobject *,
> d4acd722 James Bottomley    2007-10-31  63  					      struct attribute *, int);
> 59f69015 Tejun Heo          2007-09-20  64  	struct attribute	**attrs;
> 6ab9cea1 Greg Kroah-Hartman 2013-07-14  65  	struct bin_attribute	**bin_attrs;
> ^1da177e Linus Torvalds     2005-04-16  66  };
> ^1da177e Linus Torvalds     2005-04-16  67  
> ^1da177e Linus Torvalds     2005-04-16  68  /**
> ^1da177e Linus Torvalds     2005-04-16  69   * Use these macros to make defining attributes easier. See include/linux/device.h
> ^1da177e Linus Torvalds     2005-04-16  70   * for examples..
> ^1da177e Linus Torvalds     2005-04-16  71   */
> ^1da177e Linus Torvalds     2005-04-16  72  
> 5da5c9c8 Greg Kroah-Hartman 2013-08-21  73  #define __ATTR(_name, _mode, _show, _store) {				\
> 58f86cc8 Rusty Russell      2014-03-24  74  	.attr = {.name = __stringify(_name),				\
> 58f86cc8 Rusty Russell      2014-03-24 @75  		 .mode = VERIFY_OCTAL_PERMISSIONS(_mode) },		\
> aa01aa3c Oliver Schinagl    2013-07-14  76  	.show	= _show,						\
> aa01aa3c Oliver Schinagl    2013-07-14  77  	.store	= _store,						\
> ^1da177e Linus Torvalds     2005-04-16  78  }
> ^1da177e Linus Torvalds     2005-04-16  79  
> aa01aa3c Oliver Schinagl    2013-07-14  80  #define __ATTR_RO(_name) {						\
> aa01aa3c Oliver Schinagl    2013-07-14  81  	.attr	= { .name = __stringify(_name), .mode = S_IRUGO },	\
> aa01aa3c Oliver Schinagl    2013-07-14  82  	.show	= _name##_show,						\
> ^1da177e Linus Torvalds     2005-04-16  83  }
>
> :::::: The code at line 75 was first introduced by commit
> :::::: 58f86cc89c3372d3e61d5b71e5513ec5a0b02848 VERIFY_OCTAL_PERMISSIONS: stricter checking for sysfs perms.
>
> :::::: TO: Rusty Russell <rusty@rustcorp.com.au>
> :::::: CC: Rusty Russell <rusty@rustcorp.com.au>
>
> ---
> 0-DAY kernel build testing backend              Open Source Technology Center
> http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
