From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 24 Nov 2014 17:28:09 +0000
Subject: [PATCH 5/6] video: fbdev-MMP: Fix a typo for the word "destroyed"
Message-Id: <54736AA9.9020305@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <54736422.90409@users.sourceforge.net>
In-Reply-To: <54736422.90409@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, trivial@kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 24 Nov 2014 15:55:23 +0100

A word was corrected in the description for a parameter of
the mmp_unregister_path() function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/mmp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/mmp/core.c b/drivers/video/fbdev/mmp/core.c
index 43ed576..a0f4960 100644
--- a/drivers/video/fbdev/mmp/core.c
+++ b/drivers/video/fbdev/mmp/core.c
@@ -224,7 +224,7 @@ EXPORT_SYMBOL_GPL(mmp_register_path);
 
 /*
  * mmp_unregister_path - unregister and destroy path
- * @p: path to be destoried.
+ * @p: path to be destroyed.
  *
  * this function registers path and destroys it.
  */
-- 
2.1.3

