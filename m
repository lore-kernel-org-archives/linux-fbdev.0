From: Denys Vlasenko <vda.linux@googlemail.com>
Date: Thu, 24 Jun 2010 03:21:46 +0000
Subject: [PATCH] fbcon: deinline four foo_update_attr() functions
Message-Id: <1277349706-5195-1-git-send-email-vda.linux@googlemail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>, James Simmons <jsimmons@infradead.org>, linux-fbdev@vger.kernel.org, Denys Vlasenko <vda.linux@googlemail.com>
Cc: linux-kernel@vger.kernel.org

This patch deinlines four similar functions, foo_update_attr(),
in four fbcon-related files.
These functions contain loops, two of theam have _hested_ loops,
and they have more than one callsite each.
I think they should not be inlined.

Signed-off-by: Denys Vlasenko <vda.linux@googlemail.com>
---
 drivers/video/console/bitblit.c   |    2 +-
 drivers/video/console/fbcon_ccw.c |    2 +-
 drivers/video/console/fbcon_cw.c  |    2 +-
 drivers/video/console/fbcon_ud.c  |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/console/bitblit.c b/drivers/video/console/bitblit.c
index af88651..28b1a83 100644
--- a/drivers/video/console/bitblit.c
+++ b/drivers/video/console/bitblit.c
@@ -22,7 +22,7 @@
 /*
  * Accelerated handlers.
  */
-static inline void update_attr(u8 *dst, u8 *src, int attribute,
+static void update_attr(u8 *dst, u8 *src, int attribute,
 			       struct vc_data *vc)
 {
 	int i, offset = (vc->vc_font.height < 10) ? 1 : 2;
diff --git a/drivers/video/console/fbcon_ccw.c b/drivers/video/console/fbcon_ccw.c
index d135671..41b32ae 100644
--- a/drivers/video/console/fbcon_ccw.c
+++ b/drivers/video/console/fbcon_ccw.c
@@ -22,7 +22,7 @@
  * Rotation 270 degrees
  */
 
-static inline void ccw_update_attr(u8 *dst, u8 *src, int attribute,
+static void ccw_update_attr(u8 *dst, u8 *src, int attribute,
 				  struct vc_data *vc)
 {
 	int i, j, offset = (vc->vc_font.height < 10) ? 1 : 2;
diff --git a/drivers/video/console/fbcon_cw.c b/drivers/video/console/fbcon_cw.c
index 126110f..6a73782 100644
--- a/drivers/video/console/fbcon_cw.c
+++ b/drivers/video/console/fbcon_cw.c
@@ -22,7 +22,7 @@
  * Rotation 90 degrees
  */
 
-static inline void cw_update_attr(u8 *dst, u8 *src, int attribute,
+static void cw_update_attr(u8 *dst, u8 *src, int attribute,
 				  struct vc_data *vc)
 {
 	int i, j, offset = (vc->vc_font.height < 10) ? 1 : 2;
diff --git a/drivers/video/console/fbcon_ud.c b/drivers/video/console/fbcon_ud.c
index 93a3e73..ff0872c 100644
--- a/drivers/video/console/fbcon_ud.c
+++ b/drivers/video/console/fbcon_ud.c
@@ -22,7 +22,7 @@
  * Rotation 180 degrees
  */
 
-static inline void ud_update_attr(u8 *dst, u8 *src, int attribute,
+static void ud_update_attr(u8 *dst, u8 *src, int attribute,
 				  struct vc_data *vc)
 {
 	int i, offset = (vc->vc_font.height < 10) ? 1 : 2;
-- 
1.6.2.5

