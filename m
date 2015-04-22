From: Jyri Sarha <jsarha@ti.com>
Date: Wed, 22 Apr 2015 13:22:56 +0000
Subject: [PATCH 0/5] OMAPDSS: HDMI audio compliance fixes
Message-Id: <cover.1429705991.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, misael.lopez@ti.com, Jyri Sarha <jsarha@ti.com>

I have rebased these patches from ti-linux-3.14.y on top of Linux
4.0.0. I tested them briefly on OMAP4 and OMAP5 in my environment, but
I could not test any channel count beyond stereo. However, there were
no conflicts in the rebase and each fix makes sense when looking at
the chip TRM and the relevant HDMI specs.

All the changes are really minor, but most of them apply to OMAPDSS side,
so it is probably best to merge them trough there.

Best regards,
Jyri

Misael Lopez Cruz (5):
  OMAPDSS: HDMI4: Set correct CC for 8-channels layout
  OMAPDSS: HDMI5: Set valid sample order
  OMAPDSS: HDMI5: Fix AUDICONF3 bitfield offsets
  ASoC: omap-hdmi-audio: Force channel allocation only for OMAP4
  ASoC: omap-hdmi-audio: Fix invalid combination of DM_INH and CA

 drivers/video/fbdev/omap2/dss/hdmi4_core.c | 12 +++++++++++-
 drivers/video/fbdev/omap2/dss/hdmi5_core.c |  5 ++++-
 sound/soc/omap/omap-hdmi-audio.c           | 12 +++++++-----
 3 files changed, 22 insertions(+), 7 deletions(-)

-- 
1.9.1

