From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 16 Jun 2015 13:54:08 +0000
Subject: [PATCH 5/8] staging: sm7xxfb: fix alignment
Message-Id: <1434462131-15191-5-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434462131-15191-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1434462131-15191-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Fix the alignment.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm7xxfb/sm7xxfb.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/sm7xxfb/sm7xxfb.c b/drivers/staging/sm7xxfb/sm7xxfb.c
index c832399..6bdcd5b 100644
--- a/drivers/staging/sm7xxfb/sm7xxfb.c
+++ b/drivers/staging/sm7xxfb/sm7xxfb.c
@@ -302,8 +302,8 @@ static int smtc_setcolreg(unsigned regno, unsigned red, unsigned green,
 }
 
 #ifdef __BIG_ENDIAN
-static ssize_t smtcfb_read(struct fb_info *info, char __user *buf, size_t
-				count, loff_t *ppos)
+static ssize_t smtcfb_read(struct fb_info *info, char __user *buf,
+			   size_t count, loff_t *ppos)
 {
 	unsigned long p = *ppos;
 
@@ -346,9 +346,8 @@ static ssize_t smtcfb_read(struct fb_info *info, char __user *buf, size_t
 		dst = buffer;
 		for (i = c >> 2; i--;) {
 			*dst = fb_readl(src++);
-			*dst -			    (*dst & 0xff00ff00 >> 8) |
-			    (*dst & 0x00ff00ff << 8);
+			*dst = (*dst & 0xff00ff00 >> 8) |
+			       (*dst & 0x00ff00ff << 8);
 			dst++;
 		}
 		if (c & 3) {
@@ -381,9 +380,8 @@ static ssize_t smtcfb_read(struct fb_info *info, char __user *buf, size_t
 	return (err) ? err : cnt;
 }
 
-static ssize_t
-smtcfb_write(struct fb_info *info, const char __user *buf, size_t count,
-	     loff_t *ppos)
+static ssize_t smtcfb_write(struct fb_info *info, const char __user *buf,
+			    size_t count, loff_t *ppos)
 {
 	unsigned long p = *ppos;
 
@@ -552,8 +550,7 @@ static void sm7xx_set_timing(struct smtcfb_info *sfb)
 	writel(0x0, sfb->vp_regs + 0x40);
 
 	/* set data width */
-	m_nscreenstride -		(sfb->width * sfb->fb->var.bits_per_pixel) / 64;
+	m_nscreenstride = (sfb->width * sfb->fb->var.bits_per_pixel) / 64;
 	switch (sfb->fb->var.bits_per_pixel) {
 	case 8:
 		writel(0x0, sfb->vp_regs + 0x0);
-- 
1.8.1.2

