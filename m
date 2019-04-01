From: Brian Masney <masneyb@onstation.org>
Date: Mon, 01 Apr 2019 10:30:31 +0000
Subject: [PATCH v2 0/3] backlight: lm3630a: bug fix and device tree support
Message-Id: <20190401103034.21062-1-masneyb@onstation.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, robh+dt@kernel.org
Cc: jacek.anaszewski@gmail.com, pavel@ucw.cz, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dmurphy@ti.com, jonathan@marek.ca

Here is a patch series that fixes a single bug and adds device tree
support to the lm3630a driver. This work was tested on a LG Nexus 5
(hammerhead) phone. My status page at
https://masneyb.github.io/nexus-5-upstream/ describes what is working
so far with the upstream kernel.

Changes since v1 (from November):
- Don't use a trivial binding and expose some of the settings available
  in the platform data.

Sorry for the long delay sending out v2. I got busy with other projects.

Brian Masney (3):
  backlight: lm3630a: return 0 on success in update_status functions
  dt-bindings: backlight: add lm3630a bindings
  backlight: lm3630a: add device tree supprt

 .../leds/backlight/lm3630a-backlight.yaml     | 112 ++++++++++++++++++
 drivers/video/backlight/lm3630a_bl.c          |  73 +++++++++++-
 2 files changed, 183 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml

-- 
2.20.1
