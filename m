From: Dennis Munsie <dmunsie@cecropia.com>
Subject: [PATCH 7/7 2.6.17-rc6-mm2] add preliminary i2c
	support to intelfb
Date: Wed, 14 Jun 2006 13:53:31 -0400
Message-ID: <95A58CC4-4851-4CD4-854A-0D5A156EFA30@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FqZVx-0001DB-MK for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 10:50:49 -0700
Received: from mail6.sea5.speakeasy.net ([69.17.117.8])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FqZVx-0000gX-Dd
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 10:50:49 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Eric Hustvedt <ehustvedt@cecropia.com>, Dave Airlie <airlied@skynet.ie>

From: Dennis Munsie <dmunsie@cecropia.com>

[07/07] intelfb: adds an option to enable I2C support in the intelfb  
driver.  Also adds
the intel_i2c.c file to the Makefile.

Signed-off-by: Dennis Munsie <dmunsie@cecropia.com>

---

drivers/video/Kconfig          |   20 ++++++++++++++++++--
drivers/video/intelfb/Makefile |    4 +++-
2 files changed, 21 insertions(+), 3 deletions(-)

diff -Naurp -X linux-2.6.17-rc6-patched/Documentation/dontdiff  
linux-2.6.17-rc6-patched/drivers/video/Kconfig linux/drivers/video/ 
Kconfig
--- linux-2.6.17-rc6-patched/drivers/video/Kconfig	2006-06-14  
10:56:26.000000000 -0500
+++ linux/drivers/video/Kconfig	2006-06-14 10:57:41.000000000 -0500
@@ -746,6 +746,8 @@ config FB_INTEL
	depends on FB && EXPERIMENTAL && PCI && X86
	select AGP
	select AGP_INTEL
+	select I2C_ALGOBIT if FB_INTEL_I2C
+	select I2C if FB_INTEL_I2C
	select FB_MODE_HELPERS
	select FB_CFB_FILLRECT
	select FB_CFB_COPYAREA
@@ -755,17 +757,31 @@ config FB_INTEL
            830M/845G/852GM/855GM/865G chipsets.
            Say Y if you have and plan to use such a board.
-          To compile this driver as a module, choose M here: the
+	  If you say Y here and want DDC/I2C support you must first say Y to
+	  "I2C support" and "I2C bit-banging support" in the character devices
+	  section.
+
+	  If you say M here then "I2C support" and "I2C bit-banging support"
+	  can be build either as modules or built-in.
+
+	  To compile this driver as a module, choose M here: the
	  module will be called intelfb.
config FB_INTEL_DEBUG
-        bool "Intel driver Debug Messages"
+	bool "Intel driver Debug Messages"
	depends on FB_INTEL
	---help---
	  Say Y here if you want the Intel driver to output all sorts
	  of debugging informations to provide to the maintainer when
	  something goes wrong.
+config FB_INTEL_I2C
+	bool "DDC/I2C for Intel framebuffer support"
+	depends on FB_INTEL
+	default y
+	help
+	  Say Y here if you want DDC/I2C support for your on-board Intel  
graphics.
+
config FB_MATROX
	tristate "Matrox acceleration"
	depends on FB && PCI
diff -Naurp -X linux-2.6.17-rc6-patched/Documentation/dontdiff  
linux-2.6.17-rc6-patched/drivers/video/intelfb/Makefile linux/drivers/ 
video/intelfb/Makefile
--- linux-2.6.17-rc6-patched/drivers/video/intelfb/Makefile	 
2006-06-14 11:00:36.000000000 -0500
+++ linux/drivers/video/intelfb/Makefile	2006-06-14  
11:01:09.000000000 -0500
@@ -1,6 +1,8 @@
obj-$(CONFIG_FB_INTEL) += intelfb.o
-intelfb-objs := intelfbdrv.o intelfbhw.o
+intelfb-y := intelfbdrv.o intelfbhw.o
+intelfb-$(CONFIG_FB_INTEL_I2C) += intelfb_i2c.o
+intelfb-objs := $(intelfb-y)
ifdef CONFIG_FB_INTEL_DEBUG
#EXTRA_CFLAGS += -DDEBUG -DVERBOSE -DREGDUMP
