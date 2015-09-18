From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Fri, 18 Sep 2015 11:28:32 +0000
Subject: [PATCH] fbdev: broadsheetfb: fix memory leak
Message-Id: <1442574992-31654-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

On the error path we have missed releasing the firmware.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/video/fbdev/broadsheetfb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/broadsheetfb.c b/drivers/video/fbdev/broadsheetfb.c
index 0e5fde1..ac1f41e 100644
--- a/drivers/video/fbdev/broadsheetfb.c
+++ b/drivers/video/fbdev/broadsheetfb.c
@@ -752,7 +752,7 @@ static ssize_t broadsheet_loadstore_waveform(struct device *dev,
 	if ((fw_entry->size < 8*1024) || (fw_entry->size > 64*1024)) {
 		dev_err(dev, "Invalid waveform\n");
 		err = -EINVAL;
-		goto err_failed;
+		goto err_fw;
 	}
 
 	mutex_lock(&(par->io_lock));
@@ -762,13 +762,15 @@ static ssize_t broadsheet_loadstore_waveform(struct device *dev,
 	mutex_unlock(&(par->io_lock));
 	if (err < 0) {
 		dev_err(dev, "Failed to store broadsheet waveform\n");
-		goto err_failed;
+		goto err_fw;
 	}
 
 	dev_info(dev, "Stored broadsheet waveform, size %zd\n", fw_entry->size);
 
 	return len;
 
+err_fw:
+	release_firmware(fw_entry);
 err_failed:
 	return err;
 }
-- 
1.9.1

