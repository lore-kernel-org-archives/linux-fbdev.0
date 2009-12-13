From: Julia Lawall <julia@diku.dk>
Date: Sun, 13 Dec 2009 11:42:41 +0000
Subject: [PATCH 7/9] drivers/video: Correct code taking the size of a pointer
Message-Id: <Pine.LNX.4.64.0912131242240.24267@ask.diku.dk>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: JosephChan@via.com.tw, Scott Fang <ScottFang@viatech.com.cn>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

From: Julia Lawall <julia@diku.dk>

sizeof(viafb_gamma_table) is just the size of the pointer.  This is changed
to the size used when calling kmalloc to initialize the pointer.

A simplified version of the semantic patch that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
expression *x;
expression f;
type T;
@@

*f(...,(T)x,...)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/video/via/viafbdev.c        |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index 56ec696..a0b47f1 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -680,7 +680,7 @@ static int viafb_ioctl(struct fb_info *info, u_int cmd, u_long arg)
 		if (!viafb_gamma_table)
 			return -ENOMEM;
 		if (copy_from_user(viafb_gamma_table, argp,
-				sizeof(viafb_gamma_table))) {
+				256 * sizeof(u32))) {
 			kfree(viafb_gamma_table);
 			return -EFAULT;
 		}
@@ -694,7 +694,7 @@ static int viafb_ioctl(struct fb_info *info, u_int cmd, u_long arg)
 			return -ENOMEM;
 		viafb_get_gamma_table(viafb_gamma_table);
 		if (copy_to_user(argp, viafb_gamma_table,
-			sizeof(viafb_gamma_table))) {
+			256 * sizeof(u32))) {
 			kfree(viafb_gamma_table);
 			return -EFAULT;
 		}
