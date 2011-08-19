From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 19 Aug 2011 09:16:05 +0000
Subject: [PATCH 0/7] sh_mobile_lcdc: Support format changes at runtime
Message-Id: <1313745372-20856-1-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi everybody,

This patch set add supports for the .fb_set_par() operation in the
sh_mobile_lcdc driver, allowing userspace to change the frame buffer format
and size at runtime. It applies on top of the latest SH mobile LCDC cleanups
and fixes patches posted to the linux-fbdev list and available at
http://git.linuxtv.org/pinchartl/fbdev.git/shortlog/refs/heads/sh-mobile-lc=
dc.

Frame buffer memory reallocation is currently not supported. You will need =
to
make sure platform data sets the maximum size and bpp to high enough values
for all formats and sizes you want to support at runtime.

The patches have been tested with the fbdev-test utility
(http://git.ideasonboard.org/?p=FBdev-test.git;a=3Dsummary) on a Mackerel b=
oard.

Laurent Pinchart (7):
  fbdev: sh_mobile_lcdc: Adjust requested parameters in .fb_check_var
  fbdev: sh_mobile_lcdc: Add support for format changes at runtime
  fbdev: sh_mobile_lcdc: use display information in info for panning
  fbdev: sh_mobile_lcdc: Update fix.line_length in .fb_set_par()
  fbdev: sh_mobile_lcdc: Avoid forward declarations
  fbdev: sh_mobile_lcdc: Split channel initialization from probe function
  fbdev: sh_mobile_lcdc: Remove sh_mobile_lcdc_set_bpp()

 drivers/video/sh_mobile_lcdcfb.c |  570 +++++++++++++++++++++-------------=
----
 1 files changed, 309 insertions(+), 261 deletions(-)

--=20
Regards,

Laurent Pinchart

