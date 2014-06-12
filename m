From: Colin King <colin.king@canonical.com>
Date: Thu, 12 Jun 2014 10:18:08 +0000
Subject: [PATCH] video: fbdev: broadsheetfb.c: fix memory leak on sector_buffer
Message-Id: <1402568288-10397-1-git-send-email-colin.king@canonical.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

static code analysis from cppcheck reports:

[drivers/video/fbdev/broadsheetfb.c:673]:
  (error) Memory leak: sector_buffer

sector_buffer is not being kfree'd on each call to
broadsheet_spiflash_rewrite_sector(), so free it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/video/fbdev/broadsheetfb.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/broadsheetfb.c b/drivers/video/fbdev/broadsheetfb.c
index 8556264..235542f 100644
--- a/drivers/video/fbdev/broadsheetfb.c
+++ b/drivers/video/fbdev/broadsheetfb.c
@@ -636,7 +636,7 @@ static int broadsheet_spiflash_rewrite_sector(struct broadsheetfb_par *par,
 		err = broadsheet_spiflash_read_range(par, start_sector_addr,
 						data_start_addr, sector_buffer);
 		if (err)
-			return err;
+			goto out;
 	}
 
 	/* now we copy our data into the right place in the sector buffer */
@@ -657,7 +657,7 @@ static int broadsheet_spiflash_rewrite_sector(struct broadsheetfb_par *par,
 		err = broadsheet_spiflash_read_range(par, tail_start_addr,
 			tail_len, sector_buffer + tail_start_addr);
 		if (err)
-			return err;
+			goto out;
 	}
 
 	/* if we got here we have the full sector that we want to rewrite. */
@@ -665,11 +665,13 @@ static int broadsheet_spiflash_rewrite_sector(struct broadsheetfb_par *par,
 	/* first erase the sector */
 	err = broadsheet_spiflash_erase_sector(par, start_sector_addr);
 	if (err)
-		return err;
+		goto out;
 
 	/* now write it */
 	err = broadsheet_spiflash_write_sector(par, start_sector_addr,
 					sector_buffer, sector_size);
+out:
+	kfree(sector_buffer);
 	return err;
 }
 
-- 
2.0.0

