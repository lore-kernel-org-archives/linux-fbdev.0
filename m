From: Igor Ribeiro Barbosa Duarte <igor.ribeiro.duarte@gmail.com>
Date: Tue, 26 May 2020 22:47:50 +0000
Subject: [PATCH] staging: sm750fb: Add names to proc_setBLANK args
Message-Id: <20200526224750.GA29722@igor-Aspire-F5-573G>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Add names to proc_setBLANK args.
Found using checkpatch.pl.

Signed-off-by: Igor Ribeiro Barbosa Duarte <igor.ribeiro.duarte@gmail.com>
---
 drivers/staging/sm750fb/sm750.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 55fe5a2..19823c7 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -166,7 +166,7 @@ struct lynxfb_output {
 	 */
 	void *priv;
 
-	int (*proc_setBLANK)(struct lynxfb_output*, int);
+	int (*proc_setBLANK)(struct lynxfb_output *output, int blank);
 };
 
 struct lynxfb_par {
-- 
2.7.4
