From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: FB model basic issues (WAS: radeon, apertures & memory mapping)
Date: Wed, 16 Mar 2005 01:05:22 +0200
Message-ID: <20050315230522.GA1444@sci.fi>
References: <1110696189.5787.100.camel@gaston> <1110774523.4003.511.camel@localhost> <1110784327.5787.288.camel@gaston> <1110817205.4004.527.camel@localhost> <1110837171.5863.16.camel@gaston> <1110838356.4003.548.camel@localhost> <1110839873.5673.41.camel@gaston> <1110862777.4044.592.camel@localhost> <20050315060138.GA13064@sci.fi> <1110926659.25201.11.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
In-Reply-To: <1110926659.25201.11.camel@gaston>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, dri-devel@lists.sourceforge.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, xorg@lists.freedesktop.org, Jon Smirl <jonsmirl@yahoo.com>

On Wed, Mar 16, 2005 at 09:44:19AM +1100, Benjamin Herrenschmidt wrote:
>=20
> > DirectFB assumes all memory outside var.yres_virtual * fix.line_lengt=
h is=20
> > preserved. A totally valid assumption in my opinion.=20
>=20
> Except that you can't know in advance how much fix.line_length will be.
> The "fix" isn't really "fixed". Different cards will have different
> requirements depending on the bit depth for example. On radeonfb, the
> line_length will vary due to alignment constraints related to the
> engine, or due to tiling, etc.... etc...
>=20
> So you basically don't know in advance what will be preserved... (And
> you can't, unless you start having all sort of card specific knowledge)=
.

True. Currently DirectFB doesn't handle this correctly. But that could be=
=20
easily fixed if only line_length wasn't totally misplaced. It really=20
belongs to fb_var_screeninfo. We could first test the mode with=20
FB_ACTIVATE_TEST and actually see how much memory it needs and could=20
evict enough offscreen surfaces to make room before actually setting the=20
mode. Currently it would need some guesswork.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
