From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Thu, 01 Aug 2013 08:40:34 +0000
Subject: [PATCHv3 0/3] Few ignored framebuffer fixes/additions
Message-Id: <1375346437-18991-1-git-send-email-maxime.ripard@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

This is the v2 of a set of patches that got forgotten.

These have been around for a while without any functionnal comments recently,
so I guess we should be pretty close to merge them.

It would be great if we could have comments from the maintainer on these
patches though (three patches iterations and 41 days since last sign of life of
the maintainer).

Thanks,
Maxime

Changes from v2:
  - Few minor coding style fixes
  - Removed the useless msleep(100) in the hx8369 init function

Changes from v1:
  - Fix line wrapping in patch 2
  - Added some comments on the msleep in patch 3


Alexandre Belloni (1):
  fb: backlight: HX8357: Add HX8369 support

Hector Palacios (1):
  video: mxsfb: fix color settings for 18bit data bus and 32bpp

Maxime Ripard (1):
  video: hx8357: Make IM pins optional

 drivers/video/backlight/hx8357.c | 269 ++++++++++++++++++++++++++++++++++-----
 drivers/video/mxsfb.c            |  26 ----
 2 files changed, 234 insertions(+), 61 deletions(-)

-- 
1.8.3.4

