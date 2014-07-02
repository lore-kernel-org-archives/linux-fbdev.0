From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Wed, 02 Jul 2014 21:31:12 +0000
Subject: [PATCH] video: fbdev: broadsheetfb.c:  Fix a memory leak
Message-Id: <1404336673-6099-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Joe Perches <joe@perches.com>, Hanjun Guo <hanjun.guo@linaro.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Fix a memory leak.

This was found using a static code analysis program called cppcheck

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/video/fbdev/broadsheetfb.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/broadsheetfb.c b/drivers/video/fbdev/broadsheetfb.c
index 8556264..526e5e84 100644
--- a/drivers/video/fbdev/broadsheetfb.c
+++ b/drivers/video/fbdev/broadsheetfb.c
@@ -636,7 +636,7 @@ static int broadsheet_spiflash_rewrite_sector(struct broadsheetfb_par *par,
 		err = broadsheet_spiflash_read_range(par, start_sector_addr,
 						data_start_addr, sector_buffer);
 		if (err)
-			return err;
+			goto end_release;
 	}
 
 	/* now we copy our data into the right place in the sector buffer */
@@ -657,7 +657,7 @@ static int broadsheet_spiflash_rewrite_sector(struct broadsheetfb_par *par,
 		err = broadsheet_spiflash_read_range(par, tail_start_addr,
 			tail_len, sector_buffer + tail_start_addr);
 		if (err)
-			return err;
+			goto end_release;
 	}
 
 	/* if we got here we have the full sector that we want to rewrite. */
@@ -665,11 +665,14 @@ static int broadsheet_spiflash_rewrite_sector(struct broadsheetfb_par *par,
 	/* first erase the sector */
 	err = broadsheet_spiflash_erase_sector(par, start_sector_addr);
 	if (err)
-		return err;
+		goto end_release;
 
 	/* now write it */
 	err = broadsheet_spiflash_write_sector(par, start_sector_addr,
 					sector_buffer, sector_size);
+
+end_release:
+	kfree(sector_buffer);
 	return err;
 }
 
-- 
1.7.10.4

