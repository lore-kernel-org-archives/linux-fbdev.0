From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Re: [Linux-fbdev-devel] Redesign of kernel graphics interface
Date: Fri, 14 May 2004 22:01:03 +0300
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <20040514190103.GA18868@sci.fi>
References: <20040514180814.GA18297@sci.fi> <20040514184004.16621.qmail@web14930.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20040514184004.16621.qmail@web14930.mail.yahoo.com>
Errors-To: mesa3d-dev-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:mesa3d-dev@lists.sourceforge.net>
List-Help: <mailto:mesa3d-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=mesa3d-dev>
Content-Type: text/plain; charset="iso-8859-1"
To: dri-devel <dri-devel@lists.sourceforge.net>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Fri, May 14, 2004 at 11:40:04AM -0700, Jon Smirl wrote:
> --- Ville Syrj=E4l=E4 <syrjala@sci.fi> wrote:
> > > I said OpenGL is the only accelerated API available on Linux. Can y=
ou name
> > > another?
> >=20
> > DirectFB.
>=20
> Does DirectFB work on anything beside Matrox now?

It works on any card with a working fbdev driver (vga16fb excluded).=20
Hardware acceleration is available on quite a few chips these days.

ati128  cyber5k  mach64  neomagic  nvidia  savage  tdfx
cle266  i810     matrox  nsc       radeon  sis315

That's the list of drivers in DirectFB cvs. Plus there is at least one=20
driver outside the DirectFB tree.

I use matrox and mach64 drivers daily. It's been a few years since I=20
seriously used XFree86.

> > > There is a little acceleration in framebuffer, but I don't know of =
any
> > > others. Also, software mesa works just fine to provide OpenGL on du=
mb 2D
> > cards.
> >=20
> > Using unaccelerated OpenGL for 2D rendering doesn't sound exatly usef=
ul.=20
>=20
> There is much more to 2D rendering in things like the Mac UI and Longho=
rn than
> can be accomplished with BitBlt. You need transforms, filters and alpha
> blending. Hardware texturing is much faster than doing it in software. =
Some of
> the effects are achieved with pixel shaders. xserver features a fully c=
omposited
> window manager, it needs these features to have a fast response time.
>=20
> OpenGL to me seems like the best pick for these reasons:
> 1) with have a good open source version, mesa
> 2) mesa supports a broad number of cards, basically everything there is=
 doc for

Just about as broad as DirectFB.

> 3) OpenGL is a well published API, it is taught in universities and man=
y books
> are available
> 4) It is likely that Nvidia and ATI will support standalone OpenGL stac=
ks for
> their high end hardware on Linux
> 5) OpenGL is cross-platform. For example Cairo is being written with an=
 OpenGL
> back end. OpenGL Cairo will run on Window and the Mac too. This will ma=
ke Linux
> apps more portable.
> 6) The embedded market has OpenGL-ES which can run in less than 100K.
>=20
> What would be reasons for picking another API?

DirectFB is good for a few reasons:
- Input handling
- Easy access to hardware overlays
- YUV formats
- Ease of porting DirectX applications
- Good acceleration
- Easy API / personal preference

I'm not suggesting that everyone start using DirectFB. Everyong should be=
=20
able to use any API they want. The kernel should provide just enough to=20
allow these APIs to be implemented.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
