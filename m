From: Kevin Hao <haokexin@gmail.com>
Date: Fri, 27 Feb 2015 01:05:49 +0000
Subject: Re: [PATCH 03/15] fbdev: aty128fb: replace PPC_OF with PPC
Message-Id: <20150227010549.GA10596@pek-khao-d1.corp.ad.wrs.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
 <1422712065-9403-4-git-send-email-haokexin@gmail.com>
 <1424995875.4645.42.camel@kernel.crashing.org>
In-Reply-To: <1424995875.4645.42.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Paul Mackerras <paulus@samba.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2015 at 11:11:15AM +1100, Benjamin Herrenschmidt wrote:
> On Sat, 2015-01-31 at 21:47 +0800, Kevin Hao wrote:
> > The PPC_OF is a ppc specific option which is used to mean that the
> > firmware device tree access functions are available. Since all the
> > ppc platforms have a device tree, it is aways set to 'y' for ppc.
> > So it makes no sense to keep a such option in the current kernel.
> > Replace it with PPC.
> >=20
> > Signed-off-by: Kevin Hao <haokexin@gmail.com>
>=20
> For this and generally the whole series,
>=20
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Thanks Ben.

>=20
> Which tree do we expect this to go through ?

I just sent out a v2 [1] a few hours earlier with some minor updates. We pl=
an
to merge this patch series via the powerpc tree in 4.1 cycle if I can colle=
ct
all the acks from the corresponding driver maintainers.

[1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-February/125331.ht=
ml

Thanks,
Kevin

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU78LtAAoJEJNY7TDerrFxz1wH/RHF9qNesB2DqntsnRqlVQiG
t7aFJPo+T8IHvGKlt6w8RXMoUHFHj7hB9jjB86s+Pfl63eB6qIc5qvD8ty8eBk4a
98hzmB8RuyEsKu0mC9bZVSYLYFr9wkbNhHMJNRAlmndk08shS82JNVU3bmLQXQOG
z2CheuW1l7x6N508hTWgeXPZd8aHHwsZAVwdC3Wm9YLxPnvwWiWS05wNKvzyk5NI
NSZ2drghdtATkSTrBLCaHVwl4P3ksKnK/KsX0lm+r9pMzh+4grqmoKejJRwEtWa4
k5soQWcl4fTwV6ein/X8QgMPbR6uShsXjFbi0qDDnlrEm+6+Ev+HfvXQGEBUIMA=
=cfO6
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
