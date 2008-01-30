From: Bryan Wu <bryan.wu@analog.com>
Subject: [PATCH 2/3] [Video] BF54x LQ043 Framebuffer
	driver: fix bug lcd_device_register API breakage
Date: Wed, 30 Jan 2008 17:01:50 +0800
Message-ID: <1201683711-24948-3-git-send-email-bryan.wu@analog.com>
References: <1201683711-24948-1-git-send-email-bryan.wu@analog.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JK8pQ-0007Z5-9k for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 30 Jan 2008 01:01:58 -0800
Received: from nwd2mail10.analog.com ([137.71.25.55])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JK8pO-00063i-Rg
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 30 Jan 2008 01:01:56 -0800
In-Reply-To: <1201683711-24948-1-git-send-email-bryan.wu@analog.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net
Cc: Bryan Wu <bryan.wu@analog.com>, linux-kernel@vger.kernel.org

Signed-off-by: Bryan Wu <bryan.wu@analog.com>
---
 drivers/video/bf54x-lq043fb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/bf54x-lq043fb.c b/drivers/video/bf54x-lq043fb.c
index e9f5989..6b76007 100644
--- a/drivers/video/bf54x-lq043fb.c
+++ b/drivers/video/bf54x-lq043fb.c
@@ -673,7 +673,7 @@ static int __init bfin_bf54x_probe(struct platform_device *pdev)
 				      &bfin_lq043fb_bl_ops);
 	bl_dev->props.max_brightness = 255;
 
-	lcd_dev = lcd_device_register(DRIVER_NAME, NULL, &bfin_lcd_ops);
+	lcd_dev = lcd_device_register(DRIVER_NAME, &pdev->dev, NULL, &bfin_lcd_ops);
 	lcd_dev->props.max_contrast = 255, printk(KERN_INFO "Done.\n");
 #endif
 
-- 
1.5.3.4

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
