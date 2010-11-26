From: Randy Dunlap <randy.dunlap@oracle.com>
Date: Fri, 26 Nov 2010 05:20:25 +0000
Subject: [PATCH] framebuffer: fix fbcmap.c kernel-doc warning
Message-Id: <20101125212025.e0ccbeda.randy.dunlap@oracle.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix kernel-doc warning in fbcmap.c:

Warning(drivers/video/fbcmap.c:92): No description found for parameter 'flags'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/video/fbcmap.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.37-rc3-git2.orig/drivers/video/fbcmap.c
+++ linux-2.6.37-rc3-git2/drivers/video/fbcmap.c
@@ -80,6 +80,7 @@ static const struct fb_cmap default_16_c
  *	@cmap: frame buffer colormap structure
  *	@len: length of @cmap
  *	@transp: boolean, 1 if there is transparency, 0 otherwise
+ *	@flags: flags for kmalloc memory allocation
  *
  *	Allocates memory for a colormap @cmap.  @len is the
  *	number of entries in the palette.
