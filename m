From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Date: Sat, 01 Sep 2018 14:08:44 +0000
Subject: [PATCH v3 01/13] fbdev: show fbdev number for debugging
Message-Id: <ef584ecd8642e8b1a04f28d6d9c1864b5aa507bb.1535810304.git.mirq-linux@rere.qmqm.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1535810304.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1535810304.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, linux-tegra@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, Jonathan Hunter <jonathanh@nvidia.com>, Eric Anholt <eric@anholt.net>, Thierry Reding <thierry.reding@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>, Maxime Ripard <maxime.ripard@bootlin.com>, virtualization@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/video/fbdev/core/fbmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index f741ba8df01b..30a18d4c9de4 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1618,8 +1618,8 @@ static int do_remove_conflicting_framebuffers(struct apertures_struct *a,
 			(primary && gen_aper && gen_aper->count &&
 			 gen_aper->ranges[0].base = VGA_FB_PHYS)) {
 
-			printk(KERN_INFO "fb: switching to %s from %s\n",
-			       name, registered_fb[i]->fix.id);
+			printk(KERN_INFO "fb%d: switching to %s from %s\n",
+			       i, name, registered_fb[i]->fix.id);
 			ret = do_unregister_framebuffer(registered_fb[i]);
 			if (ret)
 				return ret;
-- 
2.18.0
