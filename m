From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 18 Jun 2013 07:05:29 +0000
Subject: [patch] fbmem: return -EFAULT on copy_to_user() failure
Message-Id: <20130618070529.GA12329@elgon.mountain>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20121112110814.GB1678@elgon.mountain>
In-Reply-To: <20121112110814.GB1678@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

copy_to_user() returns the number of bytes remaining to be copied.
put_user() returns -EFAULT on error.

This function ORs a bunch of stuff together and returns jumbled non-zero
values on error.  It should return -EFAULT.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 098bfc6..9217be3 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1305,7 +1305,9 @@ static int do_fscreeninfo_to_user(struct fb_fix_screeninfo *fix,
 	err |= copy_to_user(fix32->reserved, fix->reserved,
 			    sizeof(fix->reserved));
 
-	return err;
+	if (err)
+		return -EFAULT;
+	return 0;
 }
 
 static int fb_get_fscreeninfo(struct fb_info *info, unsigned int cmd,
