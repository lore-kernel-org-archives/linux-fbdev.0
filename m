From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: radeon, apertures & memory mapping
Date: Mon, 14 Mar 2005 18:16:30 +0200
Message-ID: <20050314161630.GA21086@sci.fi>
References: <1110677744.19810.80.camel@gaston> <20050313082216.GA7362@sci.fi>
	<1110705646.14684.126.camel@gaston> <20050313103936.GA11002@sci.fi>
	<1110715499.14684.132.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
In-Reply-To: <1110715499.14684.132.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, xorg@lists.freedesktop.org

On Sun, Mar 13, 2005 at 11:04:59PM +1100, Benjamin Herrenschmidt wrote:
> >=20
> > I must be missing something something obvious because I don't quite=20
> > understand what major drawbacks there are with the non-overlapping mo=
de.=20
> > As I see it you get at least the same amount of CPU accessible memory=
 as=20
> > you get in the overlapping mode.
>=20
> Yes, you do, but that means that if the apertures are configured such
> that the entire VRAM fits in a single aperture, then you just can't use
> the second aperture at all. Which means you can't have separate swapper
> setting for both apertures, and thus, can't let two independant
> processes access the video memory with different bit depth, at least on
> big endian machines unless you do trickery, and play with the swapper
> before each access.

Ok so the problem is byte swapping. Looking at atyfb for example it uses=20
the "big-endian" aperture on big-endian systems and selects the byte=20
swapping method according to the bit depth. If that really means that all=
=20
host access to the aperture gets byte swapped then I don't see how the=20
current situation can work correctly for DirectFB. Offscreen surfaces can=
=20
use any bit depth and so their bytes could be swapped incorrectly. Makes=20
me wish I had a PPC box alongside the x86 one.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
