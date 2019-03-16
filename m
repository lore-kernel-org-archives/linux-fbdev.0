From: Yifeng Li <tomli@tomli.me>
Date: Sat, 16 Mar 2019 22:24:57 +0000
Subject: [PATCH 1/8] fbdev: sm712fb: fix white screen of death on reboot, don't set CR3B-CR3F.
Message-Id: <20190316222504.27170-2-tomli@tomli.me>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190316222504.27170-1-tomli@tomli.me>
In-Reply-To: <20190316222504.27170-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Yifeng Li <tomli@tomli.me>, stable@vger.kernel.org

On a Thinkpad s30 (Pentium III / i440MX, Lynx3DM), rebooting with
sm712fb framebuffer driver would cause a white screen of death on
the next POST, presumably the proper timings for the LCD panel was
not reprogrammed properly by the BIOS.

Experiments showed a few CRTC Scratch Registers, including CRT3D,
CRT3E and CRT3F may be used internally by BIOS as some flags. CRT3B is
a hardware testing register, we shouldn't mess with it. CRT3C has
blanking signal and line compare control, which is not needed for this
driver.

Stop writing to CR3B-CR3F (a.k.a CRT3B-CRT3F) registers. Even if these
registers don't have side-effect on other systems, writing to them is
also highly questionable.

Signed-off-by: Yifeng Li <tomli@tomli.me>
Cc: stable@vger.kernel.org  # v4.4+
---
 drivers/video/fbdev/sm712fb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index 502d0de2feec..d05379affa32 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -1171,8 +1171,12 @@ static void sm7xx_set_timing(struct smtcfb_info *sfb)
 			smtc_crtcw(i, vgamode[j].init_cr00_cr18[i]);
 
 		/* init CRTC register CR30 - CR4D */
-		for (i = 0; i < SIZE_CR30_CR4D; i++)
+		for (i = 0; i < SIZE_CR30_CR4D; i++) {
+			if ((i + 0x30) >= 0x3B && (i + 0x30) <= 0x3F)
+				/* side-effect, don't write to CR3B-CR3F */
+				continue;
 			smtc_crtcw(i + 0x30, vgamode[j].init_cr30_cr4d[i]);
+		}
 
 		/* init CRTC register CR90 - CRA7 */
 		for (i = 0; i < SIZE_CR90_CRA7; i++)
-- 
2.20.1
