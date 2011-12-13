From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 13 Dec 2011 13:02:25 +0000
Subject: [PATCH v5 0/3] fbdev: Add FOURCC-based format configuration API
Message-Id: <1323781348-9884-1-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org
Cc: linux-media@vger.kernel.org

Hi everybody,
fbdev: Add FOURCC-based format configuration API
Here's the fifth version of the fbdev FOURCC-based format configuration API.

Compared to the fourth version,

- fb_set_var() now checks that the red, green, blue and transp fields are a=
ll
set to 0 when using the FOURCC-based API and return an error if they are not

- the NV24 and NV42 format documentation doesn't include emacs formatting
directives anymore.

As usual the fbdev-test tool supporting this new API is available in the
fbdev-test yuv branch at
http://git.ideasonboard.org/?p=FBdev-test.git;a=3Dshortlog;h=3Drefs/heads/y=
uv.

Laurent Pinchart (3):
  fbdev: Add FOURCC-based format configuration API
  v4l: Add V4L2_PIX_FMT_NV24 and V4L2_PIX_FMT_NV42 formats
  fbdev: sh_mobile_lcdc: Support FOURCC-based format API

 Documentation/DocBook/media/v4l/pixfmt-nv24.xml |  121 ++++++++
 Documentation/DocBook/media/v4l/pixfmt.xml      |    1 +
 Documentation/fb/api.txt                        |  306 +++++++++++++++++++
 arch/arm/mach-shmobile/board-ag5evm.c           |    2 +-
 arch/arm/mach-shmobile/board-ap4evb.c           |    4 +-
 arch/arm/mach-shmobile/board-mackerel.c         |    4 +-
 arch/sh/boards/mach-ap325rxa/setup.c            |    2 +-
 arch/sh/boards/mach-ecovec24/setup.c            |    2 +-
 arch/sh/boards/mach-kfr2r09/setup.c             |    2 +-
 arch/sh/boards/mach-migor/setup.c               |    4 +-
 arch/sh/boards/mach-se/7724/setup.c             |    2 +-
 drivers/video/fbmem.c                           |   14 +
 drivers/video/sh_mobile_lcdcfb.c                |  360 +++++++++++++++----=
----
 include/linux/fb.h                              |   14 +-
 include/linux/videodev2.h                       |    2 +
 include/video/sh_mobile_lcdc.h                  |    4 +-
 16 files changed, 707 insertions(+), 137 deletions(-)
 create mode 100644 Documentation/DocBook/media/v4l/pixfmt-nv24.xml
 create mode 100644 Documentation/fb/api.txt

--=20
Regards,

Laurent Pinchart

