From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] savagefb: One more I2C-enabled device in savagefb
Date: Sun, 20 Nov 2005 20:50:29 +0800
Message-ID: <43807115.1030503@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EdxKo-00087S-Dl
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Nov 2005 14:06:54 -0800
Received: from zproxy.gmail.com ([64.233.162.205])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EdxKo-0004zc-6S
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Nov 2005 14:06:54 -0800
Received: by zproxy.gmail.com with SMTP id z3so556224nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 20 Nov 2005 14:06:54 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Jean Delvare <khali@linux-fr.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Jean Delvare <khali@linux-fr.org>

The I2C bus of the S3 Savage2000 is supposed to work the same way the
Savage4 does. At least, the legacy i2c-savage4 driver handled both
devices the same way.

I do not have the hardware to test this, so testers are welcome.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/savage/savagefb-i2c.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/savage/savagefb-i2c.c b/drivers/video/savage/savagefb-i2c.c
index 3c98457..aeec437 100644
--- a/drivers/video/savage/savagefb-i2c.c
+++ b/drivers/video/savage/savagefb-i2c.c
@@ -193,6 +193,7 @@ void savagefb_create_i2c_busses(struct f
 		par->chan.algo.getscl = prosavage_gpio_getscl;
 		break;
 	case FB_ACCEL_SAVAGE4:
+	case FB_ACCEL_SAVAGE2000:
 		par->chan.reg         = 0xff20;
 		par->chan.ioaddr      = par->mmio.vbase;
 		par->chan.algo.setsda = savage4_gpio_setsda;



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
