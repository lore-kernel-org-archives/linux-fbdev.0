From: Eric Anholt <eric@anholt.net>
Date: Tue, 19 Apr 2016 20:37:09 +0000
Subject: [PATCH] drm/vc4: Kick out the simplefb framebuffer before we set up KMS.
Message-Id: <1461098229-8664-1-git-send-email-eric@anholt.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-rpi-kernel@lists.infradead.org

If we don't, then simplefb stays loaded on /dev/fb0 even though
scanout isn't happening from simplefb's memory area any more, and you
end up with no console.

Signed-off-by: Eric Anholt <eric@anholt.net>
---

Dave: It would be nice if I could merge this patch through
bcm2835-dt-next, where I'm trying to get the VC4 DT merged even though
the defconfig includes both VC4 and simplefb.  There aren't any
conflicts with anything I'm merging through drm-next.

 drivers/gpu/drm/vc4/vc4_drv.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index b7d2ff0e6e1f..109b10651959 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -153,6 +153,24 @@ static void vc4_match_add_drivers(struct device *dev,
 	}
 }
 
+static void vc4_kick_out_firmware_fb(void)
+{
+	struct apertures_struct *ap;
+
+	ap = alloc_apertures(1);
+	if (!ap)
+		return;
+
+	/* Since VC4 is a UMA device, the simplefb node may have been
+	 * located anywhere in memory.
+	 */
+	ap->ranges[0].base = 0;
+	ap->ranges[0].size = ~0;
+
+	remove_conflicting_framebuffers(ap, "vc4drmfb", false);
+	kfree(ap);
+}
+
 static int vc4_drm_bind(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -186,6 +204,8 @@ static int vc4_drm_bind(struct device *dev)
 	if (ret)
 		goto gem_destroy;
 
+	vc4_kick_out_firmware_fb();
+
 	ret = drm_dev_register(drm, 0);
 	if (ret < 0)
 		goto unbind_all;
-- 
2.8.0.rc3

