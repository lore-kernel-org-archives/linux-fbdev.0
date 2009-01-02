From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: atafb - kill warn_unused_result warnings
Date: Fri,  2 Jan 2009 11:41:25 +0100
Message-ID: <1230892892-25751-13-git-send-email-geert@linux-m68k.org>
References: <1230892892-25751-1-git-send-email-geert@linux-m68k.org>
 <1230892892-25751-2-git-send-email-geert@linux-m68k.org>
 <1230892892-25751-3-git-send-email-geert@linux-m68k.org>
 <1230892892-25751-4-git-send-email-geert@linux-m68k.org>
 <1230892892-25751-5-git-send-email-geert@linux-m68k.org>
 <1230892892-25751-6-git-send-email-geert@linux-m68k.org>
 <1230892892-25751-7-git-send-email-geert@linux-m68k.org>
 <1230892892-25751-8-git-send-email-geert@linux-m68k.org>
 <1230892892-25751-9-git-send-email-geert@linux-m68k.org>
 <1230892892-25751-10-git-send-email-geert@linux-m68k.org>
 <1230892892-25751-11-git-send-email-geert@linux-m68k.org>
 <1230892892-25751-12-git-send-email-geert@linux-m68k.org>
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <1230892892-25751-12-git-send-email-geert@linux-m68k.org>
Sender: linux-m68k-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-fbdev-devel@lists.sourceforge.net

warning: ignoring return value of 'request_irq', declared with attribute
warn_unused_result

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev-devel@lists.sourceforge.net
---
 drivers/video/atafb.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/video/atafb.c b/drivers/video/atafb.c
index 477ce55..8058572 100644
--- a/drivers/video/atafb.c
+++ b/drivers/video/atafb.c
@@ -3075,8 +3075,7 @@ int __init atafb_setup(char *options)
 
 int __init atafb_init(void)
 {
-	int pad;
-	int detected_mode;
+	int pad, detected_mode, error;
 	unsigned int defmode = 0;
 	unsigned long mem_req;
 
@@ -3116,8 +3115,12 @@ int __init atafb_init(void)
 			printk("atafb_init: initializing Falcon hw\n");
 			fbhw = &falcon_switch;
 			atafb_ops.fb_setcolreg = &falcon_setcolreg;
-			request_irq(IRQ_AUTO_4, falcon_vbl_switcher, IRQ_TYPE_PRIO,
-			            "framebuffer/modeswitch", falcon_vbl_switcher);
+			error = request_irq(IRQ_AUTO_4, falcon_vbl_switcher,
+					    IRQ_TYPE_PRIO,
+					    "framebuffer/modeswitch",
+					    falcon_vbl_switcher);
+			if (error)
+				return error;
 			defmode = DEFMODE_F30;
 			break;
 		}
-- 
1.5.6.5

