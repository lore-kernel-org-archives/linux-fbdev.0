From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Wed, 17 Jun 2015 11:36:40 +0000
Subject: [PATCH v2 1/9] staging: sm7xxfb: declare struct as const
Message-Id: <1434540288-8289-2-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434540288-8289-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1434540288-8289-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

The vesa_mode_table is not to be modified, so declare it as const.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm7xxfb/sm7xxfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm7xxfb/sm7xxfb.c b/drivers/staging/sm7xxfb/sm7xxfb.c
index 5db26f1..4d9b69d 100644
--- a/drivers/staging/sm7xxfb/sm7xxfb.c
+++ b/drivers/staging/sm7xxfb/sm7xxfb.c
@@ -94,7 +94,7 @@ struct vesa_mode {
 	u16  lfb_depth;
 };
 
-static struct vesa_mode vesa_mode_table[] = {
+static const struct vesa_mode vesa_mode_table[] = {
 	{"0x301", 640,  480,  8},
 	{"0x303", 800,  600,  8},
 	{"0x305", 1024, 768,  8},
-- 
1.8.1.2

