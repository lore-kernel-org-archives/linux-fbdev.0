From: Joe Perches <joe@perches.com>
Date: Sat, 30 Oct 2010 21:08:40 +0000
Subject: [PATCH 23/39] drivers/video/omap2/dss: Update WARN uses
Message-Id: <3dffcda8949a6625985223b6fbf18815b93646d7.1288471898.git.joe@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1288471897.git.joe@perches.com>
In-Reply-To: <cover.1288471897.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiri Kosina <trivial@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Add missing initial argument.
Coalesce long formats.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/video/omap2/dss/core.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 8e89f60..2a98237 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -867,8 +867,7 @@ static void reset_device(struct device *dev, int check)
 		dev->platform_data = NULL;
 		while (dev_p < dev_end) {
 			if (*dev_p) {
-				WARN("%s: struct device fields will be "
-						"discarded\n",
+				WARN(1, "%s: struct device fields will be discarded\n",
 				     __func__);
 				break;
 			}
-- 
1.7.3.1.g432b3.dirty

