From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: FB model basic issues (WAS: radeon, apertures & memory mapping)
Date: Thu, 17 Mar 2005 02:47:13 +0200
Message-ID: <20050317004713.GB8081@sci.fi>
References: <1110839873.5673.41.camel@gaston>
	<1110862777.4044.592.camel@localhost>
	<20050315060138.GA13064@sci.fi> <4236C770.8020101@hispeed.ch>
	<1110907029.4001.624.camel@localhost>
	<1110942559.24296.107.camel@gaston> <20050316200808.GB6651@sci.fi>
	<a728f9f90503161258181977fa@mail.gmail.com>
	<20050316210812.GA19937@sci.fi> <1111015801.15509.62.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
In-Reply-To: <1111015801.15509.62.camel@gaston>
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, Jon Smirl <jonsmirl@yahoo.com>, xorg@lists.freedesktop.org, Alex Deucher <alexdeucher@gmail.com>, dri-devel@lists.sourceforge.net

On Thu, Mar 17, 2005 at 10:30:01AM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2005-03-16 at 23:08 +0200, Ville Syrj=E4l=E4 wrote:
> > On Wed, Mar 16, 2005 at 03:58:07PM -0500, Alex Deucher wrote:
>=20
> > I haven't seen anyone coming forward with a design/code for the memor=
y=20
> > manager.
> >=20
> > In the meantime I'm assuming that people might want to make some use =
of=20
> > their dualhead cards...
>=20
> Are you aware that with the current fbdev API, there will simply be no
> working use of dual head ? As soon as somebody will try to do 2
> different things on the 2 heads, it will either lockup due to lack of
> engine arbitration, or have wrong endianness, or whatever ...

I understand you can't have userspace program the accelerator while=20
someone else is doing the same thing. Oh and I now understand that the=20
same really applies to direct framebuffer access due to the swapper. I=20
hadn't really thought about that issue before since I don't own a=20
big-endian system. I really must try to get one...

So basically to fix both issues we need some locks everyone must acquire=20
before accessing the hardware.

With the current "mmap() registers and go" interface the accelerator lock=
=20
wouldn't actually guarantee anything but it would allow well behaving=20
applications to share the accelerator. Good behaviour is already expected=
=20
from the applications anyway due to the direct access to hardware=20
registers.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
