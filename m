From: Mathieu Malaterre <malat@debian.org>
Date: Fri, 18 Jan 2019 19:32:48 +0000
Subject: [PATCH] video/hdmi: Change strncpy() into memcpy() in hdmi_spd_infoframe_init
Message-Id: <20190118193248.535-1-malat@debian.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Mathieu Malaterre <malat@debian.org>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Using strncpy() is less than perfect since the destination buffers do not
need to be NUL terminated. Replace strncpy() with memcpy() to address a
warning triggered by gcc using W=1 and optimize the code a bit.

This commit removes the following warnings:

  drivers/video/hdmi.c:234:2: warning: 'strncpy' specified bound 8 equals destination size [-Wstringop-truncation]
  drivers/video/hdmi.c:235:2: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/video/hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
index 799ae49774f5..553c39ac8f9e 100644
--- a/drivers/video/hdmi.c
+++ b/drivers/video/hdmi.c
@@ -231,8 +231,8 @@ int hdmi_spd_infoframe_init(struct hdmi_spd_infoframe *frame,
 	frame->version = 1;
 	frame->length = HDMI_SPD_INFOFRAME_SIZE;
 
-	strncpy(frame->vendor, vendor, sizeof(frame->vendor));
-	strncpy(frame->product, product, sizeof(frame->product));
+	memcpy(frame->vendor, vendor, sizeof(frame->vendor));
+	memcpy(frame->product, product, sizeof(frame->product));
 
 	return 0;
 }
-- 
2.19.2
