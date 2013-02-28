From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 28 Feb 2013 09:39:08 +0000
Subject: [PATCH RESEND] matroxfb: Convert struct i2c_msg initialization to C99 format
Message-Id: <20130228103908.48c7d2c4@endymion.delvare>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>

Convert the struct i2c_msg initialization to C99 format. This makes
maintaining and editing the code simpler. Also helps once other fields
like transferred are added in future.

Thanks to Julia Lawall for automating the conversion.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
Patch already sent by Shubhrajyoti Datta on 2012-10-10.

 drivers/video/matrox/matroxfb_maven.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- linux-3.9-rc0.orig/drivers/video/matrox/matroxfb_maven.c	2013-02-28 09:30:13.134091106 +0100
+++ linux-3.9-rc0/drivers/video/matrox/matroxfb_maven.c	2013-02-28 09:55:14.731092841 +0100
@@ -137,8 +137,20 @@ static int* get_ctrl_ptr(struct maven_da
 
 static int maven_get_reg(struct i2c_client* c, char reg) {
 	char dst;
-	struct i2c_msg msgs[] = {{ c->addr, I2C_M_REV_DIR_ADDR, sizeof(reg), &reg },
-				 { c->addr, I2C_M_RD | I2C_M_NOSTART, sizeof(dst), &dst }};
+	struct i2c_msg msgs[] = {
+		{
+			.addr = c->addr,
+			.flags = I2C_M_REV_DIR_ADDR,
+			.len = sizeof(reg),
+			.buf = &reg
+		},
+		{
+			.addr = c->addr,
+			.flags = I2C_M_RD | I2C_M_NOSTART,
+			.len = sizeof(dst),
+			.buf = &dst
+		}
+	};
 	s32 err;
 
 	err = i2c_transfer(c->adapter, msgs, 2);


-- 
Jean Delvare
