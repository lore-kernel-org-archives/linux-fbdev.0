From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Fri, 05 Aug 2011 21:46:18 +0000
Subject: [PATCH 3/6] viafb: remove superfluous register unlocking/locking
Message-Id: <1312581877-4161-1-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1312578946.git.FlorianSchandinat@gmx.de>
In-Reply-To: <cover.1312578946.git.FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

The locking is done within the viafb_set_*_timing functions so there
is no need to do it here. Move a missing hardware reset into the
modesetting function.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 drivers/video/via/hw.c              |    7 -------
 drivers/video/via/via_modesetting.c |    4 ++++
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/video/via/hw.c b/drivers/video/via/hw.c
index 52d41f0..8b4bdf5 100644
--- a/drivers/video/via/hw.c
+++ b/drivers/video/via/hw.c
@@ -1507,18 +1507,11 @@ void viafb_fill_crtc_timing(struct crt_mode_table *crt_table,
 	crt_reg.ver_sync_end += crt_reg.ver_sync_start;
 	h_addr = crt_reg.hor_addr;
 	v_addr = crt_reg.ver_addr;
-	if (set_iga = IGA1) {
-		viafb_unlock_crt();
-		viafb_write_reg_mask(CR17, VIACR, 0x00, BIT7);
-	}
-
 	if (set_iga = IGA1)
 		via_set_primary_timing(&crt_reg);
 	else if (set_iga = IGA2)
 		via_set_secondary_timing(&crt_reg);
 
-	viafb_lock_crt();
-	viafb_write_reg_mask(CR17, VIACR, 0x80, BIT7);
 	viafb_load_fetch_count_reg(h_addr, bpp_byte, set_iga);
 
 	/* load FIFO */
diff --git a/drivers/video/via/via_modesetting.c b/drivers/video/via/via_modesetting.c
index 016d457..0e431ae 100644
--- a/drivers/video/via/via_modesetting.c
+++ b/drivers/video/via/via_modesetting.c
@@ -82,6 +82,10 @@ void via_set_primary_timing(const struct display_timing *timing)
 
 	/* lock timing registers */
 	via_write_reg_mask(VIACR, 0x11, 0x80, 0x80);
+
+	/* reset timing control */
+	via_write_reg_mask(VIACR, 0x17, 0x00, 0x80);
+	via_write_reg_mask(VIACR, 0x17, 0x80, 0x80);
 }
 
 void via_set_secondary_timing(const struct display_timing *timing)
-- 
1.6.3.2

