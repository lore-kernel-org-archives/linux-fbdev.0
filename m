From: Tormod Volden <lists.tormod@gmail.com>
Date: Sun, 03 Apr 2011 12:54:06 +0000
Subject: [PATCH] savagefb: Remove obsolete else clause in savage_setup_i2c_bus
Message-Id: <1301835246-6520-3-git-send-email-lists.tormod@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Tormod Volden <debian.tormod@gmail.com>

The else clause was not needed after the cleanup in commit
b8901b091db260b0f0101d6395ce5c6016835a47

Signed-off-by: Tormod Volden <debian.tormod@gmail.com>
---

I could probably have sent this to some janitor list instead?

Tormod

 drivers/video/savage/savagefb-i2c.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/video/savage/savagefb-i2c.c b/drivers/video/savage/savagefb-i2c.c
index 5e7acda..bb71fea 100644
--- a/drivers/video/savage/savagefb-i2c.c
+++ b/drivers/video/savage/savagefb-i2c.c
@@ -159,8 +159,7 @@ static int savage_setup_i2c_bus(struct savagefb_i2c_chan *chan,
 		else
 			dev_warn(&chan->par->pcidev->dev,
 				 "Failed to register I2C bus %s.\n", name);
-	} else
-		chan->par = NULL;
+	}
 
 	return rc;
 }
-- 
1.7.0.4

