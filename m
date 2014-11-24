From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 24 Nov 2014 17:19:55 +0000
Subject: [PATCH 3/6] video: fbdev-MMP: Fix typos for the word "destroy"
Message-Id: <547368BB.2050401@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <54736422.90409@users.sourceforge.net>
In-Reply-To: <54736422.90409@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, trivial@kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 24 Nov 2014 15:50:15 +0100

Two mistyped words were corrected in the description for
the mmp_unregister_path() function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/mmp/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/mmp/core.c b/drivers/video/fbdev/mmp/core.c
index b563b92..43ed576 100644
--- a/drivers/video/fbdev/mmp/core.c
+++ b/drivers/video/fbdev/mmp/core.c
@@ -223,10 +223,10 @@ struct mmp_path *mmp_register_path(struct mmp_path_info *info)
 EXPORT_SYMBOL_GPL(mmp_register_path);
 
 /*
- * mmp_unregister_path - unregister and destory path
+ * mmp_unregister_path - unregister and destroy path
  * @p: path to be destoried.
  *
- * this function registers path and destorys it.
+ * this function registers path and destroys it.
  */
 void mmp_unregister_path(struct mmp_path *path)
 {
-- 
2.1.3

