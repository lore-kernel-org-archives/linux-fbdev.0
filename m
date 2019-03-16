From: Yifeng Li <tomli@tomli.me>
Date: Sat, 16 Mar 2019 22:24:59 +0000
Subject: [PATCH 3/8] fbdev: sm712fb: fix VRAM detection, don't set SR70/71/74/75.
Message-Id: <20190316222504.27170-4-tomli@tomli.me>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190316222504.27170-1-tomli@tomli.me>
In-Reply-To: <20190316222504.27170-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Yifeng Li <tomli@tomli.me>, stable@vger.kernel.org

On a Thinkpad s30 (Pentium III / i440MX, Lynx3DM), the amount of Video
RAM is not detected correctly by the xf86-video-siliconmotion driver.
This is because sm712fb overwrites the GPR71 Scratch Pad Register, which
is set by BIOS on x86 and used to indicate amount of VRAM.

Other Scratch Pad Registers, including GPR70/74/75, don't have the same
side-effect, but overwriting to them is still questionable, as they are
not related to modesetting.

Stop writing to SR70/71/74/75 (a.k.a GPR70/71/74/75).

Signed-off-by: Yifeng Li <tomli@tomli.me>
Cc: stable@vger.kernel.org  # v4.4+
---
 drivers/video/fbdev/sm712fb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index a19655babf67..1a3d232c2916 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -1146,7 +1146,9 @@ static void sm7xx_set_timing(struct smtcfb_info *sfb)
 		/* init SEQ register SR30 - SR75 */
 		for (i = 0; i < SIZE_SR30_SR75; i++)
 			if ((i + 0x30) != 0x30 && (i + 0x30) != 0x62 &&
-			    (i + 0x30) != 0x6a && (i + 0x30) != 0x6b)
+			    (i + 0x30) != 0x6a && (i + 0x30) != 0x6b &&
+			    (i + 0x30) != 0x70 && (i + 0x30) != 0x71 &&
+			    (i + 0x30) != 0x74 && (i + 0x30) != 0x75)
 				smtc_seqw(i + 0x30,
 					  vgamode[j].init_sr30_sr75[i]);
 
-- 
2.20.1
