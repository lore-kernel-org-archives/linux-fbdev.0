From: Yegor Yefremov <yegorslists@googlemail.com>
Date: Wed, 04 Jan 2017 16:25:30 +0000
Subject: OMAP3: DSS questions
Message-Id: <CAGm1_ktY3djv8yp3e+w-DmtFa_9HmEkXn-d1e4AKsPGnES_Rrw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

I'm trying to get my am3517 board working with 4.10 (porting from
2.6.37). An LCD screen is attached to OMAP DSS using 24 bits. Display
config looks like this in [1].

What DTS options reflectes ".acb =3D 0x0"?

Btw. I just need a frame buffer device and will use it with Embedded
Qt. Should I nevertheless use DRM flavor as it already provides frame
buffer driver?

drivers/gpu/drm/omapdrm/displays/panel-dpi.c performs either platform
or OF initialization. Platform flavor contains data_lines info, OF -
not. As I'm using OF flavor, how do I get proper data_lines info?

[1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/=
?id=992ee64af66f05e16aa70b475f9ad3047f801185

Yegor
