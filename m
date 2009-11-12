From: Jun Nie <niej0001@gmail.com>
Date: Thu, 12 Nov 2009 02:17:21 +0000
Subject: Re: [PATCH 3/8] pxa: fix offset setting at initialization
Message-Id: <7c34ac520911111817v22ff06dboc7d5f3c2e3da3126@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0016e64b9332ae04dd04782324f0"
List-Id: <linux-fbdev.vger.kernel.org>
References: <7c34ac520911100012w3b441c50w9dffaa1100bcd5b7@mail.gmail.com>
In-Reply-To: <7c34ac520911100012w3b441c50w9dffaa1100bcd5b7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org

--0016e64b9332ae04dd04782324f0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2009/11/10 Jun Nie <niej0001@gmail.com>:
> From c4f8923a0d532a1f1b5defed639ef818a0d7a270 Mon Sep 17 00:00:00 2001
> From: Jun Nie <njun@marvell.com>
> Date: Tue, 10 Nov 2009 09:33:49 +0800
> Subject: [PATCH] pxa: fix offset setting at initialization
>
> Signed-off-by: Jun Nie <njun@marvell.com>
> ---
> =A0drivers/video/pxa168fb.c | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
> index 50f72e9..55c69a1 100644
> --- a/drivers/video/pxa168fb.c
> +++ b/drivers/video/pxa168fb.c
> @@ -765,6 +765,7 @@ static int __init pxa168fb_probe(struct
> platform_device *pdev)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0info->fix.smem_start =3D (unsigned long)fbi->fb_start_dma;
> + =A0 =A0 =A0 set_graphics_start(info, 0, 0);
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Set video mode according to platform data.
> --
> 1.5.4.3
>
patch attached.

--0016e64b9332ae04dd04782324f0
Content-Type: text/x-diff; charset=US-ASCII; 
	name="0003-pxa-fix-offset-setting-at-initialization.patch"
Content-Disposition: attachment; 
	filename="0003-pxa-fix-offset-setting-at-initialization.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g1ww27dt0

RnJvbSBjNGY4OTIzYTBkNTMyYTFmMWI1ZGVmZWQ2MzllZjgxOGEwZDdhMjcwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKdW4gTmllIDxuanVuQG1hcnZlbGwuY29tPgpEYXRlOiBUdWUs
IDEwIE5vdiAyMDA5IDA5OjMzOjQ5ICswODAwClN1YmplY3Q6IFtQQVRDSF0gcHhhOiBmaXggb2Zm
c2V0IHNldHRpbmcgYXQgaW5pdGlhbGl6YXRpb24KClNpZ25lZC1vZmYtYnk6IEp1biBOaWUgPG5q
dW5AbWFydmVsbC5jb20+Ci0tLQogZHJpdmVycy92aWRlby9weGExNjhmYi5jIHwgICAgMSArCiAx
IGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL3ZpZGVvL3B4YTE2OGZiLmMgYi9kcml2ZXJzL3ZpZGVvL3B4YTE2OGZiLmMK
aW5kZXggNTBmNzJlOS4uNTVjNjlhMSAxMDA2NDQKLS0tIGEvZHJpdmVycy92aWRlby9weGExNjhm
Yi5jCisrKyBiL2RyaXZlcnMvdmlkZW8vcHhhMTY4ZmIuYwpAQCAtNzY1LDYgKzc2NSw3IEBAIHN0
YXRpYyBpbnQgX19pbml0IHB4YTE2OGZiX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpCiAJfQogCiAJaW5mby0+Zml4LnNtZW1fc3RhcnQgPSAodW5zaWduZWQgbG9uZylmYmktPmZi
X3N0YXJ0X2RtYTsKKwlzZXRfZ3JhcGhpY3Nfc3RhcnQoaW5mbywgMCwgMCk7CiAKIAkvKgogCSAq
IFNldCB2aWRlbyBtb2RlIGFjY29yZGluZyB0byBwbGF0Zm9ybSBkYXRhLgotLSAKMS41LjQuMwoK
--0016e64b9332ae04dd04782324f0--
