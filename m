From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: FB model basic issues (WAS: radeon, apertures & memory mapping)
Date: Wed, 16 Mar 2005 10:34:40 +1100
Message-ID: <1110929680.649.36.camel__12265.2176920839$1110929919$gmane$org@gaston>
References: <1110696189.5787.100.camel@gaston>
	 <1110774523.4003.511.camel@localhost> <1110784327.5787.288.camel@gaston>
	 <1110817205.4004.527.camel@localhost> <1110837171.5863.16.camel@gaston>
	 <1110838356.4003.548.camel@localhost> <1110839873.5673.41.camel@gaston>
	 <1110862777.4044.592.camel@localhost> <20050315060138.GA13064@sci.fi>
	 <1110869983.29138.88.camel@gaston>  <20050315140005.GB16051@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20050315140005.GB16051@sci.fi>
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
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, dri-devel@lists.sourceforge.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, xorg@lists.freedesktop.org, Jon Smirl <jonsmirl@yahoo.com>

On Tue, 2005-03-15 at 16:00 +0200, Ville Syrj=E4l=E4 wrote:

> DirectFB has it's own asbitration mechanism. It doesn't support using=20
> multiple framebuffer devices at the same time. For that to work DirectF=
B=20
> would just have to know if some of the framebuffer devices are actually=
=20
> different outputs of the same card so that it could associate both with=
=20
> the same lock and accelerator state.
>=20
> With the current system I don't see much chance of using accelerated fb=
con=20
> on one head and accelerated DirectFB (or something else) on the other.

Oh, I think that won't happen unless directFB maps it's arbitration
mecanism on top of the DRM lock and fbcon does that too.

BTW. Can you quickly explain me the DirectFB arbitration mecanism ?
We'll need to map it on top of the VGA arbiter _at_least_ ...

Ben.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
