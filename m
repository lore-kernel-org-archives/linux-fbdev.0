From: Julia Lawall <julia@diku.dk>
Date: Sun, 05 Sep 2010 19:00:19 +0000
Subject: [PATCH 1/8] drivers/video/matrox/matroxfb_maven.c: Fix unsigned return type
Message-Id: <1283713226-8429-2-git-send-email-julia@diku.dk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1283713226-8429-1-git-send-email-julia@diku.dk>
In-Reply-To: <1283713226-8429-1-git-send-email-julia@diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

The function has an unsigned return type, but returns a negative constant
to indicate an error condition.  The result of calling the function is only
tested by comparison to 0, and thus unsigned is not needed and can be
dropped from the return type.

A sematic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@exists@
identifier f;
constant C;
@@

 unsigned f(...)
 { <+...
*  return -C;
 ...+> }
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/video/matrox/matroxfb_maven.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/matrox/matroxfb_maven.c b/drivers/video/matrox/matroxfb_maven.c
index 1e3e8f1..a78611a 100644
--- a/drivers/video/matrox/matroxfb_maven.c
+++ b/drivers/video/matrox/matroxfb_maven.c
@@ -280,7 +280,7 @@ static int matroxfb_PLL_mavenclock(const struct matrox_pll_features2* pll,
 	return fxtal * (*feed) / (*in) * ctl->den;
 }
 
-static unsigned int matroxfb_mavenclock(const struct matrox_pll_ctl* ctl,
+static int matroxfb_mavenclock(const struct matrox_pll_ctl *ctl,
 		unsigned int htotal, unsigned int vtotal,
 		unsigned int* in, unsigned int* feed, unsigned int* post,
 		unsigned int* htotal2) {

