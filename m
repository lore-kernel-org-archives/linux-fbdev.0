From: lxnay@sabayon.org
Date: Sun, 06 Apr 2014 13:44:33 +0000
Subject: [PATCH] uvesafb: abort initialization if video=uvesafb is not set
Message-Id: <1396791873-22606-1-git-send-email-lxnay@sabayon.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Fabio Erculiani <lxnay@sabayon.org>

This patch makes possible to ship kernels with both vesafb and uvesafb
in order to guarantee a smooth transition to uvesafb and cope with
potential incompatibiles introduced by uvesafb making possible to disable
it via cmdline.

In case both vesafb and uvesafb are built-in, the kernel will try to
initialize both, which makes possible to select the wanted one using
either video=vesafb:... or video=uvesafb:....
In this way, old distro installations will keep working as before while
new ones can adopt video=uvesafb.

The behaviour does not change if uvesafb is built as a module.
---
 drivers/video/uvesafb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/uvesafb.c b/drivers/video/uvesafb.c
index d428445..04c4742 100644
--- a/drivers/video/uvesafb.c
+++ b/drivers/video/uvesafb.c
@@ -1957,6 +1957,10 @@ static int uvesafb_init(void)
 
 	if (fb_get_options("uvesafb", &option))
 		return -ENODEV;
+	if (!option || !*option)
+		/* if vesafb is enabled, this will make possible to fallback to it */
+		return -ENODEV;
+
 	uvesafb_setup(option);
 #endif
 	err = cn_add_callback(&uvesafb_cn_id, "uvesafb", uvesafb_cn_callback);
-- 
1.8.1.5

