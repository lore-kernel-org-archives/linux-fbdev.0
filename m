From: Sasha Levin <sashal@kernel.org>
Date: Sat, 01 Jun 2019 13:25:49 +0000
Subject: [PATCH AUTOSEL 4.4 45/56] fbdev: sm712fb: fix brightness control on reboot, don't set SR30
Message-Id: <20190601132600.27427-45-sashal@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190601132600.27427-1-sashal@kernel.org>
In-Reply-To: <20190601132600.27427-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, linux-fbdev@vger.kernel.org, Teddy Wang <teddy.wang@siliconmotion.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, Yifeng Li <tomli@tomli.me>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

From: Yifeng Li <tomli@tomli.me>

[ Upstream commit 5481115e25e42b9215f2619452aa99c95f08492f ]

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
Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>
Cc: <stable@vger.kernel.org>  # v4.4+
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/sm712fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index 6a30714a18632..3f5840aaa1dd0 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -1156,8 +1156,8 @@ static void sm7xx_set_timing(struct smtcfb_info *sfb)
 
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
