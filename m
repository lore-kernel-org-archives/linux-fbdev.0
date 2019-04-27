From: Kelsey Skunberg <skunberg.kelsey@gmail.com>
Date: Sat, 27 Apr 2019 16:33:34 +0000
Subject: [PATCH] Staging: sm750fb: Change *array into *const array
Message-Id: <20190427163334.7109-1-skunberg.kelsey@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Resolve checkpatch warning for static const char * array by using const
pointers.

Checkpatch Warning in sm750.c:
static const char * array should probably be static const char * const

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 105089b97bf5..59568d18ce23 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -748,7 +748,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 		lynx750_ext, NULL, vesa_modes,
 	};
 	int cdb[] = {ARRAY_SIZE(lynx750_ext), 0, VESA_MODEDB_SIZE};
-	static const char *mdb_desc[] = {
+	static const char * const mdb_desc[] = {
 		"driver prepared modes",
 		"kernel prepared default modedb",
 		"kernel HELPERS prepared vesa_modes",
-- 
2.20.1
