From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 18 Sep 2011 19:49:09 +0000
Subject: Re: [PATCH v3 0/3] fbdev: Add FOURCC-based format configuration API
Message-Id: <4E764B35.2090009@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1314789501-824-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1314789501-824-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org, magnus.damm@gmail.com

Hi all,

as there was no reaction to this patch series I am scheduling it for 3.3 me=
rge
window (3.2 seems too close to me as this is an API change). As the second =
patch
has nothing to do with fbdev it should go mainline via V4L2. Any problems/c=
omments?


Best regards,

Florian Tobias Schandinat


On 08/31/2011 11:18 AM, Laurent Pinchart wrote:
> Hi everybody,
>=20
> Here's the third version of the fbdev FOURCC-based format configuration A=
PI.
>=20
> Compared to the previous version, I've added an FB_TYPE_FOURCC in additio=
n to
> FB_VISUAL_FOURCC, fixed the documentation (thanks to Geert for reviewing =
it
> and explaining how fbdev bitplanes work) and fixed bugs in the sh_mobile_=
lcdc
> YUV support.
>=20
> The sb_mobile_lcdc patch applies on top of the latest patches that I've s=
ent
> to the list. You can find a consolidated version that includes this patch=
 set
> at http://git.linuxtv.org/pinchartl/fbdev.git/shortlog/refs/heads/fbdev-y=
uv.
>=20
> I've updated the fbdev-test tool to add FOURCC support. The code is avail=
able
> in the fbdev-test yuv branch at
> http://git.ideasonboard.org/?p=FBdev-test.git;a=3Dshortlog;h=3Drefs/heads=
/yuv.
>=20
> Laurent Pinchart (3):
>   fbdev: Add FOURCC-based format configuration API
>   v4l: Add V4L2_PIX_FMT_NV24 and V4L2_PIX_FMT_NV42 formats
>   fbdev: sh_mobile_lcdc: Support FOURCC-based format API
>=20
>  Documentation/DocBook/media/v4l/pixfmt-nv24.xml |  129 ++++++++
>  Documentation/DocBook/media/v4l/pixfmt.xml      |    1 +
>  Documentation/fb/api.txt                        |  317 +++++++++++++++++=
+++
>  arch/arm/mach-shmobile/board-ag5evm.c           |    2 +-
>  arch/arm/mach-shmobile/board-ap4evb.c           |    4 +-
>  arch/arm/mach-shmobile/board-mackerel.c         |    4 +-
>  arch/sh/boards/mach-ap325rxa/setup.c            |    2 +-
>  arch/sh/boards/mach-ecovec24/setup.c            |    2 +-
>  arch/sh/boards/mach-kfr2r09/setup.c             |    2 +-
>  arch/sh/boards/mach-migor/setup.c               |    4 +-
>  arch/sh/boards/mach-se/7724/setup.c             |    2 +-
>  drivers/video/sh_mobile_lcdcfb.c                |  362 +++++++++++++++--=
------
>  include/linux/fb.h                              |   28 ++-
>  include/linux/videodev2.h                       |    2 +
>  include/video/sh_mobile_lcdc.h                  |    4 +-
>  15 files changed, 726 insertions(+), 139 deletions(-)
>  create mode 100644 Documentation/DocBook/media/v4l/pixfmt-nv24.xml
>  create mode 100644 Documentation/fb/api.txt
>=20

