From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] Re: FB model basic issues (WAS: radeon,
	apertures & memory mapping)
Date: Wed, 16 Mar 2005 10:50:52 +1100
Message-ID: <1110930652.649.50.camel@gaston>
References: <1110696189.5787.100.camel@gaston>
	<Pine.LNX.4.62.0503150946180.30569@numbat.sonytel.be>
	<20050315133628.GA16051@sci.fi> <200503160737.04850.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <200503160737.04850.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Jon Smirl <jonsmirl@yahoo.com>, xorg@lists.freedesktop.org, dri-devel@lists.sourceforge.net, Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>

On Wed, 2005-03-16 at 07:37 +0800, Antonino A. Daplas wrote:
> On Tuesday 15 March 2005 21:36, Ville Syrj=E4l=E4 wrote:
> > On Tue, Mar 15, 2005 at 09:51:40AM +0100, Geert Uytterhoeven wrote:
> > > On Tue, 15 Mar 2005, Ville [iso-8859-1] Syrj??wrote:
> > > > If radeonfb will allocate the buffer for the second head from the=
 top
> > > > of the memory users would basically have to guess it's location.
> > > > matroxfb simply cuts the memory in two pieces and allocates the b=
uffers
> > > > from the start of each piece. I don't really like that approach. =
Adding
> > > > a simple byte_offset field to fb_var_screeninfo would solve the p=
roblem
> > > > quite nicely but I don't know if such API changes are acceptable =
at
> > > > this stage.
> > >
> > > You wouldn't have to guess its location, look at fix.smem_start.
> >
> > But how would someone mmap() the whole memory then? matroxfb already =
plays
>=20
> This is multi-head, right?  That implies one fb per head.  So,  can't y=
ou do
> separate mmaps?  fb0->fix.smem_start|len and fb1->fix.smem_start|len.

Sure, re-read the thread :) Also, he's worried about management of
offscreen memory. (which is an issue too because of possible problems
with the setup of the apertures -> start of the discussion, and because
it seems that directFB has only been tested on little endian machines
(damn them !) and thus doesn't understand the problem with swapper on
framebuffer access).

Ben.
