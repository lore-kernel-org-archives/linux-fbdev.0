From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 16 Jun 2015 13:54:07 +0000
Subject: [PATCH 4/8] staging: sm7xxfb: no space after cast
Message-Id: <1434462131-15191-4-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434462131-15191-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1434462131-15191-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

fixes the checkpatch warning about using space after typecast.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm7xxfb/sm7xxfb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm7xxfb/sm7xxfb.c b/drivers/staging/sm7xxfb/sm7xxfb.c
index f18fef9..c832399 100644
--- a/drivers/staging/sm7xxfb/sm7xxfb.c
+++ b/drivers/staging/sm7xxfb/sm7xxfb.c
@@ -336,7 +336,7 @@ static ssize_t smtcfb_read(struct fb_info *info, char __user *buf, size_t
 	if (!buffer)
 		return -ENOMEM;
 
-	src = (u32 __iomem *) (info->screen_base + p);
+	src = (u32 __iomem *)(info->screen_base + p);
 
 	if (info->fbops->fb_sync)
 		info->fbops->fb_sync(info);
@@ -422,7 +422,7 @@ smtcfb_write(struct fb_info *info, const char __user *buf, size_t count,
 	if (!buffer)
 		return -ENOMEM;
 
-	dst = (u32 __iomem *) (info->screen_base + p);
+	dst = (u32 __iomem *)(info->screen_base + p);
 
 	if (info->fbops->fb_sync)
 		info->fbops->fb_sync(info);
@@ -568,7 +568,7 @@ static void sm7xx_set_timing(struct smtcfb_info *sfb)
 		writel(0x00030000, sfb->vp_regs + 0x0);
 		break;
 	}
-	writel((u32) (((m_nscreenstride + 2) << 16) | m_nscreenstride),
+	writel((u32)(((m_nscreenstride + 2) << 16) | m_nscreenstride),
 	       sfb->vp_regs + 0x10);
 }
 
-- 
1.8.1.2

