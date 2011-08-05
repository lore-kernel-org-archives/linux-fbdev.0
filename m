From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Fri, 05 Aug 2011 21:46:33 +0000
Subject: [PATCH 4/6] viafb: remove superfluous mode lookup
Message-Id: <1312581912-4198-1-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1312578946.git.FlorianSchandinat@gmx.de>
In-Reply-To: <cover.1312578946.git.FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

As the result is not used anywhere there is no need to perform the
lookup at all.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 drivers/video/via/viafbdev.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index bddae58..3eaf607 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -1735,7 +1735,6 @@ static struct viafb_pm_hooks viafb_fb_pm_hooks = {
 int __devinit via_fb_pci_probe(struct viafb_dev *vdev)
 {
 	u32 default_xres, default_yres;
-	struct VideoModeTable *vmode_entry;
 	struct fb_var_screeninfo default_var;
 	int rc;
 	u32 viafb_par_length;
@@ -1808,7 +1807,6 @@ int __devinit via_fb_pci_probe(struct viafb_dev *vdev)
 	}
 
 	parse_mode(viafb_mode, &default_xres, &default_yres);
-	vmode_entry = viafb_get_mode(default_xres, default_yres);
 	if (viafb_SAMM_ON = 1)
 		parse_mode(viafb_mode1, &viafb_second_xres,
 			&viafb_second_yres);
-- 
1.6.3.2

