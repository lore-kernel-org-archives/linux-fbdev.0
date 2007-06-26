From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 03/17] OMAP: Add TI OMAP1 internal LCD controller
Date: Tue, 26 Jun 2007 18:53:52 +0200
Message-ID: <20070626165352.GC22389@uranus.ravnborg.org>
References: <5d5443650706260535haf0f9feq5e320059ee36c6cd@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758767AbXFZQw7@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5d5443650706260535haf0f9feq5e320059ee36c6cd@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Trilok Soni <soni.trilok@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, akpm@linux-foundation.org, Tony Lindgren <tony@atomide.com>, imre.deak@solidboot.com, juha.yrjola@solidboot.com, linux-kernel@vger.kernel.org

diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefile
index 5aa7175..2f35389 100644
--- a/drivers/video/omap/Makefile
+++ b/drivers/video/omap/Makefile
@@ -6,5 +6,7 @@ obj-$(CONFIG_FB_OMAP) += omapfb.o

 objs-yy := omapfb_main.o

+objs-y$(CONFIG_ARCH_OMAP1) += lcdc.o
+
 omapfb-objs := $(objs-yy)

So this explained your usage of -yy.
If you use the proposal from before then you could do
it like this:
omapfb-$(CONFIG_ARCH_OMAPI) += lcdc.o

	 Sam
