From: Dave Airlie <airlied@redhat.com>
Date: Tue, 18 Jul 2017 06:09:09 +0000
Subject: [PATCH] efifb: allow user to disable write combined mapping.
Message-Id: <20170718060909.5280-1-airlied@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Peter Jones <pjones@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: luto@kernel.org, hpa@zytor.com, torvalds@linux-foundation.org, Dave Airlie <airlied@redhat.com>

This patch allows the user to disable write combined mapping
of the efifb framebuffer console using an nowc option.

A customer noticed major slowdowns while logging to the console
with write combining enabled, on other tasks running on the same
CPU. (10x or greater slow down on all other cores on the same CPU
as is doing the logging).

I reproduced this on a machine with dual CPUs.
Intel(R) Xeon(R) CPU E5-2609 v3 @ 1.90GHz (6 core)

I wrote a test that just mmaps the pci bar and writes to it in
a loop, while this was running in the background one a single
core with (taskset -c 1), building a kernel up to init/version.o
(taskset -c 8) went from 13s to 133s or so. I've yet to explain
why this occurs or what is going wrong I haven't managed to find
a perf command that in any way gives insight into this.

    11,885,070,715      instructions              #    1.39  insns per cycle
vs
    12,082,592,342      instructions              #    0.13  insns per cycle

is the only thing I've spotted of interest, I've tried at least:
dTLB-stores,dTLB-store-misses,L1-dcache-stores,LLC-store,LLC-store-misses,L=
LC-load-misses,LLC-loads,\mem-loads,mem-stores,iTLB-loads,iTLB-load-misses,=
cache-references,cache-misses

For now it seems at least a good idea to allow a user to disable write
combining if they see this until we can figure it out.

Note also most users get a real framebuffer driver loaded when kms
kicks in, it just happens on these machines the kernel didn't support
the gpu specific driver.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 Documentation/fb/efifb.txt  | 6 ++++++
 drivers/video/fbdev/efifb.c | 8 +++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/fb/efifb.txt b/Documentation/fb/efifb.txt
index a59916c..1a85c1b 100644
--- a/Documentation/fb/efifb.txt
+++ b/Documentation/fb/efifb.txt
@@ -27,5 +27,11 @@ You have to add the following kernel parameters in your =
elilo.conf:
 	Macbook Pro 17", iMac 20" :
 		video=EFifb:i20
=20
+Accepted options:
+
+nowc	Don't map the framebuffer write combined. This can be used
+	to workaround side-effects and slowdowns on other CPU cores
+	when large amounts of console data are written.
+
 --
 Edgar Hucek <gimli@dark-green.com>
diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index b827a81..a568fe0 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -17,6 +17,7 @@
 #include <asm/efi.h>
=20
 static bool request_mem_succeeded =3D false;
+static bool nowc =3D false;
=20
 static struct fb_var_screeninfo efifb_defined =3D {
 	.activate		=3D FB_ACTIVATE_NOW,
@@ -99,6 +100,8 @@ static int efifb_setup(char *options)
 				screen_info.lfb_height =3D simple_strtoul(this_opt+7, NULL, 0);
 			else if (!strncmp(this_opt, "width:", 6))
 				screen_info.lfb_width =3D simple_strtoul(this_opt+6, NULL, 0);
+			else if (!strcmp(this_opt, "nowc"))
+				nowc =3D true;
 		}
 	}
=20
@@ -255,7 +258,10 @@ static int efifb_probe(struct platform_device *dev)
 	info->apertures->ranges[0].base =3D efifb_fix.smem_start;
 	info->apertures->ranges[0].size =3D size_remap;
=20
-	info->screen_base =3D ioremap_wc(efifb_fix.smem_start, efifb_fix.smem_len=
);
+	if (nowc)
+		info->screen_base =3D ioremap(efifb_fix.smem_start, efifb_fix.smem_len);
+	else
+		info->screen_base =3D ioremap_wc(efifb_fix.smem_start, efifb_fix.smem_le=
n);
 	if (!info->screen_base) {
 		pr_err("efifb: abort, cannot ioremap video memory 0x%x @ 0x%lx\n",
 			efifb_fix.smem_len, efifb_fix.smem_start);
--=20
2.9.4

