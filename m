From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Sun, 01 Feb 2015 02:44:33 +0000
Subject: Re: [PATCH 05/15] fbdev: imsttfb: remove the dependency on PPC_OF
Message-Id: <20150201134433.729a2389@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sig_/AuC0a9gaWfBbfYfGjq41TyU"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
 <1422712065-9403-6-git-send-email-haokexin@gmail.com>
In-Reply-To: <1422712065-9403-6-git-send-email-haokexin@gmail.com>
To: Kevin Hao <haokexin@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linuxppc-dev@lists.ozlabs.org

--Sig_/AuC0a9gaWfBbfYfGjq41TyU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kevin,

On Sat, 31 Jan 2015 21:47:35 +0800 Kevin Hao <haokexin@gmail.com> wrote:
>
> The OF functionality has moved to a common place and be used by many
> archs. So we don't need to depend on PPC_OF option any more. This is
> a preparation for killing PPC_OF.

I suspect that you want to do the PPC_OF -> PPC conversion on this file
rather than just removing PPC_OF uses.

> diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
> index aae10ce74f14..91a80bb8f988 100644
> --- a/drivers/video/fbdev/imsttfb.c
> +++ b/drivers/video/fbdev/imsttfb.c
> @@ -1470,7 +1470,6 @@ static int imsttfb_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *ent)
>  	unsigned long addr, size;
>  	struct imstt_par *par;
>  	struct fb_info *info;
> -#ifdef CONFIG_PPC_OF
>  	struct device_node *dp;

I see no way in this file for struct device_node to be defined
(especially if CONFIG_PPC is not set).  of.h may be included
implicitly, but that is very dependent on the architecture and CONFIG_
options.

>  	dp =3D pci_device_to_OF_node(pdev);
> @@ -1478,7 +1477,6 @@ static int imsttfb_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *ent)
>  		printk(KERN_INFO "%s: OF name %s\n",__func__, dp->name);
>  	else
>  		printk(KERN_ERR "imsttfb: no OF node for pci device\n");
> -#endif /* CONFIG_PPC_OF */

This will emit the above error if CONFIG_OF is not set whereas in the
past it would not.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/AuC0a9gaWfBbfYfGjq41TyU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUzZMWAAoJEMDTa8Ir7ZwVxEcP/005yHkV0y6U9/sVv8UyGfKw
vbe3zU/VLbYMK0VMBEdpkizPxme6me++6l/DA/tHLw9+agZea6iu5tobe5W2TiP+
u7YxopuGln/vPIMTwLjkqlANlO13DBzsHrqydZHMS49lpEpD2wSzw8D+A9xZgvk+
LOWPMXnb546kriuL2uiG9rsVq3fTXhRAIY6vp5kMIvGNaacwHBmzoCBtosYMbnOG
+1PSTx4OzwU46lpgrqA+3R1brOT3Dgqq7fuMnvCkwPK5vgwGc75euVZRSePEG6OI
KzVOSsNGMRrlnRQRSslzfKOJKuwCwLeNK4yOQdimTes7skBQSfKn6yRniCT1rvgb
hv8Z8CanYzqL9hOAwa7CfUOn2c5HHOFfuyCuh03xWDYMvd6LEHOWij0kZrBYvZIb
k+nc4y0aSbSsdTV+lCA5P/Q/hN7XCetLRsTxu6VbPfMOj7oEvYLSK2s64cWBEqGG
pQgeCvJiEJYWDVYCl8JKU9Bm0qmm1a3YtaRslEbKJLO9iA0rNM5QAK/R22bDrViA
POK+Pck7JR0n0EGUoCg+Qh5jHt3BYuO5bHx37ieIIZFaGPg3ZWmH6WB2wDfJ27Wl
JLvxod3LAtnlIBFm3nWWLjt/2Sqr5fXANAMw/nY5wuFhyUnfYXCkqL+Cq6ajTYzV
r4TX7JHoB2FWf9o68dCv
=Xg8K
-----END PGP SIGNATURE-----

--Sig_/AuC0a9gaWfBbfYfGjq41TyU--
