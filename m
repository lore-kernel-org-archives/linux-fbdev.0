From: Brian Masney <masneyb@onstation.org>
Date: Wed, 24 Apr 2019 09:25:02 +0000
Subject: [PATCH v6 0/3] backlight: lm3630a: bug fix and fwnode support
Message-Id: <20190424092505.6578-1-masneyb@onstation.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, robh+dt@kernel.org
Cc: jacek.anaszewski@gmail.com, pavel@ucw.cz, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dmurphy@ti.com, jonathan@marek.ca

Here is a patch series that fixes a single bug and adds fwnode support
to the lm3630a driver. This work was tested on a LG Nexus 5 (hammerhead)
phone. My status page at https://masneyb.github.io/nexus-5-upstream/
describes what is working so far with the upstream kernel.

See the individual patches for the changelog.

Brian Masney (3):
  backlight: lm3630a: return 0 on success in update_status functions
  dt-bindings: backlight: add lm3630a bindings
  backlight: lm3630a: add firmware node support

 .../leds/backlight/lm3630a-backlight.yaml     | 129 +++++++++++++++
 drivers/video/backlight/lm3630a_bl.c          | 153 +++++++++++++++++-
 include/linux/platform_data/lm3630a_bl.h      |   4 +
 3 files changed, 279 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml

-- 
2.20.1
