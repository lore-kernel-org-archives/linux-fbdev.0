From: Li Heng <liheng40@huawei.com>
Date: Thu, 24 Sep 2020 14:18:26 +0000
Subject: [PATCH -next] video: Remove set but not used variable
Message-Id: <1600957106-13741-1-git-send-email-liheng40@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: tomi.valkeinen@ti.com, b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/video/fbdev/sis/300vtbl.h:1064:28: warning:
‘SiS300_CHTVVCLKSONTSC’ defined but not used [-Wunused-const-variable=]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Li Heng <liheng40@huawei.com>
---
 drivers/video/fbdev/sis/300vtbl.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/fbdev/sis/300vtbl.h b/drivers/video/fbdev/sis/300vtbl.h
index e4b4a26..26b19f7 100644
--- a/drivers/video/fbdev/sis/300vtbl.h
+++ b/drivers/video/fbdev/sis/300vtbl.h
@@ -1061,8 +1061,6 @@ static const unsigned char SiS300_CHTVVCLKUNTSC[]  = { 0x29,0x29,0x29,0x29,0x2a,

 static const unsigned char SiS300_CHTVVCLKONTSC[]  = { 0x2c,0x2c,0x2c,0x2c,0x2d,0x2b };

-static const unsigned char SiS300_CHTVVCLKSONTSC[] = { 0x2c,0x2c,0x2c,0x2c,0x2d,0x2b };
-
 static const unsigned char SiS300_CHTVVCLKUPAL[]   = { 0x2f,0x2f,0x2f,0x2f,0x2f,0x31 };

 static const unsigned char SiS300_CHTVVCLKOPAL[]   = { 0x2f,0x2f,0x2f,0x2f,0x30,0x32 };
--
2.7.4
