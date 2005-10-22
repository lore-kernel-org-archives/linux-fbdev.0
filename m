From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH 2.6] fb: One more I2C-enabled device in savagefb
Date: Sat, 22 Oct 2005 17:22:56 +0200
Message-ID: <20051022172256.34eedc1d.khali@linux-fr.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ETMWJ-0006PF-O2
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 22 Oct 2005 09:46:59 -0700
Received: from smtp-dmz-236-saturday.dmz.nerim.net ([195.5.254.236] helo=kellthuzad.dmz.nerim.net)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1ETMWI-0006SM-I2
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 22 Oct 2005 09:46:59 -0700
Received: from kraid.nerim.net (smtp-106-saturday.nerim.net [62.4.16.106])
	by kellthuzad.dmz.nerim.net (Postfix) with ESMTP id DE8EC39896
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 22 Oct 2005 17:23:33 +0200 (CEST)
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
To: "Antonino A. Daplas" <adaplas@pol.net>
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi Antonino, all,

The I2C bus of the S3 Savage2000 is supposed to work the same way the
Savage4 does. At least, the legacy i2c-savage4 driver handled both
devices the same way.

I do not have the hardware to test this, so testers are welcome.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
CC: Antonino A. Daplas <adaplas@pol.net>

---
 drivers/video/savage/savagefb-i2c.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.14-rc4.orig/drivers/video/savage/savagefb-i2c.c	2005-10-22 16:42:00.000000000 +0200
+++ linux-2.6.14-rc4/drivers/video/savage/savagefb-i2c.c	2005-10-22 16:43:12.000000000 +0200
@@ -193,6 +193,7 @@
 		par->chan.algo.getscl = prosavage_gpio_getscl;
 		break;
 	case FB_ACCEL_SAVAGE4:
+	case FB_ACCEL_SAVAGE2000:
 		par->chan.reg         = 0xff20;
 		par->chan.ioaddr      = par->mmio.vbase;
 		par->chan.algo.setsda = savage4_gpio_setsda;

-- 
Jean Delvare


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
