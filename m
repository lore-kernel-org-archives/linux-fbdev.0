From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 27 Jan 2020 07:36:07 +0000
Subject: Re: [PATCH] matroxfb: add Matrox MGA-G200eW board support
Message-Id: <1466259e-efe7-df52-c05b-80042628d577@suse.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="JXtJqsfGpCLX37g1U82XR0axYY5SX2ng4"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200125195506.GA16638@brightrain.aerifal.cx>
In-Reply-To: <20200125195506.GA16638@brightrain.aerifal.cx>
To: Rich Felker <dalias@libc.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, dri-devel@lists.freedesktop.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JXtJqsfGpCLX37g1U82XR0axYY5SX2ng4
Content-Type: multipart/mixed; boundary="kXJKU2muNsUH08rB4dLf3tn0abYMGCebb";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Rich Felker <dalias@libc.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>
Message-ID: <1466259e-efe7-df52-c05b-80042628d577@suse.de>
Subject: Re: [PATCH] matroxfb: add Matrox MGA-G200eW board support
References: <20200125195506.GA16638@brightrain.aerifal.cx>
In-Reply-To: <20200125195506.GA16638@brightrain.aerifal.cx>

--kXJKU2muNsUH08rB4dLf3tn0abYMGCebb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 25.01.20 um 20:55 schrieb Rich Felker:
> Signed-off-by: Rich Felker <dalias@libc.org>
> --
> I've had this lying around a while and figure I should send it
> upsteam; it's needed to support the onboard video on my Spectre-free
> Atom S1260 server board.

This HW is supported by mgag200, which is maintained. Can't you use that?=


Best regards
Thomas

>=20
> ---
>  drivers/video/fbdev/matrox/matroxfb_base.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/drivers/video/fbdev/matrox/matroxfb_base.c b/drivers/video=
/fbdev/matrox/matroxfb_base.c
> index 1a555f70923a..ff344313860c 100644
> --- a/drivers/video/fbdev/matrox/matroxfb_base.c
> +++ b/drivers/video/fbdev/matrox/matroxfb_base.c
> @@ -1376,6 +1376,12 @@ static struct video_board vbG200 =3D {
>  	.accelID =3D FB_ACCEL_MATROX_MGAG200,
>  	.lowlevel =3D &matrox_G100
>  };
> +static struct video_board vbG200eW =3D {
> +	.maxvram =3D 0x800000,
> +	.maxdisplayable =3D 0x800000,
> +	.accelID =3D FB_ACCEL_MATROX_MGAG200,
> +	.lowlevel =3D &matrox_G100
> +};
>  /* from doc it looks like that accelerator can draw only to low 16MB :=
-( Direct accesses & displaying are OK for
>     whole 32MB */
>  static struct video_board vbG400 =3D {
> @@ -1494,6 +1500,13 @@ static struct board {
>  		MGA_G200,
>  		&vbG200,
>  		"MGA-G200 (PCI)"},
> +	{PCI_VENDOR_ID_MATROX,	0x0532,	0xFF,
> +		0,			0,
> +		DEVF_G200,
> +		250000,
> +		MGA_G200,
> +		&vbG200eW,
> +		"MGA-G200eW (PCI)"},
>  	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_G200_AGP,	0xFF,
>  		PCI_SS_VENDOR_ID_MATROX,	PCI_SS_ID_MATROX_GENERIC,
>  		DEVF_G200,
> @@ -2136,6 +2149,8 @@ static const struct pci_device_id matroxfb_device=
s[] =3D {
>  		PCI_ANY_ID,	PCI_ANY_ID,	0, 0, 0},
>  	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_G200_PCI,
>  		PCI_ANY_ID,	PCI_ANY_ID,	0, 0, 0},
> +	{PCI_VENDOR_ID_MATROX,	0x0532,
> +		PCI_ANY_ID,	PCI_ANY_ID,	0, 0, 0},
>  	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_G200_AGP,
>  		PCI_ANY_ID,	PCI_ANY_ID,	0, 0, 0},
>  	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_G400,
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--kXJKU2muNsUH08rB4dLf3tn0abYMGCebb--

--JXtJqsfGpCLX37g1U82XR0axYY5SX2ng4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl4ukusACgkQaA3BHVML
eiND4AgAtd2QdgBKcSGDT6qgNFNiQlF3Zuo2G4F6F8TFMSOfEPGr9AFjyBwtwcHV
7FM9xf28m1W2QYYZNnjF6Rulqj+ixi55KWKSmIrRmaphsbN/Pyd3Qo+2OcX0yiHq
tgVshfKjM/BP9uJepxE57BIFdaLNxX+A8ImO4ggvJxG/W7GTmyl4l+VOpcXVSAwM
KsVbgLOcMFpMlFBtnDOAQLVjdMoWeBUgaazV7YLa9ilQhD3QYcj+GRCzBRhih0In
XrKWoV+brXQqTQb8kO2wH2V+y+4NhX0hc3/vGte3avpA4YtVMq890xb2KkHJJfa6
G2YJMDlPER9x7SHUFUTCgfC0pULVEw==
=GbzM
-----END PGP SIGNATURE-----

--JXtJqsfGpCLX37g1U82XR0axYY5SX2ng4--
