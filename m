From: Holger Waechtler <holger@qanu.de>
Subject: Re: Re: [Linux-fbdev-devel] Redesign of kernel graphics
 interface
Date: Sat, 15 May 2004 09:27:34 +0200
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <40A5C666.8020901@qanu.de>
References: <20040514180814.GA18297@sci.fi> <20040514184004.16621.qmail@web14930.mail.yahoo.com> <20040514190103.GA18868@sci.fi>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
In-Reply-To: <20040514190103.GA18868@sci.fi>
Errors-To: mesa3d-dev-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:mesa3d-dev@lists.sourceforge.net>
List-Help: <mailto:mesa3d-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=mesa3d-dev>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: dri-devel <dri-devel@lists.sourceforge.net>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

Ville Syrj=E4l=E4 wrote:
> On Fri, May 14, 2004 at 11:40:04AM -0700, Jon Smirl wrote:
>=20
>>--- Ville Syrj=E4l=E4 <syrjala@sci.fi> wrote:
>>
>>>>I said OpenGL is the only accelerated API available on Linux. Can you=
 name
>>>>another?
>>>
>>>DirectFB.
>>
>>Does DirectFB work on anything beside Matrox now?
>=20
>=20
> It works on any card with a working fbdev driver (vga16fb excluded).=20
> Hardware acceleration is available on quite a few chips these days.
>=20
> ati128  cyber5k  mach64  neomagic  nvidia  savage  tdfx
> cle266  i810     matrox  nsc       radeon  sis315

Keep in mind that beside the matrox driver almost none of them=20
implements the full accelerated 2D API and that most are misusing the 3D =

engine to implement 2D functionality. Alpha blended stretch blits are=20
almost always implemented using the 3D texture engines on PC graphics car=
ds.

About one third of these drivers have been written using specs and=20
documentation files that have never been officially released by the=20
hardware vendors, so I'm not really sure whether they are much better=20
from a security point of view than a closed source driver -- what's the=20
point of a open source hardware driver without hardware specs? - you're=20
not really able to review it seriously.

The specs for the remaining ones usually showed up as soon the hardware=20
was getting outdated. Basically the same situation like the one you see=20
with DRI drivers.


> That's the list of drivers in DirectFB cvs. Plus there is at least one =

> driver outside the DirectFB tree.
>=20
> I use matrox and mach64 drivers daily. It's been a few years since I=20
> seriously used XFree86.

Have you ever thought about the inherent security risks of memory mapped =

i/o registers when executing non-trusted applications? Imagine what=20
happens if every single application is allowed to program the blitter=20
and texture engines to copy host memory from anywhere in the system to=20
graphics memory and back - a single misbehaving application can damage=20
your entire system.

And do you really have the time to review every line of code you execute =

on your system?


>>>>There is a little acceleration in framebuffer, but I don't know of an=
y
>>>>others. Also, software mesa works just fine to provide OpenGL on dumb=
 2D
>>>
>>>cards.
>>>
>>>Using unaccelerated OpenGL for 2D rendering doesn't sound exatly usefu=
l.=20
>>
>>There is much more to 2D rendering in things like the Mac UI and Longho=
rn than
>>can be accomplished with BitBlt. You need transforms, filters and alpha=

>>blending. Hardware texturing is much faster than doing it in software. =
Some of
>>the effects are achieved with pixel shaders. xserver features a fully c=
omposited
>>window manager, it needs these features to have a fast response time.
>>
>>OpenGL to me seems like the best pick for these reasons:
>>1) with have a good open source version, mesa
>>2) mesa supports a broad number of cards, basically everything there is=
 doc for
>=20
>=20
> Just about as broad as DirectFB.

be honest.


>>3) OpenGL is a well published API, it is taught in universities and man=
y books
>>are available
>>4) It is likely that Nvidia and ATI will support standalone OpenGL stac=
ks for
>>their high end hardware on Linux
>>5) OpenGL is cross-platform. For example Cairo is being written with an=
 OpenGL
>>back end. OpenGL Cairo will run on Window and the Mac too. This will ma=
ke Linux
>>apps more portable.
>>6) The embedded market has OpenGL-ES which can run in less than 100K.
>>
>>What would be reasons for picking another API?

:) well - I could see one, but that's not the point here, as soon you=20
have a secure low-level GPU interface you can place any API wrapper you=20
want above this, OpenGL is just one of multiple choices. But probably=20
the one that's most familiar to most of us.

Even a secure DirectFB port would be possible on top of this interface=20
if you don't need any 3D graphics (you remember the DirectFB-on-SDL=20
system target?).


> DirectFB is good for a few reasons:
> - Input handling
> - Easy access to hardware overlays
> - YUV formats
> - Ease of porting DirectX applications
> - Good acceleration
> - Easy API / personal preference
>=20
> I'm not suggesting that everyone start using DirectFB. Everyong should =
be=20
> able to use any API they want. The kernel should provide just enough to=
=20
> allow these APIs to be implemented.

that would be always possible, don't worry.

Please keep in mind that we developed DirectFB at Convergence as API to=20
access SettopBox and Game Console functionality in a convenient way, it=20
was never intended and has not been designed for use in=20
security-critical desktop or workstation environments.

Holger


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
