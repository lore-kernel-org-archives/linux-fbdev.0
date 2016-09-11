From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sun, 11 Sep 2016 13:05:46 +0000
Subject: [PATCH 04/26] matroxfb: constify local structures
Message-Id: <1473599168-30561-5-git-send-email-Julia.Lawall@lip6.fr>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1473599168-30561-1-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1473599168-30561-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: joe@perches.com, kernel-janitors@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

For structure types defined in the same file or local header files, find
top-level static structure declarations that have the following
properties:
1. Never reassigned.
2. Address never taken
3. Not passed to a top-level macro call
4. No pointer or array-typed field passed to a function or stored in a
variable.
Declare structures having all of these properties as const.

Done using Coccinelle.
Based on a suggestion by Joe Perches <joe@perches.com>.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
The semantic patch seems too long for a commit log, but is in the cover
letter.

 drivers/video/fbdev/matrox/matroxfb_g450.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/matrox/matroxfb_g450.c b/drivers/video/fbdev/matrox/matroxfb_g450.c
index cff0546..f108ae6 100644
--- a/drivers/video/fbdev/matrox/matroxfb_g450.c
+++ b/drivers/video/fbdev/matrox/matroxfb_g450.c
@@ -433,7 +433,7 @@ static void cve2_init_TVdata(int norm, struct mavenregs* data, const struct outp
 		0x00,	/* 3E written multiple times */
 		0x00,	/* 3F not written */
 	} };
-	static struct mavenregs ntscregs = { {
+	static const struct mavenregs ntscregs = { {
 		0x21, 0xF0, 0x7C, 0x1F,	/* 00: chroma subcarrier */
 		0x00,
 		0x00,	/* test */

