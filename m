From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Mon, 19 Jan 2015 08:23:04 +0000
Subject: [PATCH v2 5/7] staging: sm7xxfb: no space is necessary after a cast
Message-Id: <1421655067-7490-5-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1421655067-7490-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1421655067-7490-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org

checkpatch cleanup: space is not necessary after cast

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm7xxfb/sm7xxfb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/sm7xxfb/sm7xxfb.c b/drivers/staging/sm7xxfb/sm7xxfb.c
index 6bce9f1..6f0469a 100644
--- a/drivers/staging/sm7xxfb/sm7xxfb.c
+++ b/drivers/staging/sm7xxfb/sm7xxfb.c
@@ -352,8 +352,8 @@ static ssize_t smtcfb_read(struct fb_info *info, char __user *buf, size_t
 			dst++;
 		}
 		if (c & 3) {
-			u8 *dst8 = (u8 *) dst;
-			u8 __iomem *src8 = (u8 __iomem *) src;
+			u8 *dst8 = (u8 *)dst;
+			u8 __iomem *src8 = (u8 __iomem *)src;
 
 			for (i = c & 3; i--;) {
 				if (i & 1) {
@@ -363,7 +363,7 @@ static ssize_t smtcfb_read(struct fb_info *info, char __user *buf, size_t
 					src8 += 2;
 				}
 			}
-			src = (u32 __iomem *) src8;
+			src = (u32 __iomem *)src8;
 		}
 
 		if (copy_to_user(buf, buffer, c)) {
@@ -442,8 +442,8 @@ smtcfb_write(struct fb_info *info, const char __user *buf, size_t count,
 			src++;
 		}
 		if (c & 3) {
-			u8 *src8 = (u8 *) src;
-			u8 __iomem *dst8 = (u8 __iomem *) dst;
+			u8 *src8 = (u8 *)src;
+			u8 __iomem *dst8 = (u8 __iomem *)dst;
 
 			for (i = c & 3; i--;) {
 				if (i & 1) {
@@ -453,7 +453,7 @@ smtcfb_write(struct fb_info *info, const char __user *buf, size_t count,
 					dst8 += 2;
 				}
 			}
-			dst = (u32 __iomem *) dst8;
+			dst = (u32 __iomem *)dst8;
 		}
 
 		*ppos += c;
-- 
1.8.1.2

