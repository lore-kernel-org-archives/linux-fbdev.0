From: Eric Wong <e@80x24.org>
Date: Thu, 08 Nov 2018 00:03:35 +0000
Subject: Re: radeon vs radeonfb Mobility quirks (Thinkpad X32)
Message-Id: <20181108000335.a7usqftcmxvu7ywk@untitled>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181104042328.jzavn47y2wloprbs@untitled>
 <365d8b24f1c6a28c32998924a95b6a2a74655526.camel@kernel.crashing.org>
In-Reply-To: <365d8b24f1c6a28c32998924a95b6a2a74655526.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Airlie <airlied@linux.ie>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> There's a whole pile of power management stuff for ancient laptops that
> never quite made it from radeonfb to the radeon DRM driver... sadly it
> also prevents sleep on old PowerBooks but I haven't had many complaints
> so...

Thanks for the confirmation that stuff is missing from the DRM driver.

> The code for D2 and D3 on those old things is reasonably self
> contained, it shouldn't be that hard to move it over I suppose.

I started working on the following (dirty) patch for my X32,
but hasn't made a difference with just PCI_D2:

diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index 59c8a6647ff2..acc587b18ad2 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -1548,6 +1548,23 @@ void radeon_device_fini(struct radeon_device *rdev)
 		radeon_doorbell_fini(rdev);
 }
 
+/* XXX copy of radeonfb_whack_power_state */
+static void radeon_whack_power_state(struct pci_dev *pdev, pci_power_t state)
+{
+	u16 pwr_cmd;
+
+	for (;;) {
+		pci_read_config_word(pdev, pdev->pm_cap + PCI_PM_CTRL,
+				     &pwr_cmd);
+		if (pwr_cmd & state)
+			break;
+		pwr_cmd = (pwr_cmd & ~PCI_PM_CTRL_STATE_MASK) | state;
+		pci_write_config_word(pdev, pdev->pm_cap + PCI_PM_CTRL,
+				      pwr_cmd);
+		msleep(500);
+	}
+	pdev->current_state = state;
+}
 
 /*
  * Suspend & resume.
@@ -1596,6 +1613,7 @@ int radeon_suspend_kms(struct drm_device *dev, bool suspend,
 
 		if (radeon_crtc->cursor_bo) {
 			struct radeon_bo *robj = gem_to_radeon_bo(radeon_crtc->cursor_bo);
+
 			r = radeon_bo_reserve(robj, false);
 			if (r = 0) {
 				radeon_bo_unpin(robj);
@@ -1647,7 +1665,13 @@ int radeon_suspend_kms(struct drm_device *dev, bool suspend,
 	} else if (suspend) {
 		/* Shut down the device */
 		pci_disable_device(dev->pdev);
-		pci_set_power_state(dev->pdev, PCI_D3hot);
+
+		if ("X32") {
+			radeon_whack_power_state(dev->pdev, PCI_D2);
+			__pci_complete_power_transition(dev->pdev, PCI_D2);
+		} else {
+			pci_set_power_state(dev->pdev, PCI_D3hot);
+		}
 	}
 
 	if (fbcon) {


I suppose some of the mobility stuff from
drivers/video/fbdev/aty/radeon_pm.c is necessary, but I haven't
figured it out for the DRM driver.  Not sure when/if I'll have
time to figure it out, or if I'll stick to the radeonfb driver
for now.

		/* Prepare mobility chips for suspend.
		 */
		if (rinfo->is_mobility) {
			/* Program V2CLK */
			radeon_pm_program_v2clk(rinfo);
		
			/* Disable IO PADs */
			radeon_pm_disable_iopad(rinfo);

			/* Set low current */
			radeon_pm_low_current(rinfo);

			/* Prepare chip for power management */
			radeon_pm_setup_for_suspend(rinfo);
