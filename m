From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] Re: FB model basic issues (WAS: radeon,
	apertures & memory mapping)
Date: Thu, 17 Mar 2005 10:25:48 +1100
Message-ID: <1111015548.7192.54.camel@gaston>
References: <1110696189.5787.100.camel@gaston>
	<Pine.LNX.4.62.0503150946180.30569@numbat.sonytel.be>
	<20050315133628.GA16051@sci.fi> <200503160737.04850.adaplas@hotpop.com>
	<1110930652.649.50.camel@gaston> <20050316014714.GA5387@sci.fi>
	<1110937887.649.101.camel@gaston>  <20050316195108.GA6651@sci.fi>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20050316195108.GA6651@sci.fi>
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, Jon Smirl <jonsmirl@yahoo.com>, xorg@lists.freedesktop.org, adaplas@pol.net, dri-devel@lists.sourceforge.net

On Wed, 2005-03-16 at 21:51 +0200, Ville Syrj=E4l=E4 wrote:

> This was about the DirectFB drivers.
>=20
> One thing just popped to my head though. If in the future we are going =
to=20
> allow graphics cards to render to system memory, using the swapper will=
 no=20
> longer work. I don't see any other solution that having the CPU perform=
=20
> the byte swapping.

There is a _lot_ of existing code that will stop working, MOL is an
example, it requires proper "native" format for the framebuffer. X too
in it's current incarnation (fb format is defined at compile time I
think).

So the swapper is _needed_ for framebuffer access.

The best we can do is save/change/restore it around accesses like we do
already when copying YUV frames to video memory.

Now regarding the setup of the apertures, I suppose that I'll do
something complicated that nobody will use right, that is use 2 separate
apertures contiguous with each framebuffer at the beginning of each
aperture when CONFIG_APER_SIZE is 1/2 of vram size, and 2 separate
apertures contiguous with each framebuffer together in the first one in
the other cases. Only difference: first case will allow macs to have
separate swappers for each aperture. All other cases will have both
swappers set the same way. Hopefully, all "Mac" cards have
CONFIG_APER_SIZE set to half the vram.

Ben.
