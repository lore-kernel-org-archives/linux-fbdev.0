From: Alexander Holler <holler@ahsoftware.de>
Date: Fri, 20 Apr 2012 22:11:07 +0000
Subject: [PATCH] video/smscufx: fix line counting in fb_write
Message-Id: <1334959867-3719-1-git-send-email-holler@ahsoftware.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Steve Glendinning <steve.glendinning@smsc.com>, linux-fbdev@vger.kernel.org, Alexander Holler <holler@ahsoftware.de>

Line 0 and 1 were both written to line 0 (on the display) and all subsequent
lines had an offset of -1. The result was that the last line on the display
was never overwritten by writes to /dev/fbN.

The origin of this bug seems to have been udlfb.

Signed-off-by: Alexander Holler <holler@ahsoftware.de>
---
 drivers/video/smscufx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/smscufx.c b/drivers/video/smscufx.c
index ccbfef5..1e1e2d2 100644
--- a/drivers/video/smscufx.c
+++ b/drivers/video/smscufx.c
@@ -904,7 +904,7 @@ static ssize_t ufx_ops_write(struct fb_info *info, const char __user *buf,
 	result = fb_sys_write(info, buf, count, ppos);
 
 	if (result > 0) {
-		int start = max((int)(offset / info->fix.line_length) - 1, 0);
+		int start = max((int)(offset / info->fix.line_length), 0);
 		int lines = min((u32)((result / info->fix.line_length) + 1),
 				(u32)info->var.yres);
 
-- 
1.7.6.5

