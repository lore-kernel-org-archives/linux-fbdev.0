From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 4/4] video: add driver for PXA3xx 2D graphics accelerator
Date: Wed, 2 Sep 2009 23:24:07 +0200
Message-ID: <20090902212407.GJ9410@buzzloop.caiaq.de>
References: <1247159091-28697-4-git-send-email-daniel@caiaq.de>
	<1247159091-28697-5-git-send-email-daniel@caiaq.de>
	<4A56F02D.1000007@gmail.com>
	<20090718080736.GL13236@buzzloop.caiaq.de>
	<4A63E08F.4090409@gmail.com>
	<20090720102239.GA3809@buzzloop.caiaq.de>
	<4A645A38.1080008@gmail.com>
	<20090720134703.GE19257@buzzloop.caiaq.de>
	<4A64830F.2020701@gmail.com>
	<20090722120433.GA9464@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20090722120433.GA9464@buzzloop.caiaq.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: Sven Neumann <s.neumann@raumfeld.com>, linux-fbdev-devel@lists.sourceforge.net, dok@directfb.org, linux-arm-kernel@lists.infradead.org, Eric Miao <eric.y.miao@gmail.com>

On Wed, Jul 22, 2009 at 02:04:33PM +0200, Daniel Mack wrote:
> On Mon, Jul 20, 2009 at 10:45:35PM +0800, Eric Miao wrote:
> > Daniel Mack wrote:
> > >> Cool - I'll find a time slot to test this, and maybe someone else wants to
> > >> have a try either. Thanks.
> > > 
> > > Will that accelerator ID patch (the one I sent today) go thru your
> > > channel or are the fbdev people supposed to pick it?
> > > 
> > 
> > Better to go through fbdev people - or at least I need an Ack before it
> > goes through my tree.
> > 
> > Krzysztof Cc'ed.
> 
> Krzysztof,
> 
> resending this because I don't known whether you got the first copy of
> that patch.

I'm sending this patch for the the forth time now, this time with the
fbdev-devel list copied. Maybe that helps.

This is fairly simple, but it's blocking the pxa3xx-gcu driver to be
merged.

Any feedback is appreciated.

Thanks,
Daniel

From 8b200756251e3dcdc91d506e9dbc9846ccaa91d3 Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@caiaq.de>
Date: Mon, 20 Jul 2009 11:18:43 +0200
Subject: [PATCH] video: add PXA3xx accelerator ID

Add ID 99 for PXA3xx frame buffers and use it in pxafb when running on a
pxa with acceleration enabled.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Eric Miao <eric.miao@marvell.com>
Cc: linux-fbdev-devel@lists.sourceforge.net
Cc: Dennis Oliver Kropp <dok@directfb.org>
Cc: Sven Neumann <s.neumann@raumfeld.com>
---
 drivers/video/pxafb.c |    5 +++++
 include/linux/fb.h    |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 3951cc5..922ed8a 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -2083,6 +2083,11 @@ static int __devinit pxafb_probe(struct platform_device *dev)
 		goto failed;
 	}
 
+#ifdef CONFIG_PXA3XX_GCU
+	if (cpu_is_pxa3xx())
+		fbi->fb.fix.accel = FB_ACCEL_PXA3XX;
+#endif
+
 	fbi->backlight_power = inf->pxafb_backlight_power;
 	fbi->lcd_power = inf->pxafb_lcd_power;
 
diff --git a/include/linux/fb.h b/include/linux/fb.h
index f847df9..a34bdf5 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -133,6 +133,7 @@ struct dentry;
 #define FB_ACCEL_NEOMAGIC_NM2230 96	/* NeoMagic NM2230              */
 #define FB_ACCEL_NEOMAGIC_NM2360 97	/* NeoMagic NM2360              */
 #define FB_ACCEL_NEOMAGIC_NM2380 98	/* NeoMagic NM2380              */
+#define FB_ACCEL_PXA3XX		 99	/* PXA3xx			*/
 
 #define FB_ACCEL_SAVAGE4        0x80	/* S3 Savage4                   */
 #define FB_ACCEL_SAVAGE3D       0x81	/* S3 Savage3D                  */
-- 
1.6.3.1
