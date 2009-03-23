From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] fbdev: Remove outdated advice about I2C
	configuration
Date: Mon, 23 Mar 2009 11:23:54 +0100
Message-ID: <20090323112354.21585af5@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <khali@linux-fr.org>) id 1LlhKD-0006g1-5D
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 23 Mar 2009 10:24:09 +0000
Received: from zone0.gcu-squad.org ([212.85.147.21]
	helo=services.gcu-squad.org)
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LlhK8-00017g-Kz
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 23 Mar 2009 10:24:09 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Antonino Daplas <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

The required I2C modules are now selected automatically by the means
of select statements in Kconfig, so there is no point in confusing the
users with options he/she would be supposed to enable manually.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/video/Kconfig |   23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

--- linux-2.6.29-rc8.orig/drivers/video/Kconfig	2009-03-22 14:55:07.000000000 +0100
+++ linux-2.6.29-rc8/drivers/video/Kconfig	2009-03-23 11:16:19.000000000 +0100
@@ -1128,13 +1128,6 @@ config FB_INTEL
           830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM/965G/965GM chipsets.
           Say Y if you have and plan to use such a board.
 
-	  If you say Y here and want DDC/I2C support you must first say Y to
-	  "I2C support" and "I2C bit-banging support" in the character devices
-	  section.
-
-	  If you say M here then "I2C support" and "I2C bit-banging support"
-	  can be build either as modules or built-in.
-
 	  To compile this driver as a module, choose M here: the
 	  module will be called intelfb.
 
@@ -1207,11 +1200,10 @@ config FB_MATROX_G
 	  pixel and 32 bpp packed pixel. You can also use font widths
 	  different from 8.
 
-	  If you need support for G400 secondary head, you must first say Y to
-	  "I2C support" in the character devices section, and then to
-	  "Matrox I2C support" and "G400 second head support" here in the
-	  framebuffer section. G450/G550 secondary head and digital output
-	  are supported without additional modules.
+	  If you need support for G400 secondary head, you must say Y to
+	  "Matrox I2C support" and "G400 second head support" right below.
+	  G450/G550 secondary head and digital output are supported without
+	  additional modules.
 
 	  The driver starts in monitor mode. You must use the matroxset tool 
 	  (available at <ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/>) to 
@@ -1310,13 +1302,6 @@ config FB_RADEON
 	  a framebuffer device.  There are both PCI and AGP versions.  You
 	  don't need to choose this to run the Radeon in plain VGA mode.
 
-	  If you say Y here and want DDC/I2C support you must first say Y to
-	  "I2C support" and "I2C bit-banging support" in the character devices
-	  section.
-
-	  If you say M here then "I2C support" and "I2C bit-banging support" 
-	  can be build either as modules or built-in.
-
 	  There is a product page at
 	  http://apps.ati.com/ATIcompare/
 


-- 
Jean Delvare

------------------------------------------------------------------------------
Apps built with the Adobe(R) Flex(R) framework and Flex Builder(TM) are
powering Web 2.0 with engaging, cross-platform capabilities. Quickly and
easily build your RIAs with Flex Builder, the Eclipse(TM)based development
software that enables intelligent coding and step-through debugging.
Download the free 60 day trial. http://p.sf.net/sfu/www-adobe-com
