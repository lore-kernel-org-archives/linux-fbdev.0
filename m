From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: FB model basic issues (WAS: radeon, apertures & memory mapping)
Date: Wed, 16 Mar 2005 10:49:11 +1100
Message-ID: <1110930551.649.47.camel@gaston>
References: <1110696189.5787.100.camel@gaston>
	<1110774523.4003.511.camel@localhost>
	<1110784327.5787.288.camel@gaston>
	<1110817205.4004.527.camel@localhost> <1110837171.5863.16.camel@gaston>
	<1110838356.4003.548.camel@localhost> <1110839873.5673.41.camel@gaston>
	<1110862777.4044.592.camel@localhost> <20050315060138.GA13064@sci.fi>
	<1110926659.25201.11.camel@gaston>  <20050315230522.GA1444@sci.fi>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20050315230522.GA1444@sci.fi>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
Content-Type: text/plain; charset="iso-8859-1"
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, dri-devel@lists.sourceforge.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, xorg@lists.freedesktop.org

On Wed, 2005-03-16 at 01:05 +0200, Ville Syrj=E4l=E4 wrote:

> True. Currently DirectFB doesn't handle this correctly. But that could =
be=20
> easily fixed if only line_length wasn't totally misplaced. It really=20
> belongs to fb_var_screeninfo. We could first test the mode with=20
> FB_ACTIVATE_TEST and actually see how much memory it needs and could=20
> evict enough offscreen surfaces to make room before actually setting th=
e=20
> mode. Currently it would need some guesswork.

Agreed. line_lenght was misplaced... I suppose there may be interest in
making a v2 of the var structure and using a flag to indicate wether we
are passing a v1 or a v2 one...

In the meantime, can you tell me more about your arbitration scheme ?
Arbitration is what I'm trying to solve. There are two main issues:
multiple card arbitration (that is, the VGA cruft to deal with) and
arbitration between access on X heads of the same card (which would be
nice, but not mandatory, DirectFB may take over all heads of the card,
doing that wuld require proper use of the DRM lock & engine context
switch, more of a long term goal).

Ben.
