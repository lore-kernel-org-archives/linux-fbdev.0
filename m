From: Jun Nie <niej0001@gmail.com>
Date: Thu, 12 Nov 2009 02:18:46 +0000
Subject: Re: [PATCH 6/8] pxa: add gpio expander on pxa168 aspenite platform
Message-Id: <7c34ac520911111818l645cc210m8252214130570eb@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0016e64cd536c0cbcb0478232963"
List-Id: <linux-fbdev.vger.kernel.org>
References: <7c34ac520911100012s176bff7bk7d57e86cd660632f@mail.gmail.com>
In-Reply-To: <7c34ac520911100012s176bff7bk7d57e86cd660632f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org

--0016e64cd536c0cbcb0478232963
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2009/11/10 Jun Nie <niej0001@gmail.com>:
> From 0815be7cf3458a14da1462b40247dc7a3231142a Mon Sep 17 00:00:00 2001
> From: Jun Nie <njun@marvell.com>
> Date: Tue, 3 Nov 2009 14:08:50 +0800
> Subject: [PATCH] pxa: add gpio expander on pxa168 aspenite platform
>
> Signed-off-by: Jun Nie <njun@marvell.com>
> ---
> =A0arch/arm/mach-mmp/aspenite.c | =A0 45 ++++++++++++++++++++++++++++++++=
++++++++++
> =A0drivers/gpio/pca953x.c =A0 =A0 =A0 | =A0 =A01 +
> =A02 files changed, 46 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
> index 115f728..b422bb5 100644
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
> @@ -142,6 +186,7 @@ static void __init common_init(void)
> =A0 =A0 =A0 =A0pxa168_add_uart(1);
>
> =A0 =A0 =A0 =A0apn_init_nand();
> + =A0 =A0 =A0 pxa168_add_twsi(0, &pwri2c_info, ARRAY_AND_SIZE(aspenite_i2=
c_board_info));
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
patch attached.

--0016e64cd536c0cbcb0478232963
Content-Type: text/x-diff; charset=US-ASCII; 
	name="0006-pxa-add-gpio-expander-on-pxa168-aspenite-platform.patch"
Content-Disposition: attachment; 
	filename="0006-pxa-add-gpio-expander-on-pxa168-aspenite-platform.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g1ww3zi00

RnJvbSAwODE1YmU3Y2YzNDU4YTE0ZGExNDYyYjQwMjQ3ZGM3YTMyMzExNDJhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKdW4gTmllIDxuanVuQG1hcnZlbGwuY29tPgpEYXRlOiBUdWUs
IDMgTm92IDIwMDkgMTQ6MDg6NTAgKzA4MDAKU3ViamVjdDogW1BBVENIXSBweGE6IGFkZCBncGlv
IGV4cGFuZGVyIG9uIHB4YTE2OCBhc3Blbml0ZSBwbGF0Zm9ybQoKU2lnbmVkLW9mZi1ieTogSnVu
IE5pZSA8bmp1bkBtYXJ2ZWxsLmNvbT4KLS0tCiBhcmNoL2FybS9tYWNoLW1tcC9hc3Blbml0ZS5j
IHwgICA0NSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIGRyaXZl
cnMvZ3Bpby9wY2E5NTN4LmMgICAgICAgfCAgICAxICsKIDIgZmlsZXMgY2hhbmdlZCwgNDYgaW5z
ZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW1t
cC9hc3Blbml0ZS5jIGIvYXJjaC9hcm0vbWFjaC1tbXAvYXNwZW5pdGUuYwppbmRleCAxMTVmNzI4
Li5iNDIyYmI1IDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW1tcC9hc3Blbml0ZS5jCisrKyBi
L2FyY2gvYXJtL21hY2gtbW1wL2FzcGVuaXRlLmMKQEAgLTE2LDYgKzE2LDcgQEAKICNpbmNsdWRl
IDxsaW51eC9tdGQvbXRkLmg+CiAjaW5jbHVkZSA8bGludXgvbXRkL3BhcnRpdGlvbnMuaD4KICNp
bmNsdWRlIDxsaW51eC9tdGQvbmFuZC5oPgorI2luY2x1ZGUgPGxpbnV4L2kyYy9wY2E5NTN4Lmg+
CiAKICNpbmNsdWRlIDxhc20vbWFjaC10eXBlcy5oPgogI2luY2x1ZGUgPGFzbS9tYWNoL2FyY2gu
aD4KQEAgLTI0LDkgKzI1LDE0IEBACiAjaW5jbHVkZSA8bWFjaC9weGExNjguaD4KICNpbmNsdWRl
IDxtYWNoL2dwaW8uaD4KICNpbmNsdWRlIDxwbGF0L3B4YTN4eF9uYW5kLmg+CisjaW5jbHVkZSA8
dmlkZW8vcHhhMTY4ZmIuaD4KIAogI2luY2x1ZGUgImNvbW1vbi5oIgogCisvKnVzZWQgYnkgZXhw
YW5kZXIgbWF4NzMxMiwgMTYgcGlucyBncGlvIGV4cGFuZGVyICovCisjZGVmaW5lIEdQSU9fRVhU
MCh4KQkJKE5SX0JVSUxUSU5fR1BJTyArICh4KSkKKyNkZWZpbmUgR1BJT19FWFQxKHgpCQkoTlJf
QlVJTFRJTl9HUElPICsgMTYgKyAoeCkpCisKIHN0YXRpYyB1bnNpZ25lZCBsb25nIGNvbW1vbl9w
aW5fY29uZmlnW10gX19pbml0ZGF0YSA9IHsKIAkvKiBEYXRhIEZsYXNoIEludGVyZmFjZSAqLwog
CUdQSU8wX0RGSV9EMTUsCkBAIC0xMzQsNiArMTQwLDQ0IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBh
cG5faW5pdF9uYW5kKHZvaWQpCiBzdGF0aWMgdm9pZCBfX2luaXQgYXBuX2luaXRfbmFuZCh2b2lk
KSB7fQogI2VuZGlmCiAKK3N0YXRpYyBzdHJ1Y3QgaTJjX3B4YV9wbGF0Zm9ybV9kYXRhIHB3cmky
Y19pbmZvIF9faW5pdGRhdGEgPSB7CisJLnVzZV9waW8JCT0gMSwKK307CisKKyNpZiBkZWZpbmVk
KENPTkZJR19HUElPX1BDQTk1M1gpCisvKiBHUElPIGV4cGFuZGVyIG1heDczMTIgY291bGQgcmV1
c2UgUENBOTUzWCAqLworc3RhdGljIHN0cnVjdCBwY2E5NTN4X3BsYXRmb3JtX2RhdGEgbWF4NzMx
Ml9kYXRhW10gPSB7CisJLyogdHdvIG1heDczMTIgaW4gc3lzdGVtICovCisKKwlbMF0gPSB7CisJ
CS5ncGlvX2Jhc2UgICAgICA9IEdQSU9fRVhUMCgwKSwKKwl9LAorCisJWzFdID0geworCQkuZ3Bp
b19iYXNlICAgICAgPSBHUElPX0VYVDEoMCksCisJfSwKK307CisjZW5kaWYKKworc3RhdGljIHN0
cnVjdCBpMmNfYm9hcmRfaW5mbyBhc3Blbml0ZV9pMmNfYm9hcmRfaW5mb1tdID0geworCisjaWYg
ZGVmaW5lZChDT05GSUdfR1BJT19QQ0E5NTNYKQorCXsKKwkJLnR5cGUgICAgICAgICAgID0gIm1h
eDczMTIiLAorCQkuYWRkciAgICAgICAgICAgPSAweDEwLCAgICAgICAgICAgICAgICAgLyogMHgy
MC8weDIxICovCisJCS5pcnEgICAgICAgICAgICA9IElSUV9HUElPKDEyMiksCisJCS5wbGF0Zm9y
bV9kYXRhICA9ICZtYXg3MzEyX2RhdGFbMF0sCisJfSwKKworCXsKKwkJLnR5cGUgICAgICAgICAg
ID0gIm1heDczMTIiLAorCQkuYWRkciAgICAgICAgICAgPSAweDIwLCAgICAgICAgICAgICAgICAg
LyogMHg0MC8weDQxICovCisJCS5pcnEgICAgICAgICAgICA9IElSUV9HUElPKDEyMCksCisJCS5w
bGF0Zm9ybV9kYXRhICA9ICZtYXg3MzEyX2RhdGFbMV0sCisJfSwKKyNlbmRpZgorfTsKKwogc3Rh
dGljIHZvaWQgX19pbml0IGNvbW1vbl9pbml0KHZvaWQpCiB7CiAJbWZwX2NvbmZpZyhBUlJBWV9B
TkRfU0laRShjb21tb25fcGluX2NvbmZpZykpOwpAQCAtMTQyLDYgKzE4Niw3IEBAIHN0YXRpYyB2
b2lkIF9faW5pdCBjb21tb25faW5pdCh2b2lkKQogCXB4YTE2OF9hZGRfdWFydCgxKTsKIAogCWFw
bl9pbml0X25hbmQoKTsKKwlweGExNjhfYWRkX3R3c2koMCwgJnB3cmkyY19pbmZvLCBBUlJBWV9B
TkRfU0laRShhc3Blbml0ZV9pMmNfYm9hcmRfaW5mbykpOwogCiAJLyogb2ZmLWNoaXAgZGV2aWNl
cyAqLwogCXBsYXRmb3JtX2RldmljZV9yZWdpc3Rlcigmc21jOTF4X2RldmljZSk7CmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwaW8vcGNhOTUzeC5jIGIvZHJpdmVycy9ncGlvL3BjYTk1M3guYwppbmRl
eCA2YTJmYjNmLi43ODIyNjg0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwaW8vcGNhOTUzeC5jCisr
KyBiL2RyaXZlcnMvZ3Bpby9wY2E5NTN4LmMKQEAgLTM5LDYgKzM5LDcgQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCBpMmNfZGV2aWNlX2lkIHBjYTk1M3hfaWRbXSA9IHsKIAl7ICJwY2E5NTU3IiwgOCwg
fSwKIAogCXsgIm1heDczMTAiLCA4LCB9LAorCXsgIm1heDczMTIiLCAxNiwgfSwKIAl7ICJtYXg3
MzE1IiwgOCwgfSwKIAl7ICJwY2E2MTA3IiwgOCwgfSwKIAl7ICJ0Y2E2NDA4IiwgOCwgfSwKLS0g
CjEuNS40LjMKCg==
--0016e64cd536c0cbcb0478232963--
