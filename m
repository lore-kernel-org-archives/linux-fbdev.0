From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] video: add PXA3xx accelerator ID
Date: Mon, 20 Jul 2009 12:14:14 +0200
Message-ID: <1248084854-7635-1-git-send-email-daniel@caiaq.de>
References: <4A63E08F.4090409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <4A63E08F.4090409@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Daniel Mack <daniel@caiaq.de>, Eric Miao <eric.miao@marvell.com>, linux-fbdev-devel@lists.sourceforge.net, Dennis Oliver Kropp <dok@directfb.org>, Sven Neumann <s.neumann@raumfeld.com>

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


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
