From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-voodoo3: Deprecate in favor of tdfxfb
Date: Mon, 23 Mar 2009 13:30:29 +0100
Message-ID: <20090323133029.4e1c1a79@hyperion.delvare>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Linux-fbdev-devel <linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Krzysztof Helt <krzysztof.h1-5tc4TXWwyLM@public.gmane.org>

Support for I2C/DDC was recently added to the tdfxfb driver, which
means that the i2c-voodoo3 driver can be deprecated.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Krzysztof Helt <krzysztof.h1-5tc4TXWwyLM@public.gmane.org>
---
 Documentation/feature-removal-schedule.txt |    9 +++++++++
 drivers/i2c/busses/Kconfig                 |    6 ++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

--- linux-2.6.29-rc8.orig/Documentation/feature-removal-schedule.txt	2009-03-20 09:46:26.000000000 +0100
+++ linux-2.6.29-rc8/Documentation/feature-removal-schedule.txt	2009-03-23 13:21:51.000000000 +0100
@@ -345,3 +345,12 @@ Why:	See commits 129f8ae9b1b5be94517da76
 	Removal is subject to fixing any remaining bugs in ACPI which may
 	cause the thermal throttling not to happen at the right time.
 Who:	Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+
+---------------------------
+
+What:	i2c-voodoo3 driver
+When:	October 2009
+Why:	Superseded by tdfxfb. I2C/DDC support used to live in a separate
+	driver but this caused driver conflicts.
+Who:	Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
+	Krzysztof Helt <krzysztof.h1-5tc4TXWwyLM@public.gmane.org>
--- linux-2.6.29-rc8.orig/drivers/i2c/busses/Kconfig	2009-03-20 18:54:07.000000000 +0100
+++ linux-2.6.29-rc8/drivers/i2c/busses/Kconfig	2009-03-23 13:26:30.000000000 +0100
@@ -583,12 +583,14 @@ comment "Graphics adapter I2C/DDC channe
 	depends on PCI
 
 config I2C_VOODOO3
-	tristate "Voodoo 3"
+	tristate "Voodoo 3 (DEPRECATED)"
 	depends on PCI
 	select I2C_ALGOBIT
 	help
 	  If you say yes to this option, support will be included for the
-	  Voodoo 3 I2C interface.
+	  Voodoo 3 I2C interface. This driver is deprecated and you should
+	  use the tdfxfb driver instead, which additionally provides
+	  framebuffer support.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-voodoo3.


-- 
Jean Delvare
