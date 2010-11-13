From: Mike Frysinger <vapier@gentoo.org>
Date: Sat, 13 Nov 2010 07:06:27 +0000
Subject: [PATCH] fsl-diu-fb: drop dead ioctl define
Message-Id: <1289631987-5854-1-git-send-email-vapier@gentoo.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Anatolij Gustschin <agust@denx.de>

The fsl-diu-fb driver no longer uses this define, and we have a common one
to cover this already (FBIO_WAITFORVSYNC).

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 include/linux/fsl-diu-fb.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/linux/fsl-diu-fb.h b/include/linux/fsl-diu-fb.h
index fc295d7..781d467 100644
--- a/include/linux/fsl-diu-fb.h
+++ b/include/linux/fsl-diu-fb.h
@@ -54,7 +54,6 @@ struct aoi_display_offset {
 };
 
 #define MFB_SET_CHROMA_KEY	_IOW('M', 1, struct mfb_chroma_key)
-#define MFB_WAIT_FOR_VSYNC	_IOW('F', 0x20, u_int32_t)
 #define MFB_SET_BRIGHTNESS	_IOW('M', 3, __u8)
 
 #define MFB_SET_ALPHA		0x80014d00
-- 
1.7.3.2

