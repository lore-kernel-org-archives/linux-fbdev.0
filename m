From: mathieu.poirier@linaro.org
Date: Tue, 15 May 2012 21:02:57 +0000
Subject: [PATCH 1/5] drivers/video: use correct __devexit_p annotation
Message-Id: <1337115781-27979-2-git-send-email-mathieu.poirier@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1337115781-27979-1-git-send-email-mathieu.poirier@linaro.org>
In-Reply-To: <1337115781-27979-1-git-send-email-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, mathieu.poirier@linaro.org

From: Arnd Bergmann <arnd@arndb.de>

__devexit functions are discarded when CONFIG_HOTPLUG
is not set, so the symbol needs to be referenced carefully.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/video/broadsheetfb.c |    2 +-
 drivers/video/mbx/mbxfb.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/broadsheetfb.c b/drivers/video/broadsheetfb.c
index 377dde3..c95b417 100644
--- a/drivers/video/broadsheetfb.c
+++ b/drivers/video/broadsheetfb.c
@@ -1211,7 +1211,7 @@ static int __devexit broadsheetfb_remove(struct platform_device *dev)
 
 static struct platform_driver broadsheetfb_driver = {
 	.probe	= broadsheetfb_probe,
-	.remove = broadsheetfb_remove,
+	.remove = __devexit_p(broadsheetfb_remove),
 	.driver	= {
 		.owner	= THIS_MODULE,
 		.name	= "broadsheetfb",
diff --git a/drivers/video/mbx/mbxfb.c b/drivers/video/mbx/mbxfb.c
index 55bf619..56550ec 100644
--- a/drivers/video/mbx/mbxfb.c
+++ b/drivers/video/mbx/mbxfb.c
@@ -1045,7 +1045,7 @@ static int __devexit mbxfb_remove(struct platform_device *dev)
 
 static struct platform_driver mbxfb_driver = {
 	.probe = mbxfb_probe,
-	.remove = mbxfb_remove,
+	.remove = __devexit_p(mbxfb_remove),
 	.suspend = mbxfb_suspend,
 	.resume = mbxfb_resume,
 	.driver = {
-- 
1.7.5.4

