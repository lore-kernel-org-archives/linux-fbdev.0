From: Finn Thain <fthain@telegraphics.com.au>
Date: Wed, 26 Dec 2018 00:37:59 +0000
Subject: [PATCH v8 20/25] powerpc, fbdev: Use arch_nvram_ops methods instead of nvram_read_byte() and nvram_w
Message-Id: <7e8eb87ea829c03941c895c968df2ebd0f80512f.1545784679.git.fthain@telegraphics.com.au>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1545784679.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

Make use of arch_nvram_ops in device drivers so that the nvram_* function
exports can be removed.

Since they are no longer global symbols, rename the PPC32 nvram_* functions
appropriately.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/powerpc/kernel/setup_32.c             | 8 ++++----
 drivers/char/generic_nvram.c               | 4 ++--
 drivers/video/fbdev/controlfb.c            | 4 ++--
 drivers/video/fbdev/imsttfb.c              | 4 ++--
 drivers/video/fbdev/matrox/matroxfb_base.c | 2 +-
 drivers/video/fbdev/platinumfb.c           | 4 ++--
 drivers/video/fbdev/valkyriefb.c           | 4 ++--
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index e0d045677472..bdbe6acbef11 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -152,20 +152,18 @@ __setup("l3cr=3D", ppc_setup_l3cr);
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
@@ -182,6 +180,8 @@ static long ppc_nvram_sync(void)
 }
=20
 const struct nvram_ops arch_nvram_ops =3D {
+	.read_byte      =3D ppc_nvram_read_byte,
+	.write_byte     =3D ppc_nvram_write_byte,
 	.get_size       =3D ppc_nvram_get_size,
 	.sync           =3D ppc_nvram_sync,
 };
diff --git a/drivers/char/generic_nvram.c b/drivers/char/generic_nvram.c
index f32d5663de95..41b76bf9614e 100644
--- a/drivers/char/generic_nvram.c
+++ b/drivers/char/generic_nvram.c
@@ -48,7 +48,7 @@ static ssize_t read_nvram(struct file *file, char __user =
*buf,
 	if (*ppos >=3D nvram_len)
 		return 0;
 	for (i =3D *ppos; count > 0 && i < nvram_len; ++i, ++p, --count)
-		if (__put_user(nvram_read_byte(i), p))
+		if (__put_user(arch_nvram_ops.read_byte(i), p))
 			return -EFAULT;
 	*ppos =3D i;
 	return p - buf;
@@ -68,7 +68,7 @@ static ssize_t write_nvram(struct file *file, const char =
__user *buf,
 	for (i =3D *ppos; count > 0 && i < nvram_len; ++i, ++p, --count) {
 		if (__get_user(c, p))
 			return -EFAULT;
-		nvram_write_byte(c, i);
+		arch_nvram_ops.write_byte(c, i);
 	}
 	*ppos =3D i;
 	return p - buf;
diff --git a/drivers/video/fbdev/controlfb.c b/drivers/video/fbdev/controlf=
b.c
index 9cb0ef7ac29e..27ff33ccafcb 100644
--- a/drivers/video/fbdev/controlfb.c
+++ b/drivers/video/fbdev/controlfb.c
@@ -413,7 +413,7 @@ static int __init init_control(struct fb_info_control *=
p)
 	/* Try to pick a video mode out of NVRAM if we have one. */
 #ifdef CONFIG_NVRAM
 	if (default_cmode =3D CMODE_NVRAM) {
-		cmode =3D nvram_read_byte(NV_CMODE);
+		cmode =3D arch_nvram_ops.read_byte(NV_CMODE);
 		if(cmode < CMODE_8 || cmode > CMODE_32)
 			cmode =3D CMODE_8;
 	} else
@@ -421,7 +421,7 @@ static int __init init_control(struct fb_info_control *=
p)
 		cmode=DEfault_cmode;
 #ifdef CONFIG_NVRAM
 	if (default_vmode =3D VMODE_NVRAM) {
-		vmode =3D nvram_read_byte(NV_VMODE);
+		vmode =3D arch_nvram_ops.read_byte(NV_VMODE);
 		if (vmode < 1 || vmode > VMODE_MAX ||
 		    control_mac_modes[vmode - 1].m[full] < cmode) {
 			sense =3D read_control_sense(p);
diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index 8d231591ff0e..e9f3b8914145 100644
--- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -1393,12 +1393,12 @@ static void init_imstt(struct fb_info *info)
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
diff --git a/drivers/video/fbdev/matrox/matroxfb_base.c b/drivers/video/fbd=
ev/matrox/matroxfb_base.c
index cac5865d461c..3fecc628752c 100644
--- a/drivers/video/fbdev/matrox/matroxfb_base.c
+++ b/drivers/video/fbdev/matrox/matroxfb_base.c
@@ -1876,7 +1876,7 @@ static int initMatrox2(struct matrox_fb_info *minfo, =
struct board *b)
 			default_vmode =3D VMODE_640_480_60;
 #if defined(CONFIG_PPC32) && defined(CONFIG_NVRAM)
 		if (default_cmode =3D CMODE_NVRAM)
-			default_cmode =3D nvram_read_byte(NV_CMODE);
+			default_cmode =3D arch_nvram_ops.read_byte(NV_CMODE);
 #endif
 		if (default_cmode < CMODE_8 || default_cmode > CMODE_32)
 			default_cmode =3D CMODE_8;
diff --git a/drivers/video/fbdev/platinumfb.c b/drivers/video/fbdev/platinu=
mfb.c
index bf6b7fb83cf4..3efceaf38f98 100644
--- a/drivers/video/fbdev/platinumfb.c
+++ b/drivers/video/fbdev/platinumfb.c
@@ -347,7 +347,7 @@ static int platinum_init_fb(struct fb_info *info)
 	printk(KERN_INFO "platinumfb: Monitor sense value =3D 0x%x, ", sense);
 	if (default_vmode =3D VMODE_NVRAM) {
 #ifdef CONFIG_NVRAM
-		default_vmode =3D nvram_read_byte(NV_VMODE);
+		default_vmode =3D arch_nvram_ops.read_byte(NV_VMODE);
 		if (default_vmode <=3D 0 || default_vmode > VMODE_MAX ||
 		    !platinum_reg_init[default_vmode-1])
 #endif
@@ -360,7 +360,7 @@ static int platinum_init_fb(struct fb_info *info)
 		default_vmode =3D VMODE_640_480_60;
 #ifdef CONFIG_NVRAM
 	if (default_cmode =3D CMODE_NVRAM)
-		default_cmode =3D nvram_read_byte(NV_CMODE);
+		default_cmode =3D arch_nvram_ops.read_byte(NV_CMODE);
 #endif
 	if (default_cmode < CMODE_8 || default_cmode > CMODE_32)
 		default_cmode =3D CMODE_8;
diff --git a/drivers/video/fbdev/valkyriefb.c b/drivers/video/fbdev/valkyri=
efb.c
index 8022316ee9c9..81f66d69d9dd 100644
--- a/drivers/video/fbdev/valkyriefb.c
+++ b/drivers/video/fbdev/valkyriefb.c
@@ -283,7 +283,7 @@ static void __init valkyrie_choose_mode(struct fb_info_=
valkyrie *p)
 	/* Try to pick a video mode out of NVRAM if we have one. */
 #if defined(CONFIG_PPC_PMAC) && defined(CONFIG_NVRAM)
 	if (default_vmode =3D VMODE_NVRAM) {
-		default_vmode =3D nvram_read_byte(NV_VMODE);
+		default_vmode =3D arch_nvram_ops.read_byte(NV_VMODE);
 		if (default_vmode <=3D 0
 		 || default_vmode > VMODE_MAX
 		 || !valkyrie_reg_init[default_vmode - 1])
@@ -296,7 +296,7 @@ static void __init valkyrie_choose_mode(struct fb_info_=
valkyrie *p)
 		default_vmode =3D VMODE_640_480_67;
 #if defined(CONFIG_PPC_PMAC) && defined(CONFIG_NVRAM)
 	if (default_cmode =3D CMODE_NVRAM)
-		default_cmode =3D nvram_read_byte(NV_CMODE);
+		default_cmode =3D arch_nvram_ops.read_byte(NV_CMODE);
 #endif
=20
 	/*
--=20
2.19.2
