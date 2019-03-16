From: Yifeng Li <tomli@tomli.me>
Date: Sat, 16 Mar 2019 22:24:58 +0000
Subject: [PATCH 2/8] fbdev: sm712fb: fix brightness control on reboot, don't set SR30.
Message-Id: <20190316222504.27170-3-tomli@tomli.me>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190316222504.27170-1-tomli@tomli.me>
In-Reply-To: <20190316222504.27170-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Yifeng Li <tomli@tomli.me>, stable@vger.kernel.org

On a Thinkpad s30 (Pentium III / i440MX, Lynx3DM), rebooting with
sm712fb framebuffer driver would cause the role of brightness up/down
button to swap.

Experiments showed the FPR30 register caused this behavior. Moreover,
even if this register don't have side-effect on other systems, over-
writing it is also highly questionable, since it was originally
configurated by the motherboard manufacturer by hardwiring pull-down
resistors to indicate the type of LCD panel. We should not mess with
it.

Stop writing to the SR30 (a.k.a FPR30) register.

Signed-off-by: Yifeng Li <tomli@tomli.me>
Cc: stable@vger.kernel.org  # v4.4+
---
 drivers/video/fbdev/sm712fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index d05379affa32..a19655babf67 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -1145,8 +1145,8 @@ static void sm7xx_set_timing(struct smtcfb_info *sfb)
 
 		/* init SEQ register SR30 - SR75 */
 		for (i = 0; i < SIZE_SR30_SR75; i++)
-			if ((i + 0x30) != 0x62 && (i + 0x30) != 0x6a &&
-			    (i + 0x30) != 0x6b)
+			if ((i + 0x30) != 0x30 && (i + 0x30) != 0x62 &&
+			    (i + 0x30) != 0x6a && (i + 0x30) != 0x6b)
 				smtc_seqw(i + 0x30,
 					  vgamode[j].init_sr30_sr75[i]);
 
-- 
2.20.1
