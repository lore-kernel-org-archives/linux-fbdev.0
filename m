From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Re: [Linux-fbdev-devel] Redesign of kernel graphics interface
Date: Sat, 15 May 2004 11:25:12 +0300
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <20040515082512.GC28940@sci.fi>
References: <20040514180814.GA18297@sci.fi> <20040514184004.16621.qmail@web14930.mail.yahoo.com> <20040514190103.GA18868@sci.fi> <40A5C666.8020901@qanu.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <40A5C666.8020901@qanu.de>
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

On Sat, May 15, 2004 at 09:27:34AM +0200, Holger Waechtler wrote:
> Ville Syrj=E4l=E4 wrote:
> >On Fri, May 14, 2004 at 11:40:04AM -0700, Jon Smirl wrote:
> >
> >>Does DirectFB work on anything beside Matrox now?
> >
> >
> >It works on any card with a working fbdev driver (vga16fb excluded).=20
> >Hardware acceleration is available on quite a few chips these days.
> >
> >ati128  cyber5k  mach64  neomagic  nvidia  savage  tdfx
> >cle266  i810     matrox  nsc       radeon  sis315
>=20
> Keep in mind that beside the matrox driver almost none of them=20
> implements the full accelerated 2D API

cle266 is about the same level as matrox. I could get mach64 into this=20
group with some modifications to the memory allocator. I think for some o=
f=20
the other drivers the biggest problem is lack of developers.

> and that most are misusing the 3D=20
> engine to implement 2D functionality. Alpha blended stretch blits are=20
> almost always implemented using the 3D texture engines on PC graphics c=
ards.

I don't consider that mis-use, simply use.

> About one third of these drivers have been written using specs and=20
> documentation files that have never been officially released by the=20
> hardware vendors, so I'm not really sure whether they are much better=20
> from a security point of view than a closed source driver -- what's the=
=20
> point of a open source hardware driver without hardware specs? - you're=
=20
> not really able to review it seriously.

I don't think the specs would help in that regard much. For all you know=20
the specs could be all wrong. If you have the code and can see the=20
expected results that usually means the code works correctly. And closed=20
source kernel drivers could do a lot of other nasty stuff even without=20
touching the hardware.

> The specs for the remaining ones usually showed up as soon the hardware=
=20
> was getting outdated. Basically the same situation like the one you see=
=20
> with DRI drivers.

Except now the specs are getting harder to get even for old hardware. The=
=20
vendors seem to be returning to the old ways :(

> >I use matrox and mach64 drivers daily. It's been a few years since I=20
> >seriously used XFree86.
>=20
> Have you ever thought about the inherent security risks of memory mappe=
d=20
> i/o registers when executing non-trusted applications? Imagine what=20
> happens if every single application is allowed to program the blitter=20
> and texture engines to copy host memory from anywhere in the system to=20
> graphics memory and back - a single misbehaving application can damage=20
> your entire system.

I am aware of the risks. Currently it's not an issue for me. And if I=20
limit myself to running only XDirectFB the risk is equal to running=20
accelerated XFree86. Of course I would be glad to make it all secure but=20
only without losing any of the nice features.

> And do you really have the time to review every line of code you execut=
e=20
> on your system?

Clearly not. There is some stuff you just have to trust (or not care).

> >>2) mesa supports a broad number of cards, basically everything there =
is=20
> >>doc for
> >
> >
> >Just about as broad as DirectFB.
>=20
> be honest.

I am. This is the list of drivers in Mesa cvs:
i810   mga     radeon  tdfx=20
ffb    i830    r128  savage  unichrome
gamma  mach64  r200  sis

The list is almost the same as the DirectFB driver list. Granted that som=
e=20
of the Mesa drivers use more of the hardware's capabilities, but that's=20
only because I don't have the hardware ;)

> >I'm not suggesting that everyone start using DirectFB. Everyong should=
 be=20
> >able to use any API they want. The kernel should provide just enough t=
o=20
> >allow these APIs to be implemented.
>=20
> that would be always possible, don't worry.

I do worry a bit because of this OpenGL as the one and only API talk.

> Please keep in mind that we developed DirectFB at Convergence as API to=
=20
> access SettopBox and Game Console functionality in a convenient way, it=
=20
> was never intended and has not been designed for use in=20
> security-critical desktop or workstation environments.

I am aware of that and that's why I don't recommend it to everyone.=20
Personally I just find it to my liking. Even the code itself makes me=20
a happy camper whereas XFree86 code gives me a headache...

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
