From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Thu, 25 Jul 2013 13:05:10 +0000
Subject: [PATCHv2 0/3] Few ignored framebuffer fixes/additions
Message-Id: <1374757513-2253-1-git-send-email-maxime.ripard@free-electrons.com>
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
patches though.

Thanks,
Maxime

Changes from v1:
  - Fix line wrapping in patch 2
  - Added some comments on the msleep in patch 3

Alexandre Belloni (1):
  fb: backlight: HX8357: Add HX8369 support

Hector Palacios (1):
  video: mxsfb: fix color settings for 18bit data bus and 32bpp

Maxime Ripard (1):
  video: hx8357: Make IM pins optional

 drivers/video/backlight/hx8357.c | 272 +++++++++++++++++++++++++++++++++------
 drivers/video/mxsfb.c            |  26 ----
 2 files changed, 236 insertions(+), 62 deletions(-)

-- 
1.8.3.2

