From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 21 Aug 2012 09:54:20 +0000
Subject: Re: [PATCH v4 1/3] Runtime Interpreted Power Sequences
Message-Id: <1345542860.4085.40.camel@deskari>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-7E61pVNOK8ptK17BGKHa"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345097337-24170-1-git-send-email-acourbot@nvidia.com>
	 <1345097337-24170-2-git-send-email-acourbot@nvidia.com>
	 <1345535069.4085.7.camel@deskari> <1562509.b0FYTUZ1D8@percival>
	 <20120821083329.GA28992@avionic-0098.adnet.avionic-design.de>
	 <1345539465.4085.22.camel@deskari>
	 <20120821091306.GA4819@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20120821091306.GA4819-RM9K5IK7kjIQXX3q8xo1gnVAuStQJXxyR5q1nwbD4aMs9pC9oP6+/A@public.gmane.org>
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Anton Vorontsov <cbou-JGs/UdohzUI@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Leela Krishna Amudala <leelakrishna.a-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--=-7E61pVNOK8ptK17BGKHa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-08-21 at 11:13 +0200, Thierry Reding wrote:
> On Tue, Aug 21, 2012 at 11:57:45AM +0300, Tomi Valkeinen wrote:

> > This doesn't mean that we'd have a separate driver for each device. For
> > example, we have a generic panel driver in OMAP, which contains a kind
> > of small panel database. The panel database contains the name of the
> > panel as a key, and panel specific configuration as a value. This
> > configuration could also contain some kind of generic power sequence.
>=20
> I see. I do like the idea of it, because it is more straightforward than
> representing the whole sequence in DT. Matching could be done using the
> standard compatible property.

Right.

> However this also means we'll essentially just be moving the board code.

What do you mean "just"? Wasn't the point of the whole "arm board file
mess" to get rid of the code from the board files? If the code in the
board file is device specific code, not board specific, then the driver
of the device is a logical place to place it.

And as I said, I don't have any problems with some kind of generic power
sequences. So the code in the board file could be moved and converted to
use the power sequences, if that is better than just plain c code.

> Being in a central location it would be easier to refactor commonalities
> though.
>=20
> > I'd like to require the board developer to only fill in to the DT data
> > what panel he is using, and how it's connected on his board. Not panel'=
s
> > internal functionality.
>=20
> The amount of work required by the board developer would largely depend
> on whether support for the panel is already present or not. For new
> panels this would mean that a new driver needs to be written, while
> representing the power sequence in DT might be easier to do, and readily
> available from some datasheet.

That's true.

However, if we already have a generic driver for that type of panel,
(which we would need anyway for the DT based approach), the developer
only needs to add the name of the panel and the data for the power
sequence to the panel driver's database, which is about the same amount
of work as with DT.

So it's really just a question of where to put the data in question, DT
or driver. Both contain the same data, and the data structure may also
be the same. In DT's case it just needs to be parsed first, whereas in
database case you'll enter the data in structs.

 Tomi


--=-7E61pVNOK8ptK17BGKHa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQM1rMAAoJEPo9qoy8lh71Dz4QAIt9FeQ0fcNavme5qLDfvdxb
AK/z9/DPBICHd9srOzUZ94EkVClmGDwQ18V18UgVnxBYbengCcaUCgWYH32u1IBf
h9p3mIeK7wNFimR3fygJCkuzveBvpMu6dFmYpUwOBdLNvS69l9C9TUKSgTmgvgR/
wWyBSMTWgR+1zM9FWv5muVfIK5K3r0TCL1Ypy0CKsgKQl9hG9akRRxW9Zc8ZtHsz
GO0xWoSHbSyKcspVIXOcZm3+ZDrvyPrrn3WSgOUQ6Q0ss/crdyTUzgVthr86bU4k
HE/iuvCv/LnxyZBNzJpFlj35hiATFFvE+R+dP/ZHB9c2OwkhtJ121ZA5PIuK1n6C
SatzFXHxdeAwnKKWmhZoRqip5jOd3b94sPn+Njbgrp0sWlVu+MB0ULUcMZu+Zg5e
9SPIsscsG54eY92cASxWAgkR+yTfoyS67oTHvbjgsy/8TxbqF4e+rP2ed9WJj/LY
ww0PW0E1lL/LQ79QndJ+PNnA6Mcm4Z8gLoNh3jq+URzctRt1QI87BgjC0rA8ZHo/
nn/0ruLuiFIFHaHQT56JRhub4phy5fpGCKeq1ygkRXBZFAOunPA6NUoZVo4b7ORv
AiKa9PtnRqF+6q7Aqo8ip6/21PoEHFI6eCem9DjzmHxFOJE3XKCn0HPVJBpbJQje
YDJ2tGzgU3fI6+pfnPeA
=NTnp
-----END PGP SIGNATURE-----

--=-7E61pVNOK8ptK17BGKHa--

