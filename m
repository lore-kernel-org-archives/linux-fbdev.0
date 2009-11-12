From: Jun Nie <niej0001@gmail.com>
Date: Thu, 12 Nov 2009 02:16:49 +0000
Subject: Re: [PATCH 2/8] pxa: support PXA168 LCD platform dependent power on
Message-Id: <7c34ac520911111816h27f071bcu7e158494f24882f9@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0016e648d6dccc8937047823229b"
List-Id: <linux-fbdev.vger.kernel.org>
References: <7c34ac520911100012y4b52659eid46c241111c34032@mail.gmail.com>
In-Reply-To: <7c34ac520911100012y4b52659eid46c241111c34032@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org

--0016e648d6dccc8937047823229b
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2009/11/10 Jun Nie <niej0001@gmail.com>:
> From 7a497795dfd6f314e52b015b85031a0498a70a03 Mon Sep 17 00:00:00 2001
> From: Jun Nie <njun@marvell.com>
> Date: Tue, 10 Nov 2009 09:21:19 +0800
> Subject: [PATCH] pxa: support PXA168 LCD platform dependent power on
>
> Signed-off-by: Jun Nie <njun@marvell.com>
> ---
> =A0drivers/video/pxa168fb.c | =A0 14 ++++++++++++++
> =A01 files changed, 14 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
> index e1f1c5f..50f72e9 100644
> --- a/drivers/video/pxa168fb.c
> +++ b/drivers/video/pxa168fb.c
> @@ -845,6 +845,20 @@ static int __init pxa168fb_probe(struct
> platform_device *pdev)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0platform_set_drvdata(pdev, fbi);
> + =A0 =A0 =A0 if (mi->pxa168fb_lcd_power){
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_is_valid(mi->spi_gpio_cs)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D gpio_request(mi->sp=
i_gpio_cs, "LCD_SPI_CS");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pd=
ev->dev, "failed to request GPIO for LCD CS\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if(mi->pxa168fb_lcd_power(fbi, mi->spi_gpio=
_cs, mi->spi_gpio_reset, 1)){
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Failed=
 to power up pxa168-fb\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto failed_free_irq;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 dev_info(fbi->dev, "frame buffer detected\n");
> =A0 =A0 =A0 =A0return 0;
>
> =A0failed_free_irq:
> --
> 1.5.4.3
>
patch attached.

--0016e648d6dccc8937047823229b
Content-Type: text/x-diff; charset=US-ASCII; 
	name="0002-pxa-support-PXA168-LCD-platform-dependent-power-on.patch"
Content-Disposition: attachment; 
	filename="0002-pxa-support-PXA168-LCD-platform-dependent-power-on.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g1ww1jnb0

RnJvbSA3YTQ5Nzc5NWRmZDZmMzE0ZTUyYjAxNWI4NTAzMWEwNDk4YTcwYTAzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKdW4gTmllIDxuanVuQG1hcnZlbGwuY29tPgpEYXRlOiBUdWUs
IDEwIE5vdiAyMDA5IDA5OjIxOjE5ICswODAwClN1YmplY3Q6IFtQQVRDSF0gcHhhOiBzdXBwb3J0
IFBYQTE2OCBMQ0QgcGxhdGZvcm0gZGVwZW5kZW50IHBvd2VyIG9uCgpTaWduZWQtb2ZmLWJ5OiBK
dW4gTmllIDxuanVuQG1hcnZlbGwuY29tPgotLS0KIGRyaXZlcnMvdmlkZW8vcHhhMTY4ZmIuYyB8
ICAgMTQgKysrKysrKysrKysrKysKIDEgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwg
MCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpZGVvL3B4YTE2OGZiLmMgYi9k
cml2ZXJzL3ZpZGVvL3B4YTE2OGZiLmMKaW5kZXggZTFmMWM1Zi4uNTBmNzJlOSAxMDA2NDQKLS0t
IGEvZHJpdmVycy92aWRlby9weGExNjhmYi5jCisrKyBiL2RyaXZlcnMvdmlkZW8vcHhhMTY4ZmIu
YwpAQCAtODQ1LDYgKzg0NSwyMCBAQCBzdGF0aWMgaW50IF9faW5pdCBweGExNjhmYl9wcm9iZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCX0KIAogCXBsYXRmb3JtX3NldF9kcnZkYXRh
KHBkZXYsIGZiaSk7CisJaWYgKG1pLT5weGExNjhmYl9sY2RfcG93ZXIpeworCQlpZiAoZ3Bpb19p
c192YWxpZChtaS0+c3BpX2dwaW9fY3MpKSB7CisJCQlyZXQgPSBncGlvX3JlcXVlc3QobWktPnNw
aV9ncGlvX2NzLCAiTENEX1NQSV9DUyIpOworCQkJaWYgKHJldCkgeworCQkJCWRldl9lcnIoJnBk
ZXYtPmRldiwgImZhaWxlZCB0byByZXF1ZXN0IEdQSU8gZm9yIExDRCBDU1xuIik7CisJCQkJcmV0
dXJuIC1FSU87CisJCQl9CisJCX0KKwkJaWYobWktPnB4YTE2OGZiX2xjZF9wb3dlcihmYmksIG1p
LT5zcGlfZ3Bpb19jcywgbWktPnNwaV9ncGlvX3Jlc2V0LCAxKSl7CisJCQlkZXZfZXJyKCZwZGV2
LT5kZXYsICJGYWlsZWQgdG8gcG93ZXIgdXAgcHhhMTY4LWZiXG4iKTsKKwkJCWdvdG8gZmFpbGVk
X2ZyZWVfaXJxOworCQl9CisJfQorCWRldl9pbmZvKGZiaS0+ZGV2LCAiZnJhbWUgYnVmZmVyIGRl
dGVjdGVkXG4iKTsKIAlyZXR1cm4gMDsKIAogZmFpbGVkX2ZyZWVfaXJxOgotLSAKMS41LjQuMwoK
--0016e648d6dccc8937047823229b--
