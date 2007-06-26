From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 01/17] OMAP: Add TI OMAP framebuffer driver
Date: Tue, 26 Jun 2007 18:50:03 +0200
Message-ID: <20070626165003.GA22389@uranus.ravnborg.org>
References: <5d5443650706260533r218c05b1u5d4336015c4a4a9b@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757782AbXFZQtS@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5d5443650706260533r218c05b1u5d4336015c4a4a9b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Trilok Soni <soni.trilok@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, akpm@linux-foundation.org, Tony Lindgren <tony@atomide.com>, imre.deak@solidboot.com, juha.yrjola@solidboot.com, linux-kernel@vger.kernel.org

diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefile
new file mode 100644
index 0000000..5aa7175
--- /dev/null
+++ b/drivers/video/omap/Makefile
@@ -0,0 +1,10 @@
+#
+# Makefile for the new OMAP framebuffer device driver
+#
+
+obj-$(CONFIG_FB_OMAP) += omapfb.o
+
+objs-yy := omapfb_main.o
+
+omapfb-objs := $(objs-yy)
+

This looks strangs.
Please use:
obj-$(CONFIG_FB_OMAP) += omapfb.o

omapfb-y := omapfb_main.o

Or even better rename your .c file to omapfb.c then
you only need to use:
obj-$(CONFIG_FB_OMAP) += omapfb.o

	Sam
