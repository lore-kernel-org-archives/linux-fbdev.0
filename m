From: Tony Lindgren <tony@atomide.com>
Date: Thu, 05 Jan 2017 16:49:22 +0000
Subject: Re: OMAP3: DSS questions
Message-Id: <20170105164921.GF4310@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAGm1_ktY3djv8yp3e+w-DmtFa_9HmEkXn-d1e4AKsPGnES_Rrw@mail.gmail.com>
In-Reply-To: <CAGm1_ktY3djv8yp3e+w-DmtFa_9HmEkXn-d1e4AKsPGnES_Rrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

* Yegor Yefremov <yegorslists@googlemail.com> [170104 08:27]:
> I'm trying to get my am3517 board working with 4.10 (porting from
> 2.6.37). An LCD screen is attached to OMAP DSS using 24 bits. Display
> config looks like this in [1].
>=20
> What DTS options reflectes ".acb =3D 0x0"?
>=20
> Btw. I just need a frame buffer device and will use it with Embedded
> Qt. Should I nevertheless use DRM flavor as it already provides frame
> buffer driver?
>=20
> drivers/gpu/drm/omapdrm/displays/panel-dpi.c performs either platform
> or OF initialization. Platform flavor contains data_lines info, OF -
> not. As I'm using OF flavor, how do I get proper data_lines info?

Adding Tomi Valkeinen to Cc.

Tony


> [1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commi=
t/?id=992ee64af66f05e16aa70b475f9ad3047f801185
