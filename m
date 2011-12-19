From: Marek Vasut <marek.vasut@gmail.com>
Date: Mon, 19 Dec 2011 15:37:59 +0000
Subject: [PATCH RESEND] MXSFB: Fix driver registration
Message-Id: <1324309079-10739-1-git-send-email-marek.vasut@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, FlorianSchandinat@gmx.de, Marek Vasut <marek.vasut@gmail.com>, Wolfgang Denk <wd@denx.de>, Stefano Babic <sbabic@denx.de>, Shawn Guo <shawn.guo@linaro.org>, Huang Shijie <b32955@freescale.com>, Axel Lin <axel.lin@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>

The driver should be registered with mxsfb_driver, not with mxsfb_devtype.
This caused obvious null pointer dereference and crash.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
Cc: Wolfgang Denk <wd@denx.de>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Huang Shijie <b32955@freescale.com>
Cc: Axel Lin <axel.lin@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Axel Lin <axel.lin@gmail.com>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/video/mxsfb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index 18742c2..d29c7c0 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -902,7 +902,7 @@ static struct platform_driver mxsfb_driver = {
 	},
 };
 
-module_platform_driver(mxsfb_devtype);
+module_platform_driver(mxsfb_driver);
 
 MODULE_DESCRIPTION("Freescale mxs framebuffer driver");
 MODULE_AUTHOR("Sascha Hauer, Pengutronix");
-- 
1.7.6.4

