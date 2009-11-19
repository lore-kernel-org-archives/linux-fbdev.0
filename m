From: Jun Nie <niej0001@gmail.com>
Date: Thu, 19 Nov 2009 09:02:03 +0000
Subject: Re: [PATCH 6/8] pxa: add gpio expander on pxa168 aspenite platform
Message-Id: <7c34ac520911190102o5e797181geb40b19d99cdec91@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0016e648bcbede310a0478b59cb8"
List-Id: <linux-fbdev.vger.kernel.org>
References: <7c34ac520911160134s50f387a3s91485a797a37ce0a@mail.gmail.com>
In-Reply-To: <7c34ac520911160134s50f387a3s91485a797a37ce0a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org

--0016e648bcbede310a0478b59cb8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2009/11/16 Jun Nie <niej0001@gmail.com>:
> From: Jun Nie <njun@marvell.com>
> Date: Fri, 13 Nov 2009 14:19:05 +0800
> Subject: [PATCH] pxa: add gpio expander on pxa168 aspenite platform
>
> Signed-off-by: Jun Nie <njun@marvell.com>
> ---
> =A0arch/arm/mach-mmp/aspenite.c | =A0 46 ++++++++++++++++++++++++++++++++=
++++++++++
> =A0drivers/gpio/pca953x.c =A0 =A0 =A0 | =A0 =A01 +
> =A02 files changed, 47 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
> index 115f728..21cecfc 100644
> --- a/arch/arm/mach-mmp/aspenite.c
> +++ b/arch/arm/mach-mmp/aspenite.c
> @@ -16,6 +16,7 @@
> =A0#include <linux/mtd/mtd.h>
> =A0#include <linux/mtd/partitions.h>
> =A0#include <linux/mtd/nand.h>
> +#include <linux/i2c/pca953x.h>
>
> =A0#include <asm/mach-types.h>
> =A0#include <asm/mach/arch.h>
> @@ -24,9 +25,14 @@
> =A0#include <mach/pxa168.h>
> =A0#include <mach/gpio.h>
> =A0#include <plat/pxa3xx_nand.h>
> +#include <video/pxa168fb.h>
>
> =A0#include "common.h"
>
> +/*used by expander max7312, 16 pins gpio expander */
> +#define GPIO_EXT0(x) =A0 =A0 =A0 =A0 =A0 (NR_BUILTIN_GPIO + (x))
> +#define GPIO_EXT1(x) =A0 =A0 =A0 =A0 =A0 (NR_BUILTIN_GPIO + 16 + (x))
> +
> =A0static unsigned long common_pin_config[] __initdata =3D {
> =A0 =A0 =A0 =A0/* Data Flash Interface */
> =A0 =A0 =A0 =A0GPIO0_DFI_D15,
> @@ -134,6 +140,44 @@ static void __init apn_init_nand(void)
> =A0static void __init apn_init_nand(void) {}
> =A0#endif
>
> +static struct i2c_pxa_platform_data pwri2c_info __initdata =3D {
> + =A0 =A0 =A0 .use_pio =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 1,
> +};
> +
> +#if defined(CONFIG_GPIO_PCA953X)
> +/* GPIO expander max7312 could reuse PCA953X */
> +static struct pca953x_platform_data max7312_data[] =3D {
> + =A0 =A0 =A0 /* two max7312 in system */
> +
> + =A0 =A0 =A0 [0] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .gpio_base =A0 =A0 =A0=3D GPIO_EXT0(0),
> + =A0 =A0 =A0 },
> +
> + =A0 =A0 =A0 [1] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .gpio_base =A0 =A0 =A0=3D GPIO_EXT1(0),
> + =A0 =A0 =A0 },
> +};
> +#endif
> +
> +static struct i2c_board_info aspenite_i2c_board_info[] =3D {
> +
> +#if defined(CONFIG_GPIO_PCA953X)
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type =A0 =A0 =A0 =A0 =A0 =3D "max7312",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D 0x10, =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 /* 0x20/0x21 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .irq =A0 =A0 =A0 =A0 =A0 =A0=3D IRQ_GPIO(12=
2),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =A0=3D &max7312_data[0],
> + =A0 =A0 =A0 },
> +
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type =A0 =A0 =A0 =A0 =A0 =3D "max7312",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D 0x20, =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 /* 0x40/0x41 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .irq =A0 =A0 =A0 =A0 =A0 =A0=3D IRQ_GPIO(12=
0),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =A0=3D &max7312_data[1],
> + =A0 =A0 =A0 },
> +#endif
> +};
> +
> =A0static void __init common_init(void)
> =A0{
> =A0 =A0 =A0 =A0mfp_config(ARRAY_AND_SIZE(common_pin_config));
> @@ -142,6 +186,8 @@ static void __init common_init(void)
> =A0 =A0 =A0 =A0pxa168_add_uart(1);
>
> =A0 =A0 =A0 =A0apn_init_nand();
> + =A0 =A0 =A0 pxa168_add_twsi(0, &pwri2c_info,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_AND_SIZE(aspenite_i2c=
_board_info));
>
> =A0 =A0 =A0 =A0/* off-chip devices */
> =A0 =A0 =A0 =A0platform_device_register(&smc91x_device);
> diff --git a/drivers/gpio/pca953x.c b/drivers/gpio/pca953x.c
> index 6a2fb3f..7822684 100644
> --- a/drivers/gpio/pca953x.c
> +++ b/drivers/gpio/pca953x.c
> @@ -39,6 +39,7 @@ static const struct i2c_device_id pca953x_id[] =3D {
> =A0 =A0 =A0 =A0{ "pca9557", 8, },
>
> =A0 =A0 =A0 =A0{ "max7310", 8, },
> + =A0 =A0 =A0 { "max7312", 16, },
> =A0 =A0 =A0 =A0{ "max7315", 8, },
> =A0 =A0 =A0 =A0{ "pca6107", 8, },
> =A0 =A0 =A0 =A0{ "tca6408", 8, },
> --
> 1.5.4.3
>

rebased

From: Jun Nie <njun@marvell.com>
Date: Tue, 17 Nov 2009 19:49:19 +0800
Subject: [PATCH] pxa: add gpio expander on pxa168 aspenite platform

Signed-off-by: Jun Nie <njun@marvell.com>
---
 arch/arm/mach-mmp/aspenite.c |   46 ++++++++++++++++++++++++++++++++++++++=
++++
 drivers/gpio/pca953x.c       |    1 +
 2 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 4562452..cc211d2 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -13,7 +13,9 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/smc91x.h>
+#include <linux/i2c/pca953x.h>

+#include <video/pxa168fb.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/addr-map.h>
@@ -23,6 +25,10 @@

 #include "common.h"

+/*used by expander max7312, 16 pins gpio expander */
+#define GPIO_EXT0(x)		(NR_BUILTIN_GPIO + (x))
+#define GPIO_EXT1(x)		(NR_BUILTIN_GPIO + 16 + (x))
+
 static unsigned long common_pin_config[] __initdata =3D {
 	/* Data Flash Interface */
 	GPIO0_DFI_D15,
@@ -85,12 +91,52 @@ static struct platform_device smc91x_device =3D {
 	.resource	=3D smc91x_resources,
 };

+static struct i2c_pxa_platform_data pwri2c_info __initdata =3D {
+	.use_pio		=3D 1,
+};
+
+#if defined(CONFIG_GPIO_PCA953X)
+/* GPIO expander max7312 could reuse PCA953X */
+static struct pca953x_platform_data max7312_data[] =3D {
+	/* two max7312 in system */
+
+	[0] =3D {
+		.gpio_base      =3D GPIO_EXT0(0),
+	},
+
+	[1] =3D {
+		.gpio_base      =3D GPIO_EXT1(0),
+	},
+};
+#endif
+
+static struct i2c_board_info aspenite_i2c_board_info[] =3D {
+
+#if defined(CONFIG_GPIO_PCA953X)
+	{
+		.type           =3D "max7312",
+		.addr           =3D 0x10,                 /* 0x20/0x21 */
+		.irq            =3D IRQ_GPIO(122),
+		.platform_data  =3D &max7312_data[0],
+	},
+
+	{
+		.type           =3D "max7312",
+		.addr           =3D 0x20,                 /* 0x40/0x41 */
+		.irq            =3D IRQ_GPIO(120),
+		.platform_data  =3D &max7312_data[1],
+	},
+#endif
+};
+
 static void __init common_init(void)
 {
 	mfp_config(ARRAY_AND_SIZE(common_pin_config));

 	/* on-chip devices */
 	pxa168_add_uart(1);
+	pxa168_add_twsi(0, &pwri2c_info,
+			ARRAY_AND_SIZE(aspenite_i2c_board_info));

 	/* off-chip devices */
 	platform_device_register(&smc91x_device);
diff --git a/drivers/gpio/pca953x.c b/drivers/gpio/pca953x.c
index 6a2fb3f..7822684 100644
--- a/drivers/gpio/pca953x.c
+++ b/drivers/gpio/pca953x.c
@@ -39,6 +39,7 @@ static const struct i2c_device_id pca953x_id[] =3D {
 	{ "pca9557", 8, },

 	{ "max7310", 8, },
+	{ "max7312", 16, },
 	{ "max7315", 8, },
 	{ "pca6107", 8, },
 	{ "tca6408", 8, },
--=20
1.5.4.3

--0016e648bcbede310a0478b59cb8
Content-Type: text/x-diff; charset=US-ASCII; 
	name="0006-pxa-add-gpio-expander-on-pxa168-aspenite-platform.patch"
Content-Disposition: attachment; 
	filename="0006-pxa-add-gpio-expander-on-pxa168-aspenite-platform.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g27ai4981

RnJvbSA3NmFjZDM0NmQyZTRhMGNlMmE1ZGFmZjgxN2Q0NTBjYWNjYzI4NmJlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKdW4gTmllIDxuanVuQG1hcnZlbGwuY29tPgpEYXRlOiBUaHUs
IDE5IE5vdiAyMDA5IDE2OjUyOjQ2ICswODAwClN1YmplY3Q6IFtQQVRDSF0gcHhhOiBhZGQgZ3Bp
byBleHBhbmRlciBvbiBweGExNjggYXNwZW5pdGUgcGxhdGZvcm0KClNpZ25lZC1vZmYtYnk6IEp1
biBOaWUgPG5qdW5AbWFydmVsbC5jb20+Ci0tLQogYXJjaC9hcm0vbWFjaC1tbXAvYXNwZW5pdGUu
YyB8ICAgNDUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiBkcml2
ZXJzL2dwaW8vcGNhOTUzeC5jICAgICAgIHwgICAgMSArCiAyIGZpbGVzIGNoYW5nZWQsIDQ2IGlu
c2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1t
bXAvYXNwZW5pdGUuYyBiL2FyY2gvYXJtL21hY2gtbW1wL2FzcGVuaXRlLmMKaW5kZXggNDU2MjQ1
Mi4uZDFkNGEwZCAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1tbXAvYXNwZW5pdGUuYworKysg
Yi9hcmNoL2FybS9tYWNoLW1tcC9hc3Blbml0ZS5jCkBAIC0xMyw2ICsxMyw3IEBACiAjaW5jbHVk
ZSA8bGludXgva2VybmVsLmg+CiAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+CiAj
aW5jbHVkZSA8bGludXgvc21jOTF4Lmg+CisjaW5jbHVkZSA8bGludXgvaTJjL3BjYTk1M3guaD4K
IAogI2luY2x1ZGUgPGFzbS9tYWNoLXR5cGVzLmg+CiAjaW5jbHVkZSA8YXNtL21hY2gvYXJjaC5o
PgpAQCAtMjMsNiArMjQsMTAgQEAKIAogI2luY2x1ZGUgImNvbW1vbi5oIgogCisvKnVzZWQgYnkg
ZXhwYW5kZXIgbWF4NzMxMiwgMTYgcGlucyBncGlvIGV4cGFuZGVyICovCisjZGVmaW5lIEdQSU9f
RVhUMCh4KQkJKE5SX0JVSUxUSU5fR1BJTyArICh4KSkKKyNkZWZpbmUgR1BJT19FWFQxKHgpCQko
TlJfQlVJTFRJTl9HUElPICsgMTYgKyAoeCkpCisKIHN0YXRpYyB1bnNpZ25lZCBsb25nIGNvbW1v
bl9waW5fY29uZmlnW10gX19pbml0ZGF0YSA9IHsKIAkvKiBEYXRhIEZsYXNoIEludGVyZmFjZSAq
LwogCUdQSU8wX0RGSV9EMTUsCkBAIC04NSwxMiArOTAsNTIgQEAgc3RhdGljIHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2Ugc21jOTF4X2RldmljZSA9IHsKIAkucmVzb3VyY2UJPSBzbWM5MXhfcmVzb3Vy
Y2VzLAogfTsKIAorc3RhdGljIHN0cnVjdCBpMmNfcHhhX3BsYXRmb3JtX2RhdGEgcHdyaTJjX2lu
Zm8gX19pbml0ZGF0YSA9IHsKKwkudXNlX3BpbwkJPSAwLAorfTsKKworI2lmIGRlZmluZWQoQ09O
RklHX0dQSU9fUENBOTUzWCkKKy8qIEdQSU8gZXhwYW5kZXIgbWF4NzMxMiBjb3VsZCByZXVzZSBQ
Q0E5NTNYICovCitzdGF0aWMgc3RydWN0IHBjYTk1M3hfcGxhdGZvcm1fZGF0YSBtYXg3MzEyX2Rh
dGFbXSA9IHsKKwkvKiB0d28gbWF4NzMxMiBpbiBzeXN0ZW0gKi8KKworCVswXSA9IHsKKwkJLmdw
aW9fYmFzZSAgICAgID0gR1BJT19FWFQwKDApLAorCX0sCisKKwlbMV0gPSB7CisJCS5ncGlvX2Jh
c2UgICAgICA9IEdQSU9fRVhUMSgwKSwKKwl9LAorfTsKKyNlbmRpZgorCitzdGF0aWMgc3RydWN0
IGkyY19ib2FyZF9pbmZvIGFzcGVuaXRlX2kyY19ib2FyZF9pbmZvW10gPSB7CisKKyNpZiBkZWZp
bmVkKENPTkZJR19HUElPX1BDQTk1M1gpCisJeworCQkudHlwZSAgICAgICAgICAgPSAibWF4NzMx
MiIsCisJCS5hZGRyICAgICAgICAgICA9IDB4MTAsICAgICAgICAgICAgICAgICAvKiAweDIwLzB4
MjEgKi8KKwkJLmlycSAgICAgICAgICAgID0gSVJRX0dQSU8oMTIyKSwKKwkJLnBsYXRmb3JtX2Rh
dGEgID0gJm1heDczMTJfZGF0YVswXSwKKwl9LAorCisJeworCQkudHlwZSAgICAgICAgICAgPSAi
bWF4NzMxMiIsCisJCS5hZGRyICAgICAgICAgICA9IDB4MjAsICAgICAgICAgICAgICAgICAvKiAw
eDQwLzB4NDEgKi8KKwkJLmlycSAgICAgICAgICAgID0gSVJRX0dQSU8oMTIwKSwKKwkJLnBsYXRm
b3JtX2RhdGEgID0gJm1heDczMTJfZGF0YVsxXSwKKwl9LAorI2VuZGlmCit9OworCiBzdGF0aWMg
dm9pZCBfX2luaXQgY29tbW9uX2luaXQodm9pZCkKIHsKIAltZnBfY29uZmlnKEFSUkFZX0FORF9T
SVpFKGNvbW1vbl9waW5fY29uZmlnKSk7CiAKIAkvKiBvbi1jaGlwIGRldmljZXMgKi8KIAlweGEx
NjhfYWRkX3VhcnQoMSk7CisJcHhhMTY4X2FkZF90d3NpKDAsICZwd3JpMmNfaW5mbywKKwkJCUFS
UkFZX0FORF9TSVpFKGFzcGVuaXRlX2kyY19ib2FyZF9pbmZvKSk7CiAKIAkvKiBvZmYtY2hpcCBk
ZXZpY2VzICovCiAJcGxhdGZvcm1fZGV2aWNlX3JlZ2lzdGVyKCZzbWM5MXhfZGV2aWNlKTsKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3Bpby9wY2E5NTN4LmMgYi9kcml2ZXJzL2dwaW8vcGNhOTUzeC5j
CmluZGV4IDZhMmZiM2YuLjc4MjI2ODQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3Bpby9wY2E5NTN4
LmMKKysrIGIvZHJpdmVycy9ncGlvL3BjYTk1M3guYwpAQCAtMzksNiArMzksNyBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IGkyY19kZXZpY2VfaWQgcGNhOTUzeF9pZFtdID0gewogCXsgInBjYTk1NTci
LCA4LCB9LAogCiAJeyAibWF4NzMxMCIsIDgsIH0sCisJeyAibWF4NzMxMiIsIDE2LCB9LAogCXsg
Im1heDczMTUiLCA4LCB9LAogCXsgInBjYTYxMDciLCA4LCB9LAogCXsgInRjYTY0MDgiLCA4LCB9
LAotLSAKMS41LjQuMwoK
--0016e648bcbede310a0478b59cb8--
