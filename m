From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 31 Aug 2011 11:00:51 +0000
Subject: [PATCH v2 0/8] sh_mobile_lcdc: Support format changes at runtime
Message-Id: <1314788459-31791-1-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi everybody,

Here's the second version of the .fb_set_par() support for the sh_mobile_lc=
dc
driver patch set. It allows userspace to change the frame buffer format and
size at runtime. The patches apply on top of Florian's fbdev-next branch
available at git://github.com/schandinat/linux-2.6.git.

Compared to v1, this version includes an additional MERAM fix.

Frame buffer memory reallocation is currently not supported. You will need =
to
make sure platform data sets the maximum size and bpp to high enough values
for all formats and sizes you want to support at runtime.

The patches have been tested with the fbdev-test utility
(http://git.ideasonboard.org/?p=FBdev-test.git;a=3Dsummary) on a Mackerel b=
oard.

Laurent Pinchart (8):
  sh_mobile_meram: Reset ICBs at unregistration time
  fbdev: sh_mobile_lcdc: Adjust requested parameters in .fb_check_var
  fbdev: sh_mobile_lcdc: Add support for format changes at runtime
  fbdev: sh_mobile_lcdc: use display information in info for panning
  fbdev: sh_mobile_lcdc: Update fix.line_length in .fb_set_par()
  fbdev: sh_mobile_lcdc: Avoid forward declarations
  fbdev: sh_mobile_lcdc: Split channel initialization from probe
    function
  fbdev: sh_mobile_lcdc: Remove sh_mobile_lcdc_set_bpp()

 drivers/video/sh_mobile_lcdcfb.c |  570 +++++++++++++++++++++-------------=
----
 drivers/video/sh_mobile_meram.c  |    6 +-
 2 files changed, 313 insertions(+), 263 deletions(-)

--=20
Regards,

Laurent Pinchart

