From: Julia Lawall <julia.lawall@lip6.fr>
Date: Sat, 23 Aug 2014 15:50:28 +0000
Subject: [PATCH 8/9 v2] video: fbdev: aty: use c99 initializers in structures
Message-Id: <alpine.DEB.2.02.1408231749030.2068@localhost6.localdomain6>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1408792831-25615-1-git-send-email-Julia.Lawall@lip6.fr> <1408792831-25615-9-git-send-email-Julia.Lawall@lip6.fr> <20140823152015.GB2074@thin>
In-Reply-To: <20140823152015.GB2074@thin>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Josh Triplett <josh@joshtriplett.org>
Cc: Paul Mackerras <paulus@samba.org>, kernel-janitors@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

From nobody Sat Aug 23 12:48:19 CEST 2014
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Paul Mackerras <paulus@samba.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,Tomi Valkeinen <tomi.valkeinen@ti.com>,linux-fbdev@vger.kernel.org,linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] video: fbdev: aty: use c99 initializers in structures

From: Julia Lawall <Julia.Lawall@lip6.fr>

Use c99 initializers for structures.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@decl@
identifier i1,fld;
type T;
field list[n] fs;
@@

struct i1 {
 fs
 T fld;
 ...};

@bad@
identifier decl.i1,i2;
expression e;
initializer list[decl.n] is;
@@

struct i1 i2 = { is,
+ .fld = e
- e
 ,...};
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
The patches in this series do not depend on each other.

v2: Move close braces down to the next line and add trailing commas, as 
suggested by Josh Triplett.

diff --git a/drivers/video/fbdev/aty/aty128fb.c b/drivers/video/fbdev/aty/aty128fb.c
index ff60701..aedf2fb 100644
--- a/drivers/video/fbdev/aty/aty128fb.c
+++ b/drivers/video/fbdev/aty/aty128fb.c
@@ -324,14 +324,61 @@ struct aty128_meminfo {
 };
 
 /* various memory configurations */
-static const struct aty128_meminfo sdr_128   -	{ 4, 4, 3, 3, 1, 3, 1, 16, 30, 16, "128-bit SDR SGRAM (1:1)" };
-static const struct aty128_meminfo sdr_64    -	{ 4, 8, 3, 3, 1, 3, 1, 17, 46, 17, "64-bit SDR SGRAM (1:1)" };
-static const struct aty128_meminfo sdr_sgram -	{ 4, 4, 1, 2, 1, 2, 1, 16, 24, 16, "64-bit SDR SGRAM (2:1)" };
-static const struct aty128_meminfo ddr_sgram -	{ 4, 4, 3, 3, 2, 3, 1, 16, 31, 16, "64-bit DDR SGRAM" };
+static const struct aty128_meminfo sdr_128 = {
+	.ML = 4,
+	.MB = 4,
+	.Trcd = 3,
+	.Trp = 3,
+	.Twr = 1,
+	.CL = 3,
+	.Tr2w = 1,
+	.LoopLatency = 16,
+	.DspOn = 30,
+	.Rloop = 16,
+	.name = "128-bit SDR SGRAM (1:1)",
+};
+
+static const struct aty128_meminfo sdr_64 = {
+	.ML = 4,
+	.MB = 8,
+	.Trcd = 3,
+	.Trp = 3,
+	.Twr = 1,
+	.CL = 3,
+	.Tr2w = 1,
+	.LoopLatency = 17,
+	.DspOn = 46,
+	.Rloop = 17,
+	.name = "64-bit SDR SGRAM (1:1)",
+};
+
+static const struct aty128_meminfo sdr_sgram = {
+	.ML = 4,
+	.MB = 4,
+	.Trcd = 1,
+	.Trp = 2,
+	.Twr = 1,
+	.CL = 2,
+	.Tr2w = 1,
+	.LoopLatency = 16,
+	.DspOn = 24,
+	.Rloop = 16,
+	.name = "64-bit SDR SGRAM (2:1)",
+};
+
+static const struct aty128_meminfo ddr_sgram = {
+	.ML = 4,
+	.MB = 4,
+	.Trcd = 3,
+	.Trp = 3,
+	.Twr = 2,
+	.CL = 3,
+	.Tr2w = 1,
+	.LoopLatency = 16,
+	.DspOn = 31,
+	.Rloop = 16,
+	.name = "64-bit DDR SGRAM",
+};
 
 static struct fb_fix_screeninfo aty128fb_fix = {
 	.id		= "ATY Rage128",
