From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 04 Mar 2019 19:52:30 +0000
Subject: [PATCH] fbdev: mbx: fix a misspelled variable name
Message-Id: <20190304195249.971696-1-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

A recent cleanup introduced a build failure when a variable
was spelled incorrectly:

In file included from drivers/video/fbdev/mbx/mbxfb.c:881:
drivers/video/fbdev/mbx/mbxdebugfs.c: In function 'mbxfb_debugfs_init':
drivers/video/fbdev/mbx/mbxdebugfs.c:217:2: error: 'mbfi' undeclared (first use in this function); did you mean 'mfbi'?
  mbfi->debugfs_dir = dir;
  ^~~~
  mfbi
drivers/video/fbdev/mbx/mbxdebugfs.c:217:2: note: each undeclared identifier is reported only once for each function it appears in
drivers/video/fbdev/mbx/mbxdebugfs.c:213:21: error: unused variable 'mfbi' [-Werror=unused-variable]
  struct mbxfb_info *mfbi = fbi->par;
                     ^~~~

Fixes: 72aed9e31344 ("fbdev: mbx: fix up debugfs file creation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/mbx/mbxdebugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/mbx/mbxdebugfs.c b/drivers/video/fbdev/mbx/mbxdebugfs.c
index 52cfe0132b25..09af721638fb 100644
--- a/drivers/video/fbdev/mbx/mbxdebugfs.c
+++ b/drivers/video/fbdev/mbx/mbxdebugfs.c
@@ -214,7 +214,7 @@ static void mbxfb_debugfs_init(struct fb_info *fbi)
 	struct dentry *dir;
 
 	dir = debugfs_create_dir("mbxfb", NULL);
-	mbfi->debugfs_dir = dir;
+	mfbi->debugfs_dir = dir;
 
 	debugfs_create_file("sysconf", 0444, dir, fbi, &sysconf_fops);
 	debugfs_create_file("clock", 0444, dir, fbi, &clock_fops);
-- 
2.20.0
