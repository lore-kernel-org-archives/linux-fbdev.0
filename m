From: Jun Nie <niej0001@gmail.com>
Date: Thu, 12 Nov 2009 02:18:17 +0000
Subject: Re: [PATCH 5/8] pxa: frame buffer support both pxa168 and pxa910
Message-Id: <7c34ac520911111818y3eb7773dr28cf9c23f4f545f4@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0016e64ca4d80146be04782328f6"
List-Id: <linux-fbdev.vger.kernel.org>
References: <7c34ac520911100012l43680a5fn1ffa2f44d8c27801@mail.gmail.com>
In-Reply-To: <7c34ac520911100012l43680a5fn1ffa2f44d8c27801@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org

--0016e64ca4d80146be04782328f6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2009/11/10 Jun Nie <niej0001@gmail.com>:
> From ce9b930b389f6b2ecbdf0102a6055f737c56979a Mon Sep 17 00:00:00 2001
> From: Jun Nie <njun@marvell.com>
> Date: Tue, 10 Nov 2009 09:43:57 +0800
> Subject: [PATCH] pxa: frame buffer support both pxa168 and pxa910
>
> Signed-off-by: Jun Nie <njun@marvell.com>
> ---
> =A0drivers/video/pxa168fb.c | =A0 =A06 ++++++
> =A0include/video/pxa168fb.h | =A0 =A03 +++
> =A02 files changed, 9 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
> index 55c69a1..ca0a4d3 100644
> --- a/drivers/video/pxa168fb.c
> +++ b/drivers/video/pxa168fb.c
> @@ -879,12 +879,18 @@ failed:
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> + static const struct platform_device_id mmpfb_id_table[] =3D {
> + =A0 =A0 =A0 =A0{"pxa168-fb", PXA168_FB},
> + =A0 =A0 =A0 =A0{"pxa910-fb", PXA910_FB},
> + };
> +
> =A0static struct platform_driver pxa168fb_driver =3D {
> =A0 =A0 =A0 =A0.driver =A0 =A0 =A0 =A0 =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "pxa168-fb",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =A0=3D THIS_MODULE,
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0.probe =A0 =A0 =A0 =A0 =A0=3D pxa168fb_probe,
> + =A0 =A0 =A0 .id_table =A0 =A0 =A0 =3D mmpfb_id_table,
> =A0};
>
> =A0static int __devinit pxa168fb_init(void)
> diff --git a/include/video/pxa168fb.h b/include/video/pxa168fb.h
> index efbe469..41f21c5 100644
> --- a/include/video/pxa168fb.h
> +++ b/include/video/pxa168fb.h
> @@ -86,6 +86,9 @@
> =A0#define PIX_FMT_PSEUDOCOLOR =A0 =A020
> =A0#define PIX_FMT_UYVY422PACK =A0 =A0(0x1000|PIX_FMT_YUV422PACK)
>
> +#define PXA168_FB 0x0168
> +#define PXA910_FB 0x0910
> +
> =A0/*
> =A0* PXA LCD controller private state.
> =A0*/
> --
> 1.5.4.3
>
patch attached.

--0016e64ca4d80146be04782328f6
Content-Type: text/x-diff; charset=US-ASCII; 
	name="0005-pxa-frame-buffer-support-both-pxa168-and-pxa910.patch"
Content-Disposition: attachment; 
	filename="0005-pxa-frame-buffer-support-both-pxa168-and-pxa910.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g1ww3bga0

RnJvbSBjZTliOTMwYjM4OWY2YjJlY2JkZjAxMDJhNjA1NWY3MzdjNTY5NzlhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKdW4gTmllIDxuanVuQG1hcnZlbGwuY29tPgpEYXRlOiBUdWUs
IDEwIE5vdiAyMDA5IDA5OjQzOjU3ICswODAwClN1YmplY3Q6IFtQQVRDSF0gcHhhOiBmcmFtZSBi
dWZmZXIgc3VwcG9ydCBib3RoIHB4YTE2OCBhbmQgcHhhOTEwCgpTaWduZWQtb2ZmLWJ5OiBKdW4g
TmllIDxuanVuQG1hcnZlbGwuY29tPgotLS0KIGRyaXZlcnMvdmlkZW8vcHhhMTY4ZmIuYyB8ICAg
IDYgKysrKysrCiBpbmNsdWRlL3ZpZGVvL3B4YTE2OGZiLmggfCAgICAzICsrKwogMiBmaWxlcyBj
aGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy92aWRlby9weGExNjhmYi5jIGIvZHJpdmVycy92aWRlby9weGExNjhmYi5jCmluZGV4IDU1
YzY5YTEuLmNhMGE0ZDMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmlkZW8vcHhhMTY4ZmIuYworKysg
Yi9kcml2ZXJzL3ZpZGVvL3B4YTE2OGZiLmMKQEAgLTg3OSwxMiArODc5LDE4IEBAIGZhaWxlZDoK
IAlyZXR1cm4gcmV0OwogfQogCisgc3RhdGljIGNvbnN0IHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Vf
aWQgbW1wZmJfaWRfdGFibGVbXSA9IHsKKwkgeyJweGExNjgtZmIiLCBQWEExNjhfRkJ9LAorCSB7
InB4YTkxMC1mYiIsIFBYQTkxMF9GQn0sCisgfTsKKwogc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9k
cml2ZXIgcHhhMTY4ZmJfZHJpdmVyID0gewogCS5kcml2ZXIJCT0gewogCQkubmFtZQk9ICJweGEx
NjgtZmIiLAogCQkub3duZXIJPSBUSElTX01PRFVMRSwKIAl9LAogCS5wcm9iZQkJPSBweGExNjhm
Yl9wcm9iZSwKKwkuaWRfdGFibGUJPSBtbXBmYl9pZF90YWJsZSwKIH07CiAKIHN0YXRpYyBpbnQg
X19kZXZpbml0IHB4YTE2OGZiX2luaXQodm9pZCkKZGlmZiAtLWdpdCBhL2luY2x1ZGUvdmlkZW8v
cHhhMTY4ZmIuaCBiL2luY2x1ZGUvdmlkZW8vcHhhMTY4ZmIuaAppbmRleCBlZmJlNDY5Li40MWYy
MWM1IDEwMDY0NAotLS0gYS9pbmNsdWRlL3ZpZGVvL3B4YTE2OGZiLmgKKysrIGIvaW5jbHVkZS92
aWRlby9weGExNjhmYi5oCkBAIC04Niw2ICs4Niw5IEBACiAjZGVmaW5lIFBJWF9GTVRfUFNFVURP
Q09MT1IJMjAKICNkZWZpbmUgUElYX0ZNVF9VWVZZNDIyUEFDSwkoMHgxMDAwfFBJWF9GTVRfWVVW
NDIyUEFDSykKIAorI2RlZmluZSBQWEExNjhfRkIgMHgwMTY4CisjZGVmaW5lIFBYQTkxMF9GQiAw
eDA5MTAKKwogLyoKICAqIFBYQSBMQ0QgY29udHJvbGxlciBwcml2YXRlIHN0YXRlLgogICovCi0t
IAoxLjUuNC4zCgo=
--0016e64ca4d80146be04782328f6--
