From: Masanari Iida <standby24x7@gmail.com>
Date: Mon, 27 Feb 2012 14:28:38 +0000
Subject: [PATCH] [trivial] radeon: Fix typo in radeon_gem.c
Message-Id: <1330352918-1738-1-git-send-email-standby24x7@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: benh@kernel.crashing.org, linux-fbdev@vger.kernel.org
Cc: trivial@kernel.org, linux-kernel@vger.kernel.org, Masanari Iida <standby24x7@gmail.com>

Correct spelling "withou" to "without" in
drivers/gpu/drm/radeon/radeon_gem.c

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_gem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index 7337850..ff4ff23 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -117,7 +117,7 @@ int radeon_gem_set_domain(struct drm_gem_object *gobj,
 	}
 	if (!domain) {
 		/* Do nothings */
-		printk(KERN_WARNING "Set domain withou domain !\n");
+		printk(KERN_WARNING "Set domain without domain !\n");
 		return 0;
 	}
 	if (domain = RADEON_GEM_DOMAIN_CPU) {
-- 
1.7.9.2.262.gba998

