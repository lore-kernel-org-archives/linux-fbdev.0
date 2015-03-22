From: Michel von Czettritz <michel.von.czettritz@gmail.com>
Date: Sun, 22 Mar 2015 23:13:06 +0000
Subject: [PATCH 06/13] staging: sm750: newline before { in function decl.
Message-Id: <20150322231306.GA17183@x230-arch.club.entropia.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch fixes checkpatch.pl error:
"ERROR: open brace '{' following function declarations go on the next line"

Signed-off-by: Michel von Czettritz <michel.von.czettritz@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index ad0c663..a0a8db7 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -58,7 +58,8 @@ static char *g_option = NULL;
 
 /* if not use spin_lock,system will die if user load driver
  * and immediatly unload driver frequently (dual)*/
-static inline void myspin_lock(spinlock_t *sl) {
+static inline void myspin_lock(spinlock_t *sl)
+{
 	struct lynx_share *share;
 	share = container_of(sl, struct lynx_share, slock);
 	if (share->dual) {
@@ -66,7 +67,8 @@ static inline void myspin_lock(spinlock_t *sl) {
 	}
 }
 
-static inline void myspin_unlock(spinlock_t *sl) {
+static inline void myspin_unlock(spinlock_t *sl)
+{
 	struct lynx_share *share;
 	share = container_of(sl, struct lynx_share, slock);
 	if (share->dual) {
-- 
2.3.3

