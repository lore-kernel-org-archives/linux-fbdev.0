From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 18 Sep 2020 10:09:06 +0000
Subject: [PATCH 3/3] fbdev: sbuslib: remove compat_alloc_user_space usage
Message-Id: <20200918100926.1447563-3-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200918100812.1447443-1-arnd@arndb.de>
In-Reply-To: <20200918100812.1447443-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: "David S . Miller" <davem@davemloft.net>, Arnd Bergmann <arnd@arndb.de>, hch@lst.de, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

This is one of the last users of compat_alloc_user_space()
and copy_in_user(). The actual handler is implemented in the
same file and could be shared, but as I couldn't test this
properly I leave the native case alone and just make a straight
copy of it for the compat case, with a minimum set of
modifications.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/sbuslib.c | 95 ++++++++++++++++++++++++++---------
 1 file changed, 70 insertions(+), 25 deletions(-)

diff --git a/drivers/video/fbdev/sbuslib.c b/drivers/video/fbdev/sbuslib.c
index f728db9bcff8..da28c279a54b 100644
--- a/drivers/video/fbdev/sbuslib.c
+++ b/drivers/video/fbdev/sbuslib.c
@@ -192,28 +192,6 @@ int sbusfb_ioctl_helper(unsigned long cmd, unsigned long arg,
 EXPORT_SYMBOL(sbusfb_ioctl_helper);
 
 #ifdef CONFIG_COMPAT
-static int fbiogetputcmap(struct fb_info *info, unsigned int cmd, unsigned long arg)
-{
-	struct fbcmap32 __user *argp = (void __user *)arg;
-	struct fbcmap __user *p = compat_alloc_user_space(sizeof(*p));
-	u32 addr;
-	int ret;
-
-	ret = copy_in_user(p, argp, 2 * sizeof(int));
-	ret |= get_user(addr, &argp->red);
-	ret |= put_user(compat_ptr(addr), &p->red);
-	ret |= get_user(addr, &argp->green);
-	ret |= put_user(compat_ptr(addr), &p->green);
-	ret |= get_user(addr, &argp->blue);
-	ret |= put_user(compat_ptr(addr), &p->blue);
-	if (ret)
-		return -EFAULT;
-	return info->fbops->fb_ioctl(info,
-			(cmd = FBIOPUTCMAP32) ?
-			FBIOPUTCMAP_SPARC : FBIOGETCMAP_SPARC,
-			(unsigned long)p);
-}
-
 int sbusfb_compat_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
 {
 	switch (cmd) {
@@ -230,9 +208,76 @@ int sbusfb_compat_ioctl(struct fb_info *info, unsigned int cmd, unsigned long ar
 	case FBIOGCURMAX:
 		return info->fbops->fb_ioctl(info, cmd, arg);
 	case FBIOPUTCMAP32:
-		return fbiogetputcmap(info, cmd, arg);
-	case FBIOGETCMAP32:
-		return fbiogetputcmap(info, cmd, arg);
+	case FBIOPUTCMAP_SPARC: {
+		struct fbcmap32 c;
+		struct fb_cmap cmap;
+		u16 red, green, blue;
+		u8 red8, green8, blue8;
+		unsigned char __user *ured;
+		unsigned char __user *ugreen;
+		unsigned char __user *ublue;
+		unsigned int i;
+
+		if (copy_from_user(&c, compat_ptr(arg), sizeof(c)))
+		       return -EFAULT;
+		ured = compat_ptr(c.red);
+		ugreen = compat_ptr(c.green);
+		ublue = compat_ptr(c.blue);
+
+		cmap.len = 1;
+		cmap.red = &red;
+		cmap.green = &green;
+		cmap.blue = &blue;
+		cmap.transp = NULL;
+		for (i = 0; i < c.count; i++) {
+			int err;
+
+			if (get_user(red8, &ured[i]) ||
+			    get_user(green8, &ugreen[i]) ||
+			    get_user(blue8, &ublue[i]))
+				return -EFAULT;
+
+			red = red8 << 8;
+			green = green8 << 8;
+			blue = blue8 << 8;
+
+			cmap.start = c.index + i;
+			err = fb_set_cmap(&cmap, info);
+			if (err)
+				return err;
+		}
+		return 0;
+	}
+	case FBIOGETCMAP32: {
+		struct fbcmap32 c;
+		unsigned char __user *ured;
+		unsigned char __user *ugreen;
+		unsigned char __user *ublue;
+		struct fb_cmap *cmap = &info->cmap;
+		unsigned int index, i;
+		u8 red, green, blue;
+
+		if (copy_from_user(&c, compat_ptr(arg), sizeof(c)))
+		       return -EFAULT;
+		index = c.index;
+		ured = compat_ptr(c.red);
+		ugreen = compat_ptr(c.green);
+		ublue = compat_ptr(c.blue);
+
+		if (index > cmap->len || c.count > cmap->len - index)
+			return -EINVAL;
+
+		for (i = 0; i < c.count; i++) {
+			red = cmap->red[index + i] >> 8;
+			green = cmap->green[index + i] >> 8;
+			blue = cmap->blue[index + i] >> 8;
+			if (put_user(red, &ured[i]) ||
+			    put_user(green, &ugreen[i]) ||
+			    put_user(blue, &ublue[i]))
+				return -EFAULT;
+		}
+		return 0;
+	}
 	default:
 		return -ENOIOCTLCMD;
 	}
-- 
2.27.0
