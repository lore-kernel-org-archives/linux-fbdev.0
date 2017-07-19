From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Wed, 19 Jul 2017 05:28:55 +0000
Subject: [PATCH] video: fbdev: uvesafb: constify attribute_group structures.
Message-Id: <aa3e89c4a81699a5e7799f9c20cc7a123e2fce37.1500441256.git.arvind.yadav.cs@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spock@gentoo.org, b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

attribute_group are not supposed to change at runtime. All functions
working with attribute_group provided by <linux/sysfs.h> work
with const attribute_group. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
  15426	   4952	    187	  20565	   5055	drivers/video/fbdev/uvesafb.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  15490	   4888	    187	  20565	   5055	drivers/video/fbdev/uvesafb.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/video/fbdev/uvesafb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index dc0e8d9..ad05d25f 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -1666,7 +1666,7 @@ static DEVICE_ATTR(nocrtc, S_IRUGO | S_IWUSR, uvesafb_show_nocrtc,
 	NULL,
 };
 
-static struct attribute_group uvesafb_dev_attgrp = {
+static const struct attribute_group uvesafb_dev_attgrp = {
 	.name = NULL,
 	.attrs = uvesafb_dev_attrs,
 };
-- 
1.9.1

