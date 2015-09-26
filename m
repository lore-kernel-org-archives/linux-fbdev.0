From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sat, 26 Sep 2015 08:52:55 +0000
Subject: [PATCH v2] fbdev: broadsheetfb: fix memory leak
Message-Id: <1443257530-26848-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

We have requested the firmware and it was loaded but we missed releasing
it both on success and error.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---

v1: relased the firmware only on the error path.

 drivers/video/fbdev/broadsheetfb.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/broadsheetfb.c b/drivers/video/fbdev/broadsheetfb.c
index 0e5fde1..9f9a7be 100644
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
 
-	return len;
+	err = len;
 
+err_fw:
+	release_firmware(fw_entry);
 err_failed:
 	return err;
 }
-- 
1.9.1

