From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sun, 08 Mar 2015 17:52:10 +0000
Subject: [PATCH 2/3] staging: sm7xxfb: remove unneeded __setup
Message-Id: <1425836411-15481-2-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425836411-15481-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1425836411-15481-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

as we start to use kernel boot parameters and fb_get_options()
we donot need to use __setup() any more.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm7xxfb/sm7xxfb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/sm7xxfb/sm7xxfb.c b/drivers/staging/sm7xxfb/sm7xxfb.c
index 17b3917..e93563f 100644
--- a/drivers/staging/sm7xxfb/sm7xxfb.c
+++ b/drivers/staging/sm7xxfb/sm7xxfb.c
@@ -141,7 +141,6 @@ static int __init sm7xx_vga_setup(char *options)
 
 	return -1;
 }
-__setup("vga=", sm7xx_vga_setup);
 
 static void sm712_setpalette(int regno, unsigned red, unsigned green,
 			     unsigned blue, struct fb_info *info)
-- 
1.9.1

