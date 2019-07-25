From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Date: Thu, 25 Jul 2019 07:23:32 +0000
Subject: Re: [PATCH v2] Staging: fbtft: Fix GPIO handling
Message-Id: <25a729cd1aa40fe5fc53760be48721d3f56b67e6.camel@suse.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-dJ2ncZl/Tq5SUWotdfEp"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190715143003.12819-1-nsaenzjulienne@suse.de>
 <7b8242ab-cc0c-d90b-60af-ff1c53789e44@opensynergy.com>
 <5a77c18f-7338-888f-2379-12171b6a545e@jaseg.net>
 <75ada52f-afa1-08bc-d0ce-966fc1110e70@jaseg.net>
 <20190725072132.GA18714@kroah.com>
In-Reply-To: <20190725072132.GA18714@kroah.com>
To: Greg KH <gregkh@linuxfoundation.org>, Jan Sebastian =?ISO-8859-1?Q?G=F6tte?= <linux@jaseg.net>
Cc: devel@driverdev.osuosl.org, leobras.c@gmail.com, linux-fbdev@vger.kernel.org, nishadkamdar@gmail.com, dri-devel@lists.freedesktop.org, bhanusreemahesh@gmail.com, Phil Reid <preid@electromag.com.au>


--=-dJ2ncZl/Tq5SUWotdfEp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-07-25 at 09:21 +0200, Greg KH wrote:
> On Wed, Jul 17, 2019 at 11:41:37PM +0900, Jan Sebastian G=C3=B6tte wrote:
> > Commit c440eee1a7a1 ("Staging: fbtft: Switch to the gpio descriptor
> > interface") breaks GPIO handling. In several places, checks to only set
> > a GPIO if it was configured ended up backwards.
> > I have tested this fix. The fixed driver works with a ili9486
> > display connected to a raspberry pi via SPI.
> >=20
> > Fixes: commit c440eee1a7a1d ("Staging: fbtft: Switch to the gpio descri=
ptor
> > interface")
> > Tested-by: Jan Sebastian G=C3=B6tte <linux@jaseg.net>
> > Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > Signed-off-by: Jan Sebastian G=C3=B6tte <linux@jaseg.net>
> > ---
>=20
> Can this go on top of Phil's patches?  Or does it replace it?

This is needed on top of Phil patches.

Regards,
Nicolas


--=-dJ2ncZl/Tq5SUWotdfEp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl05WPUACgkQlfZmHno8
x/5gTAf/fIsoLKSE7JnAbBPihq8kbe1iDC8qQWHchEqQDL+A1r6QA0n+ujgSQfRY
Le/xoufXOHO29UeoJ4AUh05o8kaL7lDc8ip88dtd+4Kgl4p9LyQ1AbuKYi/ifGeW
u/AEbQhgsRu9gQMeUo1qjZQqzgbnNqSeRoimKNwelFruH0uIKwcgECcjiR6FHtvq
W7XoMzZ44YLGnS67QcbO0xtEqgWRetpXc2Li8xoWi1JT/vqYwT/My9udmNb1vvBE
SvfyGCry9zYS/7NL638P0qfTLm7WznpqHn41UV3Ptq7RaD6Idcm+Ai6OyczdviaF
wNVcIaFhx73LXuCdrESnpqF6CdhaHA==
=OcqC
-----END PGP SIGNATURE-----

--=-dJ2ncZl/Tq5SUWotdfEp--
