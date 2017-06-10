From: Johannes Thumshirn <jthumshirn@suse.de>
Date: Sat, 10 Jun 2017 09:05:34 +0000
Subject: [PATCH 5/7] [media] media: s3c-camif: Use MEDIA_REVISON instead of KERNEL_VERSION
Message-Id: <20170610090536.12472-6-jthumshirn@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170610090536.12472-1-jthumshirn@suse.de>
In-Reply-To: <20170610090536.12472-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, Johannes Thumshirn <jthumshirn@suse.de>

Use MEDIA_REVISON instead of KERNEL_VERSION to encode the driver
version.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/media/platform/s3c-camif/camif-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/s3c-camif/camif-core.c b/drivers/media/platform/s3c-camif/camif-core.c
index ec4001970313..98bd5719fdf5 100644
--- a/drivers/media/platform/s3c-camif/camif-core.c
+++ b/drivers/media/platform/s3c-camif/camif-core.c
@@ -317,7 +317,7 @@ static int camif_media_dev_init(struct camif_dev *camif)
 		 ip_rev = S3C6410_CAMIF_IP_REV ? "6410" : "244X");
 	strlcpy(md->bus_info, "platform", sizeof(md->bus_info));
 	md->hw_revision = ip_rev;
-	md->driver_version = KERNEL_VERSION(1, 0, 0);
+	md->driver_version = MEDIA_REVISION(1, 0, 0);
 
 	md->dev = camif->dev;
 
-- 
2.12.3

