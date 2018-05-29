From: Nick Desaulniers <nick.desaulniers@gmail.com>
Date: Tue, 29 May 2018 06:59:05 +0000
Subject: [PATCH] video/hdmi: prefer strlcpy to strncpy
Message-Id: <1527577145-7750-1-git-send-email-nick.desaulniers@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com
Cc: Nick Desaulniers <nick.desaulniers@gmail.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Fixes a stringop-truncation warning from gcc-8.

Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
---
 drivers/video/hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
index 111a0ab..46c184c 100644
--- a/drivers/video/hdmi.c
+++ b/drivers/video/hdmi.c
@@ -168,8 +168,8 @@ int hdmi_spd_infoframe_init(struct hdmi_spd_infoframe *frame,
 	frame->version = 1;
 	frame->length = HDMI_SPD_INFOFRAME_SIZE;
 
-	strncpy(frame->vendor, vendor, sizeof(frame->vendor));
-	strncpy(frame->product, product, sizeof(frame->product));
+	strlcpy(frame->vendor, vendor, sizeof(frame->vendor));
+	strlcpy(frame->product, product, sizeof(frame->product));
 
 	return 0;
 }
-- 
2.7.4

