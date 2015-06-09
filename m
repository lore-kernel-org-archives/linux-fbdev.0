From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date: Tue, 09 Jun 2015 13:04:26 +0000
Subject: [PATCH] drivers/video/fbdev/sis/sis_main.c: avoid repeated strlen() calls
Message-Id: <1433855066-20260-1-git-send-email-linux@rasmusvillemoes.dk>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Winischhofer <thomas@winischhofer.net>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

gcc is not smart enough to realize that strlen(strbuf1) cannot be
changed by the loop body, so it is forced to recompute it, at least in
the branch containing the assignment. Avoid this by using an
equivalent stopping condition.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/video/fbdev/sis/sis_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sis/sis_main.c b/drivers/video/fbdev/sis/sis_main.c
index fcf610edf217..ea95f8bf3922 100644
--- a/drivers/video/fbdev/sis/sis_main.c
+++ b/drivers/video/fbdev/sis/sis_main.c
@@ -172,7 +172,7 @@ static void sisfb_search_mode(char *name, bool quiet)
 
 	if(strlen(name) <= 19) {
 		strcpy(strbuf1, name);
-		for(i = 0; i < strlen(strbuf1); i++) {
+		for(i = 0; strbuf1[i]; i++) {
 			if(strbuf1[i] < '0' || strbuf1[i] > '9') strbuf1[i] = ' ';
 		}
 
-- 
2.1.3

