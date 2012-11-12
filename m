From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 12 Nov 2012 11:08:14 +0000
Subject: [patch] fbmem: return -EFAULT on copy_to_user() failure
Message-Id: <20121112110814.GB1678@elgon.mountain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

copy_to_user() returns the number of bytes remaining to be copied.
put_user() returns -EFAULT on error.

This function ORs a bunch of stuff together and returns jumbled non-zero
values on error.  It should return -EFAULT.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 3ff0105..3d2a4d0 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1302,8 +1302,9 @@ static int do_fscreeninfo_to_user(struct fb_fix_screeninfo *fix,
 	err |= put_user(fix->accel, &fix32->accel);
 	err |= copy_to_user(fix32->reserved, fix->reserved,
 			    sizeof(fix->reserved));
-
-	return err;
+	if (err)
+		return -EFAULT;
+	return 0;
 }
 
 static int fb_get_fscreeninfo(struct fb_info *info, unsigned int cmd,
