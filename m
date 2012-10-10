From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Date: Wed, 10 Oct 2012 11:45:14 +0000
Subject: Re: [PATCH] matroxfb: Convert struct i2c_msg initialization to C99 format
Message-Id: <CAM=Q2ctuv66edb3Sa76miA=f_j2He-28xPsR+eWc-hR0xzrcYw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1349782668-9098-1-git-send-email-shubhrajyoti@ti.com>
	<20121010110521.3981a23f@endymion.delvare>
In-Reply-To: <20121010110521.3981a23f-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

On Wed, Oct 10, 2012 at 2:35 PM, Jean Delvare <khali@linux-fr.org> wrote:
> On Tue, 9 Oct 2012 17:07:48 +0530, Shubhrajyoti D wrote:
Thanks updated patch below.
From 99073779197f5759a76e65c3f4ef2ad4e9c88eaf Mon Sep 17 00:00:00 2001
From: Shubhrajyoti D <shubhrajyoti@ti.com>
Date: Mon, 17 Sep 2012 21:19:32 +0530
Subject: [PATCHv2] matroxfb: Convert struct i2c_msg initialization to C99
 format

Convert the struct i2c_msg initialization to C99 format. This makes
maintaining and editing the code simpler. Also helps once other fields
like transferred are added in future.

Thanks to Julia Lawall <julia.lawall@lip6.fr>  for automating the conversion

Acked-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/video/matrox/matroxfb_maven.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/video/matrox/matroxfb_maven.c
b/drivers/video/matrox/matroxfb_maven.c
index 217678e..f66c34c 100644
--- a/drivers/video/matrox/matroxfb_maven.c
+++ b/drivers/video/matrox/matroxfb_maven.c
@@ -137,8 +137,20 @@ static int* get_ctrl_ptr(struct maven_data* md, int idx) {

 static int maven_get_reg(struct i2c_client* c, char reg) {
 	char dst;
-	struct i2c_msg msgs[] = {{ c->addr, I2C_M_REV_DIR_ADDR, sizeof(reg), &reg },
-				 { c->addr, I2C_M_RD | I2C_M_NOSTART, sizeof(dst), &dst }};
+	struct i2c_msg msgs[] = {
+			{
+				.addr = c->addr,
+				.flags = I2C_M_REV_DIR_ADDR,
+				.len = sizeof(reg),
+				.buf = &reg
+			},
+			{
+				.addr = c->addr,
+				.flags = I2C_M_RD | I2C_M_NOSTART,
+				.len = sizeof(dst),
+				.buf = &dst
+			}
+	};
 	s32 err;

 	err = i2c_transfer(c->adapter, msgs, 2);
-- 
1.7.5.4
