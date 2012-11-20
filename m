From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Tue, 20 Nov 2012 19:35:31 +0000
Subject: Re: [PATCH v12 0/6] of: add display helper
Message-Id: <20121120193531.GB27186@avionic-0098.adnet.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1UWUbFP1cBYEclgG"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353426896-6045-1-git-send-email-s.trumtrar@pengutronix.de>
 <1501232.SOApmW1MhU@avalon>
 <20121120181129.GI23204@pengutronix.de>
In-Reply-To: <20121120181129.GI23204@pengutronix.de>
To: Robert Schwebel <r.schwebel@pengutronix.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, devicetree-discuss@lists.ozlabs.org, Rob Herring <robherring2@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Guennady Liakhovetski <g.liakhovetski@gmx.de>, linux-media@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, kernel@pengutronix.de, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, David Airlie <airlied@linux.ie>


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 20, 2012 at 07:11:29PM +0100, Robert Schwebel wrote:
> On Tue, Nov 20, 2012 at 05:13:19PM +0100, Laurent Pinchart wrote:
> > On Tuesday 20 November 2012 16:54:50 Steffen Trumtrar wrote:
> > > Hi!
> > >=20
> > > Changes since v11:
> > > 	- make pointers const where applicable
> > > 	- add reviewed-by Laurent Pinchart
> >=20
> > Looks good to me.
> >=20
> > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >=20
> > Through which tree do you plan to push this ?
>=20
> We have no idea yet, and none of the people on Cc: have volunteered
> so far... what do you think?

The customary approach would be to take the patches through separate
trees, but I think this particular series is sufficiently interwoven to
warrant taking them all through one tree. However the least that we
should do is collect Acked-by's from the other tree maintainers.

Given that most of the patches modify files in drivers/video, Florian's
fbdev tree would be the most obvious candidate, right? If Florian agrees
to take the patches, all we would need is David's Acked-by.

How does that sound?

Thierry

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQq9uDAAoJEN0jrNd/PrOhl1sP/09Fbj7Ir5DYGqwS4kY70Ff1
RW/G7Biq2ghMfnFR0X/podiv0M+G1dVov4k/b6l9lqtdDhcGrKWyAVyU5zALfP7N
qXAWPX9fid3eWEXuhZpOnRQWBYDSyGPtaaxl0r+80SF+DubQ9uawEWOPWQbiH2kX
//PK3Lhn+AUtU3Xy+/0C/p4GTXuoiGLfhDBgelsqfm43berRTVaI3wdRqEikpBPX
354uJ0EJ/4ZSlZp6lTYRPCiwSbzHh+KGn/4dbHejJN8O+9+soBoAyprY1T93FcWF
kOsEHM7n7djthSN/kBbqfrzGluYMNje6d1A/5Zn2Z3Oto/PpwJDS1WS7Pe2U730y
cZAdqEMG9q26xxG9bCOIKrgjudH0tnF/2ZiBLswrcyuEXrGcYc5eUSUZnBjHxnKu
/R0FQqorFnn/85pt11UgweCt9W5zEFpmHK9o6Pzga+pa5u207GFUG7lNcMShjvww
Jnw//aSTE0t1erz7VUrzIXksPa+Veyn2lc/wpQ4hvU4AQMYYu6OfS+4wWz9bGihU
dC7uCmBC9ZevfNdgkRey6bFVkPnvv/MbstJKywcBmHDNKvcAOkz/A+yWGSBXQRtZ
I7V8Zh+kk1lfQ7lEJxhDuepakOSDNKgDzGSR6DKtWHYC3a8hg2XuEXvlK3j1tkDv
+i9XglyE/awWDzMHPkeH
=ugHw
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
