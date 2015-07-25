From: Finn Thain <fthain@telegraphics.com.au>
Date: Sat, 25 Jul 2015 07:46:17 +0000
Subject: [RFC v5 18/26] powerpc, fbdev: Use arch_nvram_ops methods instead of nvram_read_byte() and nvram_wri
Message-Id: <20150725074603.913344361@telegraphics.com.au>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150725074559.543547894@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

Make use of arch_nvram_ops in device drivers so that the nvram_* function
exports can be removed.

Since they are no longer global symbols, rename the PPC32 nvram_* functions
appropriately.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

---

Changed since v4:
- Split off the CONFIG_PPC32, CONFIG_PPC_PMAC and CONFIG_NVRAM tests into
a separate patch.

---
 arch/powerpc/kernel/setup_32.c             |    8 ++++----
 drivers/char/generic_nvram.c               |    4 ++--
 drivers/video/fbdev/controlfb.c            |    4 ++--
 drivers/video/fbdev/imsttfb.c              |    4 ++--
 drivers/video/fbdev/matrox/matroxfb_base.c |    2 +-
 drivers/video/fbdev/platinumfb.c           |    4 ++--
 drivers/video/fbdev/valkyriefb.c           |    4 ++--
 7 files changed, 15 insertions(+), 15 deletions(-)

Index: linux/arch/powerpc/kernel/setup_32.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- linux.orig/arch/powerpc/kernel/setup_32.c	2015-=
07-25 17:45:42.000000000 +1000
+++ linux/arch/powerpc/kernel/setup_32.c	2015-07-25 17:45:45.000000000 +1000
@@ -170,20 +170,18 @@ __setup("l3cr=3D", ppc_setup_l3cr);
=20
 #ifdef CONFIG_GENERIC_NVRAM
=20
-unsigned char nvram_read_byte(int addr)
+static unsigned char ppc_nvram_read_byte(int addr)
 {
 	if (ppc_md.nvram_read_val)
 		return ppc_md.nvram_read_val(addr);
 	return 0xff;
 }
-EXPORT_SYMBOL(nvram_read_byte);
=20
-void nvram_write_byte(unsigned char val, int addr)
+static void ppc_nvram_write_byte(unsigned char val, int addr)
 {
 	if (ppc_md.nvram_write_val)
 		ppc_md.nvram_write_val(addr, val);
 }
-EXPORT_SYMBOL(nvram_write_byte);
=20
 static ssize_t ppc_nvram_get_size(void)
 {
@@ -200,6 +198,8 @@ static long ppc_nvram_sync(void)
 }
=20
 const struct nvram_ops arch_nvram_ops =3D {
+	.read_byte      =3D ppc_nvram_read_byte,
+	.write_byte     =3D ppc_nvram_write_byte,
 	.get_size       =3D ppc_nvram_get_size,
 	.sync           =3D ppc_nvram_sync,
 };
Index: linux/drivers/char/generic_nvram.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- linux.orig/drivers/char/generic_nvram.c	2015-07=
-25 17:45:42.000000000 +1000
+++ linux/drivers/char/generic_nvram.c	2015-07-25 17:45:45.000000000 +1000
@@ -63,7 +63,7 @@ static ssize_t read_nvram(struct file *f
 	if (*ppos >=3D nvram_len)
 		return 0;
 	for (i =3D *ppos; count > 0 && i < nvram_len; ++i, ++p, --count)
-		if (__put_user(nvram_read_byte(i), p))
+		if (__put_user(arch_nvram_ops.read_byte(i), p))
 			return -EFAULT;
 	*ppos =3D i;
 	return p - buf;
@@ -83,7 +83,7 @@ static ssize_t write_nvram(struct file *
 	for (i =3D *ppos; count > 0 && i < nvram_len; ++i, ++p, --count) {
 		if (__get_user(c, p))
 			return -EFAULT;
-		nvram_write_byte(c, i);
+		arch_nvram_ops.write_byte(c, i);
 	}
 	*ppos =3D i;
 	return p - buf;
Index: linux/drivers/video/fbdev/controlfb.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- linux.orig/drivers/video/fbdev/controlfb.c	2015=
-07-25 17:42:34.000000000 +1000
+++ linux/drivers/video/fbdev/controlfb.c	2015-07-25 17:45:45.000000000 +10=
00
@@ -415,7 +415,7 @@ static int __init init_control(struct fb
 	/* Try to pick a video mode out of NVRAM if we have one. */
 #ifdef CONFIG_NVRAM
 	if (default_cmode =3D CMODE_NVRAM) {
-		cmode =3D nvram_read_byte(NV_CMODE);
+		cmode =3D arch_nvram_ops.read_byte(NV_CMODE);
 		if(cmode < CMODE_8 || cmode > CMODE_32)
 			cmode =3D CMODE_8;
 	} else
@@ -423,7 +423,7 @@ static int __init init_control(struct fb
 		cmode=DEfault_cmode;
 #ifdef CONFIG_NVRAM
 	if (default_vmode =3D VMODE_NVRAM) {
-		vmode =3D nvram_read_byte(NV_VMODE);
+		vmode =3D arch_nvram_ops.read_byte(NV_VMODE);
 		if (vmode < 1 || vmode > VMODE_MAX ||
 		    control_mac_modes[vmode - 1].m[full] < cmode) {
 			sense =3D read_control_sense(p);
Index: linux/drivers/video/fbdev/imsttfb.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- linux.orig/drivers/video/fbdev/imsttfb.c	2015-0=
7-25 17:45:44.000000000 +1000
+++ linux/drivers/video/fbdev/imsttfb.c	2015-07-25 17:45:45.000000000 +1000
@@ -1393,12 +1393,12 @@ static void init_imstt(struct fb_info *i
 		int vmode =3D init_vmode, cmode =3D init_cmode;
=20
 		if (vmode =3D -1) {
-			vmode =3D nvram_read_byte(NV_VMODE);
+			vmode =3D arch_nvram_ops.read_byte(NV_VMODE);
 			if (vmode <=3D 0 || vmode > VMODE_MAX)
 				vmode =3D VMODE_640_480_67;
 		}
 		if (cmode =3D -1) {
-			cmode =3D nvram_read_byte(NV_CMODE);
+			cmode =3D arch_nvram_ops.read_byte(NV_CMODE);
 			if (cmode < CMODE_8 || cmode > CMODE_32)
 				cmode =3D CMODE_8;
 		}
Index: linux/drivers/video/fbdev/matrox/matroxfb_base.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- linux.orig/drivers/video/fbdev/matrox/matroxfb_=
base.c	2015-07-25 17:45:44.000000000 +1000
+++ linux/drivers/video/fbdev/matrox/matroxfb_base.c	2015-07-25 17:45:45.00=
0000000 +1000
@@ -1878,7 +1878,7 @@ static int initMatrox2(struct matrox_fb_
 			default_vmode =3D VMODE_640_480_60;
 #if defined(CONFIG_PPC32) && defined(CONFIG_NVRAM)
 		if (default_cmode =3D CMODE_NVRAM)
-			default_cmode =3D nvram_read_byte(NV_CMODE);
+			default_cmode =3D arch_nvram_ops.read_byte(NV_CMODE);
 #endif
 		if (default_cmode < CMODE_8 || default_cmode > CMODE_32)
 			default_cmode =3D CMODE_8;
Index: linux/drivers/video/fbdev/platinumfb.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- linux.orig/drivers/video/fbdev/platinumfb.c	201=
5-07-25 17:42:34.000000000 +1000
+++ linux/drivers/video/fbdev/platinumfb.c	2015-07-25 17:45:45.000000000 +1=
000
@@ -349,7 +349,7 @@ static int platinum_init_fb(struct fb_in
 	printk(KERN_INFO "platinumfb: Monitor sense value =3D 0x%x, ", sense);
 	if (default_vmode =3D VMODE_NVRAM) {
 #ifdef CONFIG_NVRAM
-		default_vmode =3D nvram_read_byte(NV_VMODE);
+		default_vmode =3D arch_nvram_ops.read_byte(NV_VMODE);
 		if (default_vmode <=3D 0 || default_vmode > VMODE_MAX ||
 		    !platinum_reg_init[default_vmode-1])
 #endif
@@ -362,7 +362,7 @@ static int platinum_init_fb(struct fb_in
 		default_vmode =3D VMODE_640_480_60;
 #ifdef CONFIG_NVRAM
 	if (default_cmode =3D CMODE_NVRAM)
-		default_cmode =3D nvram_read_byte(NV_CMODE);
+		default_cmode =3D arch_nvram_ops.read_byte(NV_CMODE);
 #endif
 	if (default_cmode < CMODE_8 || default_cmode > CMODE_32)
 		default_cmode =3D CMODE_8;
Index: linux/drivers/video/fbdev/valkyriefb.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- linux.orig/drivers/video/fbdev/valkyriefb.c	201=
5-07-25 17:45:44.000000000 +1000
+++ linux/drivers/video/fbdev/valkyriefb.c	2015-07-25 17:45:45.000000000 +1=
000
@@ -285,7 +285,7 @@ static void __init valkyrie_choose_mode(
 	/* Try to pick a video mode out of NVRAM if we have one. */
 #if defined(CONFIG_PPC_PMAC) && defined(CONFIG_NVRAM)
 	if (default_vmode =3D VMODE_NVRAM) {
-		default_vmode =3D nvram_read_byte(NV_VMODE);
+		default_vmode =3D arch_nvram_ops.read_byte(NV_VMODE);
 		if (default_vmode <=3D 0
 		 || default_vmode > VMODE_MAX
 		 || !valkyrie_reg_init[default_vmode - 1])
@@ -298,7 +298,7 @@ static void __init valkyrie_choose_mode(
 		default_vmode =3D VMODE_640_480_67;
 #if defined(CONFIG_PPC_PMAC) && defined(CONFIG_NVRAM)
 	if (default_cmode =3D CMODE_NVRAM)
-		default_cmode =3D nvram_read_byte(NV_CMODE);
+		default_cmode =3D arch_nvram_ops.read_byte(NV_CMODE);
 #endif
=20
 	/*


