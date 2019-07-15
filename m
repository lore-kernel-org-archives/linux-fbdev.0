From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Date: Mon, 15 Jul 2019 15:14:27 +0000
Subject: Re: [PATCH] Staging: fbtft: Fix GPIO handling
Message-Id: <ba7c763b5c2a2d5edc4c0f700dabe08c47970600.camel@suse.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-QmBqWije45AXLJOH4tKP"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190715143003.12819-1-nsaenzjulienne@suse.de>
 <7b8242ab-cc0c-d90b-60af-ff1c53789e44@opensynergy.com>
 <5a77c18f-7338-888f-2379-12171b6a545e@jaseg.net>
 <294c94d2-d2c1-514d-ba6d-c62e98017bc0@jaseg.net>
In-Reply-To: <294c94d2-d2c1-514d-ba6d-c62e98017bc0@jaseg.net>
To: Jan Sebastian =?ISO-8859-1?Q?G=F6tte?= <linux@jaseg.net>
Cc: devel@driverdev.osuosl.org, leobras.c@gmail.com, linux-fbdev@vger.kernel.org, nishadkamdar@gmail.com, gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org, bhanusreemahesh@gmail.com, Phil Reid <preid@electromag.com.au>


--=-QmBqWije45AXLJOH4tKP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-07-16 at 00:04 +0900, Jan Sebastian G=C3=B6tte wrote:
> Commit c440eee1a7a1 ("Staging: fbtft: Switch to the gpio descriptor
> interface") breaks GPIO handling. In several places, checks to only set
> a GPIO if it was configured ended up backwards.
> I have tested this fix. The fixed driver works with a ili9486
> display connected to a raspberry pi via SPI.
>=20
> Fixes: commit c440eee1a7a1d ("Staging: fbtft: Switch to the gpio descript=
or
> interface")
> Tested-by: Jan Sebastian G=C3=B6tte <linux@jaseg.net>
> Signed-off-by: Jan Sebastian G=C3=B6tte <linux@jaseg.net>

Thanks Jan, this version is indeed more complete.

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Regards,
Nicolas


--=-QmBqWije45AXLJOH4tKP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl0smFMACgkQlfZmHno8
x/7xwQf9FFwqX1/6VPgDb4yvg7MXgCePh5zi7ffVRp75KpkfnNhAaKVX2v80j1XF
363ZZxrH2l67NyEorRbbFcqVRQh5vrIPExE/yAOTtnD1JTiZ3BnaBsKMmRfNVFgq
dQN2uxi7hW0xeSRGOb3PrtgVLB58UvOcSfTRX9++C+fy9W+BBqacK3qB5Ib5IRAJ
iRDVyyz45WTo7D6DgDiU/A/7vZnCTrNvu8Mw8R4FWdUbrfEzu1HUR/bem1KTAzIe
NEeAE9oe60C4dz3xd4Hfa5R7L0DCivs/PlzBtOGLTXu59L4DT7X/RdD3yKzbnH4X
dgfIdTNtBQv4XOgazxOdnbgFIzfLlw==
=7p4W
-----END PGP SIGNATURE-----

--=-QmBqWije45AXLJOH4tKP--
