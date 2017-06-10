From: Johannes Thumshirn <jthumshirn@suse.de>
Date: Sat, 10 Jun 2017 09:05:30 +0000
Subject: [PATCH 1/7] [media] media: introduce MEDIA_REVISION macro
Message-Id: <20170610090536.12472-2-jthumshirn@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170610090536.12472-1-jthumshirn@suse.de>
In-Reply-To: <20170610090536.12472-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, Johannes Thumshirn <jthumshirn@suse.de>

Currently the media code abuses the KERNEL_VERSION macro to encode a
version triplet.

Introduce a MEDIA_REVISION macro to get rid of the confusing and
creative KERNEL_VERSION usage in the media subsystem.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 include/uapi/linux/media.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/media.h b/include/uapi/linux/media.h
index 4890787731b8..25e2ae4432bd 100644
--- a/include/uapi/linux/media.h
+++ b/include/uapi/linux/media.h
@@ -30,7 +30,9 @@
 #include <linux/types.h>
 #include <linux/version.h>
 
-#define MEDIA_API_VERSION	KERNEL_VERSION(0, 1, 0)
+#define MEDIA_REVISION(a,b,c) (((a) << 16) + ((b) << 8) + (c))
+
+#define MEDIA_API_VERSION	MEDIA_REVISION(0, 1, 0)
 
 struct media_device_info {
 	char driver[16];
-- 
2.12.3

