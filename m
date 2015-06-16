From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 16 Jun 2015 13:54:11 +0000
Subject: [PATCH 8/8] staging: sm7xxfb: fix camelcase
Message-Id: <1434462131-15191-8-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434462131-15191-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1434462131-15191-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Fix the checkpatch warning about CamelCase.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm7xxfb/sm7xx.h   | 2 +-
 drivers/staging/sm7xxfb/sm7xxfb.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm7xxfb/sm7xx.h b/drivers/staging/sm7xxfb/sm7xx.h
index fc28429..4bed094 100644
--- a/drivers/staging/sm7xxfb/sm7xx.h
+++ b/drivers/staging/sm7xxfb/sm7xx.h
@@ -98,7 +98,7 @@ static inline unsigned int smtc_seqr(int reg)
 /* The next structure holds all information relevant for a specific video mode.
  */
 
-struct ModeInit {
+struct modeinit {
 	int mmsizex;
 	int mmsizey;
 	int bpp;
diff --git a/drivers/staging/sm7xxfb/sm7xxfb.c b/drivers/staging/sm7xxfb/sm7xxfb.c
index ecbf7be..0e40816 100644
--- a/drivers/staging/sm7xxfb/sm7xxfb.c
+++ b/drivers/staging/sm7xxfb/sm7xxfb.c
@@ -114,7 +114,7 @@ static const struct vesa_mode vesa_mode_table[] = {
 /**********************************************************************
 			 SM712 Mode table.
  **********************************************************************/
-static const struct ModeInit vgamode[] = {
+static const struct modeinit vgamode[] = {
 	{
 	 /*  mode#0: 640 x 480  16Bpp  60Hz */
 	 640, 480, 16, 60,
-- 
1.8.1.2

