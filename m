From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [Linux-fbdev-devel] Re: FB model basic issues (WAS: radeon,
	apertures & memory mapping)
Date: Tue, 15 Mar 2005 15:36:28 +0200
Message-ID: <20050315133628.GA16051@sci.fi>
References: <1110696189.5787.100.camel@gaston>
	<1110774523.4003.511.camel@localhost>
	<1110784327.5787.288.camel@gaston>
	<1110817205.4004.527.camel@localhost>
	<1110837171.5863.16.camel@gaston>
	<1110838356.4003.548.camel@localhost>
	<1110839873.5673.41.camel@gaston>
	<1110862777.4044.592.camel@localhost>
	<20050315060138.GA13064@sci.fi>
	<Pine.LNX.4.62.0503150946180.30569@numbat.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0503150946180.30569@numbat.sonytel.be>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, dri-devel@lists.sourceforge.net, Jon Smirl <jonsmirl@yahoo.com>, xorg@lists.freedesktop.org

On Tue, Mar 15, 2005 at 09:51:40AM +0100, Geert Uytterhoeven wrote:
> On Tue, 15 Mar 2005, Ville [iso-8859-1] Syrj??wrote:
> > If radeonfb will allocate the buffer for the second head from the top=
 of=20
> > the memory users would basically have to guess it's location. matroxf=
b=20
> > simply cuts the memory in two pieces and allocates the buffers from t=
he=20
> > start of each piece. I don't really like that approach. Adding a simp=
le=20
> > byte_offset field to fb_var_screeninfo would solve the problem quite=20
> > nicely but I don't know if such API changes are acceptable at this st=
age.
>=20
> You wouldn't have to guess its location, look at fix.smem_start.

But how would someone mmap() the whole memory then? matroxfb already play=
s=20
tricks on fix.smem_start on Millennium I/II cards and it really confuses=20
DirectFB's memory allocator.

> I once did a similar thing for an embedded prototype: take a fixed amou=
nt of
> memory for both frame buffers (this was a UMA system), fb0 starts from =
the top,
> fb1 starts from the bottom. You can enlarge each frame buffer, until yo=
u read
> the memory of the other. Each fix.smem_{start,len} corresponds exactly =
to the
> memory allocated to each frame buffer.
>=20
> Of course, if you also want off-screen memory (i.e. memory beyond
> xres_virtual*yres_virtual*bpp/8), things get more complicated, since cu=
rrently
> there's no way for the application to ask for a minimum amount of off-s=
creen
> memory. Perhaps a new field in fb_var_screeninfo (and zero means `I don=
't
> care', for backwards compatibility).

Offscreen memory is pretty much essential for DirectFB.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
