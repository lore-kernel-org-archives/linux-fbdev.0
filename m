From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Sat, 30 Jan 2016 14:44:32 +0000
Subject: [patch] video: fbdev: metronomefb: two harmless off by one bugs
Message-Id: <20160130144432.GF3462@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

par->metromem_cmd->args[] is an array of 31 elements of size u16.  Here
we have initialized the first "i" elements and want to set the rest to
zero.

The issue here is that ARRAY_SIZE(par->metromem_cmd->args) is 31 and not
32 as in the original code.  It means that we set ->csum to zero, but
that is harmless because we immediately set it to the correct value on
the next line.

Still, the buffer overflow upsets static checkers so let's correct the
math.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/video/fbdev/metronomefb.c b/drivers/video/fbdev/metronomefb.c
index ad04a01..abb6bbf 100644
--- a/drivers/video/fbdev/metronomefb.c
+++ b/drivers/video/fbdev/metronomefb.c
@@ -354,7 +354,8 @@ static int metronome_powerup_cmd(struct metronomefb_par *par)
 	}
 
 	/* the rest are 0 */
-	memset((u8 *) (par->metromem_cmd->args + i), 0, (32-i)*2);
+	memset(&par->metromem_cmd->args[i], 0,
+	       (ARRAY_SIZE(par->metromem_cmd->args) - i) * 2);
 
 	par->metromem_cmd->csum = cs;
 
@@ -376,7 +377,8 @@ static int metronome_config_cmd(struct metronomefb_par *par)
 	memcpy(par->metromem_cmd->args, epd_frame_table[par->dt].config,
 		sizeof(epd_frame_table[par->dt].config));
 	/* the rest are 0 */
-	memset((u8 *) (par->metromem_cmd->args + 4), 0, (32-4)*2);
+	memset(&par->metromem_cmd->args[4], 0,
+	       (ARRAY_SIZE(par->metromem_cmd->args) - 4) * 2);
 
 	par->metromem_cmd->csum = 0xCC10;
 	par->metromem_cmd->csum += calc_img_cksum(par->metromem_cmd->args, 4);
