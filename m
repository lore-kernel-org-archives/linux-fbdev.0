From: Jules Irenge <jbi.octave@gmail.com>
Date: Fri, 03 Apr 2020 16:05:02 +0000
Subject: [PATCH 2/5] video: Add missing annotation for cyber2000fb_enable_ddc() and cyber2000fb_disable_ddc()
Message-Id: <20200403160505.2832-3-jbi.octave@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <0/5>
 <20200403160505.2832-1-jbi.octave@gmail.com>
In-Reply-To: <20200403160505.2832-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, boqun.feng@gmail.com, Russell King <linux@armlinux.org.uk>, "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>, "moderated list:CYBERPRO FB DRIVER" <linux-arm-kernel@lists.infradead.org>

Sparse reports warnings at cyber2000fb_enable_ddc()
	and cyber2000fb_disable_ddc()

warning: context imbalance in cyber2000fb_enable_ddc()
	- wrong count at exit

warning: context imbalance in cyber2000fb_disable_ddc()
	- unexpected unlock

The root cause is the missing annotation at cyber2000fb_enable_ddc()
	and cyber2000fb_disable_ddc()

Add the missing __acquires(&cfb->reg_b0_lock) annotation
Add the missing __releases(&cfb->reg_b0_lock) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/video/fbdev/cyber2000fb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/cyber2000fb.c b/drivers/video/fbdev/cyber2000fb.c
index 460826a7ad55..513f58f28b0f 100644
--- a/drivers/video/fbdev/cyber2000fb.c
+++ b/drivers/video/fbdev/cyber2000fb.c
@@ -1160,12 +1160,14 @@ EXPORT_SYMBOL(cyber2000fb_detach);
 #define DDC_SDA_IN	(1 << 6)
 
 static void cyber2000fb_enable_ddc(struct cfb_info *cfb)
+	__acquires(&cfb->reg_b0_lock)
 {
 	spin_lock(&cfb->reg_b0_lock);
 	cyber2000fb_writew(0x1bf, 0x3ce, cfb);
 }
 
 static void cyber2000fb_disable_ddc(struct cfb_info *cfb)
+	__releases(&cfb->reg_b0_lock)
 {
 	cyber2000fb_writew(0x0bf, 0x3ce, cfb);
 	spin_unlock(&cfb->reg_b0_lock);
-- 
2.24.1
