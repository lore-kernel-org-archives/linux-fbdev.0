From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [Linux-fbdev-devel] Re: FB model basic issues (WAS: radeon,
	apertures & memory mapping)
Date: Wed, 16 Mar 2005 03:47:14 +0200
Message-ID: <20050316014714.GA5387@sci.fi>
References: <1110696189.5787.100.camel@gaston>
	<Pine.LNX.4.62.0503150946180.30569@numbat.sonytel.be>
	<20050315133628.GA16051@sci.fi>
	<200503160737.04850.adaplas@hotpop.com>
	<1110930652.649.50.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
In-Reply-To: <1110930652.649.50.camel@gaston>
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, Jon Smirl <jonsmirl@yahoo.com>, xorg@lists.freedesktop.org, adaplas@pol.net, dri-devel@lists.sourceforge.net

On Wed, Mar 16, 2005 at 10:50:52AM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2005-03-16 at 07:37 +0800, Antonino A. Daplas wrote:
> > On Tuesday 15 March 2005 21:36, Ville Syrj=E4l=E4 wrote:
> > > On Tue, Mar 15, 2005 at 09:51:40AM +0100, Geert Uytterhoeven wrote:
> > > > On Tue, 15 Mar 2005, Ville [iso-8859-1] Syrj??wrote:
> > > > > If radeonfb will allocate the buffer for the second head from t=
he top
> > > > > of the memory users would basically have to guess it's location=
.
> > > > > matroxfb simply cuts the memory in two pieces and allocates the=
 buffers
> > > > > from the start of each piece. I don't really like that approach=
. Adding
> > > > > a simple byte_offset field to fb_var_screeninfo would solve the=
 problem
> > > > > quite nicely but I don't know if such API changes are acceptabl=
e at
> > > > > this stage.
> > > >
> > > > You wouldn't have to guess its location, look at fix.smem_start.
> > >
> > > But how would someone mmap() the whole memory then? matroxfb alread=
y plays
> >=20
> > This is multi-head, right?  That implies one fb per head.  So,  can't=
 you do
> > separate mmaps?  fb0->fix.smem_start|len and fb1->fix.smem_start|len.
>=20
> Sure, re-read the thread :) Also, he's worried about management of
> offscreen memory. (which is an issue too because of possible problems
> with the setup of the apertures -> start of the discussion,

There's also the case with Matrox Millennium I/II cards. They must place=20
the visible frame buffer so that no line crosses the boundary of memory=20
banks. matroxfb deals with that by moving the buffer and changing=20
smem_start and smem_len appropriately. But that is really bad for=20
DirectFB's offscreen memory management. After a mode switch the memory=20
manager would need to know what kind of initial byte offset was used. Of=20
couse it would be possible to determine that from smem_start by knowing=20
how the aperture must be aligned. Actually we already do that sort of=20
thing to allow hw accelerated rendering when used on matroxfb controlled=20
G450/G450/G550 CRTC2. But in that case the offset won't change on mode=20
switch.

> and because
> it seems that directFB has only been tested on little endian machines
> (damn them !) and thus doesn't understand the problem with swapper on
> framebuffer access).

Actually people do use it on big-endian systems but since neither the=20
mach64, ati128 or radeon drivers play with the swapper settings I can onl=
y=20
assume that they haven't been tested very extensively.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
