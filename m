From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Date: Mon, 05 Dec 2011 16:57:00 +0000
Subject: Re: Problems with radeon driver under KDE-4.7.2
Message-Id: <1323104220.11335.511.camel@thor.local>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

[ Moving to the mesa-dev mailing list ]

On Son, 2011-11-27 at 15:15 +0100, Hendrik Sattler wrote:=20
>=20
> I just upgraded to KDE-4.7.2 and Linux-3.1 and mostly when using Firefox,=
 I=20
> get issues like a stall screen, then a short blank screen and then it wor=
ks=20
> some time until that happens again.
>=20
> The kernel log then shows something like:
> WARNING: at drivers/gpu/drm/radeon/radeon_fence.c:267=20
> radeon_fence_wait+0x215/0x292()
> Hardware name: TravelMate 6592
> GPU lockup (waiting for 0x00158B0E last fence id 0x00158B0C)
[...]=20
> So far, I think it's great that it can recover pretty fine most of the ti=
me=20
> :-)
> I now upgraded to Linux-3.1.3 and looked at the KDE setting about the pos=
sible
> cause for this. New to me was the desktop effect setting about using=20
> "OpenGL-2-Shader". I deactivated it and its stable so far. Is this a know=
=20
> issue?

Not that I know of. Which version of which Mesa driver are you using?
The output of glxinfo would be interesting.


> One other question: I saw that vdpau seems to be supported:
> [    24.226] (II) RADEON(0): [DRI2]   VDPAU driver: r600
> What exactly is needed to use this? I tried "mplayer -vo vdpau" but that =
only=20
> gives me:
> Failed to open VDPAU backend libvdpau_r600.so: cannot open shared object =
file:=20
> No such file or directory
> [vdpau] Error when calling vdp_device_create_x11: 1
> Error opening/initializing the selected video_out (-vo) device.
>=20
> Where can I get this file. Latest Debian does not seem to have it...

You need to build Mesa Git with at least --enable-vdpau. But note that
it's still rather experimental and may not be useful to you, e.g. it can
only decode MPEG 1/2 with the help of GPU shaders so far.


--=20
Earthling Michel D=C3=A4nzer           |                   http://www.amd.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
