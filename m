From: Roland Scheidegger <rscheidegger_lists@hispeed.ch>
Subject: Re: FB model basic issues (WAS: radeon, apertures & memory mapping)
Date: Tue, 15 Mar 2005 12:30:56 +0100
Message-ID: <4236C770.8020101@hispeed.ch>
References: <1110677744.19810.80.camel@gaston>	<9e47339105031219223e606a52@mail.gmail.com>	<1110696189.5787.100.camel@gaston>	<1110774523.4003.511.camel@localhost>	<1110784327.5787.288.camel@gaston>	<1110817205.4004.527.camel@localhost>	<1110837171.5863.16.camel@gaston>	<1110838356.4003.548.camel@localhost>	<1110839873.5673.41.camel@gaston>	<1110862777.4044.592.camel@localhost>
	<20050315060138.GA13064@sci.fi>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20050315060138.GA13064@sci.fi>
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
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: =?ISO-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>, Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, dri-devel@lists.sourceforge.net, xorg@lists.freedesktop.org

Ville Syrj=E4l=E4 wrote:
  > I think that making the assumption that all memory is preserved when=20
the
> memory layout (virtual resolution and depth) doesn't change is perfectl=
y=20
> valid too. That would allow X to do it's Ctrl-Alt-+ and - things withou=
t=20
> repainting the whole screen.
I'm not sure I agree here, as it's not always true. For instance, the=20
radeon has some restrictions whether it can use tiling or not with a=20
certain mode (interlace/double scan) thus you need to redraw everything=20
anyway (which is exactly why I implemented a driver workaround to=20
repaint everything when that happens - in fact the workaround also gets=20
rid of the offscreen contents, which is not necessary, but was much=20
easier to implement, since I couldn't find an easy way to "invalidate=20
the framebuffer"). What's the big deal with repainting everything? It's=20
not like you would do 100 mode changes per second so it would be=20
performance-critical...

Roland
