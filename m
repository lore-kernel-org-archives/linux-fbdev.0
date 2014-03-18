From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 18 Mar 2014 08:15:39 +0000
Subject: [PATCHv2 0/8] Doc/DT: DT bindings for various display components
Message-Id: <1395130547-18633-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Daniel Vetter <daniel@ffwll.ch>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Sascha Hauer <s.hauer@pengutronix.de>, Tomasz Figa <tomasz.figa@gmail.com>, Archit Taneja <archit@ti.com>, Inki Dae <inki.dae@samsung.com>, Andrzej Hajda <a.hajda@samsung.com>, Rob Clark <robdclark@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Philipp Zabel <p.zabel@pengutronix.de>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Hi,

This is v2 of the series adding DT bindings for various display components. The
v1 can be found from [1].

The changes for v2:

* abbreviated endpoint format dropped (nacked)
* MIPI DPI panel dropped (missing backlight handling, delayed to 3.16)
* dvi-connector: add properties for analog/digital/dual-link
* hdmi-connector: add connector type
* split 'gpios' property to named gpios
* use 'clocks' properties for OMAP DSS components
* removed 'simple-bus' from OMAP DSS Core's compatible strings

[1] http://article.gmane.org/gmane.linux.drivers.devicetree/63885

 Tomi

Tomi Valkeinen (8):
  Doc/DT: Add DT binding documentation for OMAP DSS
  Doc/DT: Add DT binding documentation for Analog TV Connector
  Doc/DT: Add DT binding documentation for DVI Connector
  Doc/DT: Add DT binding documentation for HDMI Connector
  Doc/DT: Add DT binding documentation for MIPI DSI CM Panel
  Doc/DT: Add DT binding documentation for Sony acx565akm panel
  Doc/DT: Add DT binding documentation for TFP410 encoder
  Doc/DT: Add DT binding documentation for tpd12s015 encoder

 .../bindings/video/analog-tv-connector.txt         |  25 +++
 .../devicetree/bindings/video/dvi-connector.txt    |  35 ++++
 .../devicetree/bindings/video/hdmi-connector.txt   |  28 +++
 .../devicetree/bindings/video/panel-dsi-cm.txt     |  29 +++
 .../devicetree/bindings/video/sony,acx565akm.txt   |  30 +++
 .../devicetree/bindings/video/ti,omap-dss.txt      | 211 +++++++++++++++++++++
 .../devicetree/bindings/video/ti,omap2-dss.txt     |  54 ++++++
 .../devicetree/bindings/video/ti,omap3-dss.txt     |  83 ++++++++
 .../devicetree/bindings/video/ti,omap4-dss.txt     | 111 +++++++++++
 .../devicetree/bindings/video/ti,tfp410.txt        |  41 ++++
 .../devicetree/bindings/video/ti,tpd12s015.txt     |  44 +++++
 11 files changed, 691 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/analog-tv-connector.txt
 create mode 100644 Documentation/devicetree/bindings/video/dvi-connector.txt
 create mode 100644 Documentation/devicetree/bindings/video/hdmi-connector.txt
 create mode 100644 Documentation/devicetree/bindings/video/panel-dsi-cm.txt
 create mode 100644 Documentation/devicetree/bindings/video/sony,acx565akm.txt
 create mode 100644 Documentation/devicetree/bindings/video/ti,omap-dss.txt
 create mode 100644 Documentation/devicetree/bindings/video/ti,omap2-dss.txt
 create mode 100644 Documentation/devicetree/bindings/video/ti,omap3-dss.txt
 create mode 100644 Documentation/devicetree/bindings/video/ti,omap4-dss.txt
 create mode 100644 Documentation/devicetree/bindings/video/ti,tfp410.txt
 create mode 100644 Documentation/devicetree/bindings/video/ti,tpd12s015.txt

-- 
1.8.3.2

