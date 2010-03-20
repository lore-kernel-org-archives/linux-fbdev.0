From: Wolfram Sang <w.sang@pengutronix.de>
Date: Sat, 20 Mar 2010 14:13:04 +0000
Subject: [PATCH 23/24] video/matrox: fix dangling pointers
Message-Id: <1269094385-16114-24-git-send-email-w.sang@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1269094385-16114-1-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1269094385-16114-1-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, Petr Vandrovec <vandrove@vc.cvut.cz>, linux-fbdev@vger.kernel.org

Fix I2C-drivers which missed setting clientdata to NULL before freeing the
structure it points to. Also fix drivers which do this _after_ the structure
was freed already.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>
---

Found using coccinelle, then reviewed. Full patchset is available via
kernel-janitors, linux-i2c, and LKML.
---
 drivers/video/matrox/matroxfb_maven.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/matrox/matroxfb_maven.c b/drivers/video/matrox/matroxfb_maven.c
index 91af915..e7b0ec3 100644
--- a/drivers/video/matrox/matroxfb_maven.c
+++ b/drivers/video/matrox/matroxfb_maven.c
@@ -1254,6 +1254,7 @@ static int maven_probe(struct i2c_client *client,
 		goto ERROR4;
 	return 0;
 ERROR4:;
+	i2c_set_clientdata(client, NULL);
 	kfree(data);
 ERROR0:;
 	return err;
-- 
1.7.0

