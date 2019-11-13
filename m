From: Sasha Levin <sashal@kernel.org>
Date: Wed, 13 Nov 2019 01:55:49 +0000
Subject: [PATCH AUTOSEL 4.14 082/115] fbdev: sbuslib: use checked version of put_user()
Message-Id: <20191113015622.11592-82-sashal@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191113015622.11592-1-sashal@kernel.org>
In-Reply-To: <20191113015622.11592-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Mathieu Malaterre <malat@debian.org>, dri-devel@lists.freedesktop.org, Philippe Ombredanne <pombredanne@nexb.com>, Dan Carpenter <dan.carpenter@oracle.com>, Peter Malone <peter.malone@gmail.com>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit d8bad911e5e55e228d59c0606ff7e6b8131ca7bf ]

I'm not sure why the code assumes that only the first put_user() needs
an access_ok() check.  I have made all the put_user() and get_user()
calls checked.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Mathieu Malaterre <malat@debian.org>
Cc: Peter Malone <peter.malone@gmail.com>,
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/sbuslib.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/video/fbdev/sbuslib.c b/drivers/video/fbdev/sbuslib.c
index a436d44f1b7fb..90c51330969c2 100644
--- a/drivers/video/fbdev/sbuslib.c
+++ b/drivers/video/fbdev/sbuslib.c
@@ -106,11 +106,11 @@ int sbusfb_ioctl_helper(unsigned long cmd, unsigned long arg,
 		struct fbtype __user *f = (struct fbtype __user *) arg;
 
 		if (put_user(type, &f->fb_type) ||
-		    __put_user(info->var.yres, &f->fb_height) ||
-		    __put_user(info->var.xres, &f->fb_width) ||
-		    __put_user(fb_depth, &f->fb_depth) ||
-		    __put_user(0, &f->fb_cmsize) ||
-		    __put_user(fb_size, &f->fb_cmsize))
+		    put_user(info->var.yres, &f->fb_height) ||
+		    put_user(info->var.xres, &f->fb_width) ||
+		    put_user(fb_depth, &f->fb_depth) ||
+		    put_user(0, &f->fb_cmsize) ||
+		    put_user(fb_size, &f->fb_cmsize))
 			return -EFAULT;
 		return 0;
 	}
@@ -125,10 +125,10 @@ int sbusfb_ioctl_helper(unsigned long cmd, unsigned long arg,
 		unsigned int index, count, i;
 
 		if (get_user(index, &c->index) ||
-		    __get_user(count, &c->count) ||
-		    __get_user(ured, &c->red) ||
-		    __get_user(ugreen, &c->green) ||
-		    __get_user(ublue, &c->blue))
+		    get_user(count, &c->count) ||
+		    get_user(ured, &c->red) ||
+		    get_user(ugreen, &c->green) ||
+		    get_user(ublue, &c->blue))
 			return -EFAULT;
 
 		cmap.len = 1;
@@ -165,10 +165,10 @@ int sbusfb_ioctl_helper(unsigned long cmd, unsigned long arg,
 		u8 red, green, blue;
 
 		if (get_user(index, &c->index) ||
-		    __get_user(count, &c->count) ||
-		    __get_user(ured, &c->red) ||
-		    __get_user(ugreen, &c->green) ||
-		    __get_user(ublue, &c->blue))
+		    get_user(count, &c->count) ||
+		    get_user(ured, &c->red) ||
+		    get_user(ugreen, &c->green) ||
+		    get_user(ublue, &c->blue))
 			return -EFAULT;
 
 		if (index + count > cmap->len)
-- 
2.20.1
