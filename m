From: Jun Nie <niej0001@gmail.com>
Date: Thu, 12 Nov 2009 02:17:47 +0000
Subject: Re: [PATCH 4/8] pxa: delete redundant vsync/hsync revert flag
Message-Id: <7c34ac520911111817v169c88e1oea50457264490447@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="00504502a1bc43924d047823260d"
List-Id: <linux-fbdev.vger.kernel.org>
References: <7c34ac520911100012x3dfa948bn3e5106fc4c7c04f9@mail.gmail.com>
In-Reply-To: <7c34ac520911100012x3dfa948bn3e5106fc4c7c04f9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org

--00504502a1bc43924d047823260d
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2009/11/10 Jun Nie <niej0001@gmail.com>:
> From f0ba46eda943db08e60bcfe536f876f09165a64c Mon Sep 17 00:00:00 2001
> From: Jun Nie <njun@marvell.com>
> Date: Tue, 10 Nov 2009 15:11:36 +0800
> Subject: [PATCH] pxa: delete redundant =A0vsync/hsync revert flag
> =A0 =A0 =A0var.sync can cover its function
>
> Signed-off-by: Jun Nie <njun@marvell.com>
> ---
> =A0include/video/pxa168fb.h | =A0 =A02 --
> =A01 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/include/video/pxa168fb.h b/include/video/pxa168fb.h
> index 024767c..efbe469 100644
> --- a/include/video/pxa168fb.h
> +++ b/include/video/pxa168fb.h
> @@ -142,8 +142,6 @@ struct pxa168fb_mach_info {
> =A0 =A0 =A0 =A0unsigned =A0 =A0 =A0 =A0invert_composite_blank:1;
> =A0 =A0 =A0 =A0unsigned =A0 =A0 =A0 =A0invert_pix_val_ena:1;
> =A0 =A0 =A0 =A0unsigned =A0 =A0 =A0 =A0invert_pixclock:1;
> - =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0invert_vsync:1;
> - =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0invert_hsync:1;
> =A0 =A0 =A0 =A0unsigned =A0 =A0 =A0 =A0panel_rbswap:1;
> =A0 =A0 =A0 =A0unsigned =A0 =A0 =A0 =A0active:1;
> =A0 =A0 =A0 =A0unsigned =A0 =A0 =A0 =A0enable_lcd:1;
> --
> 1.5.4.3
>
patch attached.

--00504502a1bc43924d047823260d
Content-Type: text/x-diff; charset=US-ASCII; 
	name="0004-pxa-delete-redundant-vsync-hsync-revert-flag.patch"
Content-Disposition: attachment; 
	filename="0004-pxa-delete-redundant-vsync-hsync-revert-flag.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g1ww2nl70

RnJvbSBmMGJhNDZlZGE5NDNkYjA4ZTYwYmNmZTUzNmY4NzZmMDkxNjVhNjRjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKdW4gTmllIDxuanVuQG1hcnZlbGwuY29tPgpEYXRlOiBUdWUs
IDEwIE5vdiAyMDA5IDE1OjExOjM2ICswODAwClN1YmplY3Q6IFtQQVRDSF0gcHhhOiBkZWxldGUg
cmVkdW5kYW50ICB2c3luYy9oc3luYyByZXZlcnQgZmxhZwogICAgICB2YXIuc3luYyBjYW4gY292
ZXIgaXRzIGZ1bmN0aW9uCgpTaWduZWQtb2ZmLWJ5OiBKdW4gTmllIDxuanVuQG1hcnZlbGwuY29t
PgotLS0KIGluY2x1ZGUvdmlkZW8vcHhhMTY4ZmIuaCB8ICAgIDIgLS0KIDEgZmlsZXMgY2hhbmdl
ZCwgMCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUv
dmlkZW8vcHhhMTY4ZmIuaCBiL2luY2x1ZGUvdmlkZW8vcHhhMTY4ZmIuaAppbmRleCAwMjQ3Njdj
Li5lZmJlNDY5IDEwMDY0NAotLS0gYS9pbmNsdWRlL3ZpZGVvL3B4YTE2OGZiLmgKKysrIGIvaW5j
bHVkZS92aWRlby9weGExNjhmYi5oCkBAIC0xNDIsOCArMTQyLDYgQEAgc3RydWN0IHB4YTE2OGZi
X21hY2hfaW5mbyB7CiAJdW5zaWduZWQJaW52ZXJ0X2NvbXBvc2l0ZV9ibGFuazoxOwogCXVuc2ln
bmVkCWludmVydF9waXhfdmFsX2VuYToxOwogCXVuc2lnbmVkCWludmVydF9waXhjbG9jazoxOwot
CXVuc2lnbmVkCWludmVydF92c3luYzoxOwotCXVuc2lnbmVkCWludmVydF9oc3luYzoxOwogCXVu
c2lnbmVkCXBhbmVsX3Jic3dhcDoxOwogCXVuc2lnbmVkCWFjdGl2ZToxOwogCXVuc2lnbmVkCWVu
YWJsZV9sY2Q6MTsKLS0gCjEuNS40LjMKCg==
--00504502a1bc43924d047823260d--
