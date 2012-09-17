From: Shubhrajyoti D <shubhrajyoti@ti.com>
Date: Mon, 17 Sep 2012 15:55:44 +0000
Subject: [PATCH] matroxfb: Convert struct i2c_msg initialization to C99 format
Message-Id: <1347897325-20684-1-git-send-email-shubhrajyoti@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, julia.lawall@lip6.fr, Shubhrajyoti D <shubhrajyoti@ti.com>

Convert the struct i2c_msg initialization to C99 format. This makes
maintaining and editing the code simpler. Also helps once other fields
like transferred are added in future.

Thanks to Julia Lawall <julia.lawall@lip6.fr>  for automating the conversion

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
the cocci file was posted
http://www.mail-archive.com/cocci@diku.dk/msg02753.html

 drivers/video/matrox/matroxfb_maven.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/video/matrox/matroxfb_maven.c b/drivers/video/matrox/matroxfb_maven.c
index 217678e..fb5c123 100644
--- a/drivers/video/matrox/matroxfb_maven.c
+++ b/drivers/video/matrox/matroxfb_maven.c
@@ -137,8 +137,19 @@ static int* get_ctrl_ptr(struct maven_data* md, int idx) {
 
 static int maven_get_reg(struct i2c_client* c, char reg) {
 	char dst;
-	struct i2c_msg msgs[] = {{ c->addr, I2C_M_REV_DIR_ADDR, sizeof(reg), &reg },
-				 { c->addr, I2C_M_RD | I2C_M_NOSTART, sizeof(dst), &dst }};
+	struct i2c_msg msgs[] = {{
+					.addr = c->addr,
+					.flags = I2C_M_REV_DIR_ADDR,
+					.len = sizeof(reg),
+					.buf = &reg
+				},
+				{
+					.addr = c->addr,
+					.flags = I2C_M_RD | I2C_M_NOSTART,
+					.len = sizeof(dst),
+					.buf = &dst
+				}
+	};
 	s32 err;
 
 	err = i2c_transfer(c->adapter, msgs, 2);
-- 
1.7.5.4

