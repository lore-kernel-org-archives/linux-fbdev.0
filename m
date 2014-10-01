From: Thierry Reding <thierry.reding@gmail.com>
Date: Wed, 01 Oct 2014 12:48:02 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20141001124800.GA21733@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140929092301.GC4388@lukather> <20140929101805.GB26008@ulmo>
 <20140929114643.GB4081@lukather> <20140929134708.GB30998@ulmo>
 <20140929155517.GR16977@sirena.org.uk>
 <20140930050923.GB29874@ulmo> <20140930173928.GH4273@sirena.org.uk>
 <20141001074139.GB18463@ulmo>
 <CABxcv=nKErHGPRLM5yer2YnOc2VJPWLmeKgwXbXEU3r_XvsCyg@mail.gmail.com>
 <20141001123250.GY4273@sirena.org.uk>
In-Reply-To: <20141001123250.GY4273@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 01, 2014 at 01:32:50PM +0100, Mark Brown wrote:
> On Wed, Oct 01, 2014 at 01:10:46PM +0200, Javier Martinez Canillas wrote:
[...]
> > Adding your resources (clock, regulators, etc) incrementally and only
> > when the driver for the device that use these resources is available,
> > will only make adding support for a new platform slower IMHO since
> > there will be more patches to be posted, reviewed and merged.
>=20
> So don't do that if you're worried about it then, provide the bits of DT
> that hook everything up from the start or otherwise describe things as
> being in use.

"Otherwise describe things as being in use" doesn't work for clocks for
example. And Mike already said he wasn't willing to add something like
an always-on DT property for clocks.

Thierry

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUK/gAAAoJEN0jrNd/PrOhLgMQAJcQaJ5nwl/I8jIBl8FtHfFG
+xnmjZlGjr6C7GMcuYVlNAIlkShsQ4gM0CNmBNFbcPbXgOOsx1nX9OOMVgdsE4hd
e57JbxSyNZVy9+4+82NzXAV/HoEkmPjxLW5BX7tpJjLN0Ct3NBxEd73CalzBxx1V
WlshRwavHT0Ol1HEjCR/neiWTpa46KdHDi9BPMEho7Kof34s71zJCp5Cis6OIeEw
8f3XgK+C7YqotVJizjiQ3QWLJLRToTBzdqPhWTsTVVbsc2F1lYUOu9+L5L/hhsjH
LqGkR7Uoa4bgRB3/Ty9ZEtyoZ64YQtCc407P0y4TNU9tcCJ064+G1hgCyOp4fdQd
oDvz3NIPSOIjOK7c6bUCnt6v/CY1at2gE4/yejdGND3SYDHkE8gPigPs3oDnE/xR
UuuqkFyT8cMEZegKARNpp0N1R9fybV9Jo3yjf2eaNLjpnMoh2hZF8ZIP6+N2KLrL
0RT1QNFvTqlgLODX5/+iKXE4BaloGiOhhZwUph9y1jB7VQlbGIgFBG9hlKvy8bXo
JexMUEsbuakpHZJO+bUQ4wrmGpvd5yQHSESP/ty1IM9iKmVqy9KkGSwusCWiuVKd
D1JRkBuavM4ilmWFUTs8FXthZpxCmwasvaMyuWtaSG7FlVl4dbyv+vAGe2Jw87k/
lRhqPbjVwGhbHmWyVFNK
=c/AO
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
