From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 13 Feb 2014 12:32:23 +0000
Subject: [PATCH 0/9] OMAP DSS DT bindings documentation
Message-Id: <1392294752-18762-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>

Hi,

Here is DT binding documentation for OMAP Display Subsystem. I've sent these
earlier as part of the whole DSS DT series, but I'm now sending them separately
to get comments for them.

These patches are essentially the same as what I already sent earlier. The only
difference is that I added clock information for omap3 and omap4 platforms.

 Tomi

Tomi Valkeinen (9):
  Doc/DT: Add OMAP DSS DT Bindings
  Doc/DT: Add DT binding documentation for Analog TV Connector
  Doc/DT: Add DT binding documentation for DVI Connector
  Doc/DT: Add DT binding documentation for HDMI Connector
  Doc/DT: Add DT binding documentation for MIPI DPI Panel
  Doc/DT: Add DT binding documentation for MIPI DSI CM Panel
  Doc/DT: Add DT binding documentation for Sony acx565akm panel
  Doc/DT: Add DT binding documentation for TFP410 encoder
  Doc/DT: Add DT binding documentation for tpd12s015 encoder

 .../bindings/video/analog-tv-connector.txt         |  23 +++
 .../devicetree/bindings/video/dvi-connector.txt    |  26 +++
 .../devicetree/bindings/video/hdmi-connector.txt   |  23 +++
 .../devicetree/bindings/video/panel-dpi.txt        |  43 +++++
 .../devicetree/bindings/video/panel-dsi-cm.txt     |  26 +++
 .../devicetree/bindings/video/sony,acx565akm.txt   |  28 +++
 .../devicetree/bindings/video/ti,omap-dss.txt      | 203 +++++++++++++++++++++
 .../devicetree/bindings/video/ti,omap2-dss.txt     |  54 ++++++
 .../devicetree/bindings/video/ti,omap3-dss.txt     |  83 +++++++++
 .../devicetree/bindings/video/ti,omap4-dss.txt     | 111 +++++++++++
 .../devicetree/bindings/video/ti,tfp410.txt        |  41 +++++
 .../devicetree/bindings/video/ti,tpd12s015.txt     |  44 +++++
 .../devicetree/bindings/video/video-ports.txt      |  22 +++
 13 files changed, 727 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/analog-tv-connector.txt
 create mode 100644 Documentation/devicetree/bindings/video/dvi-connector.txt
 create mode 100644 Documentation/devicetree/bindings/video/hdmi-connector.txt
 create mode 100644 Documentation/devicetree/bindings/video/panel-dpi.txt
 create mode 100644 Documentation/devicetree/bindings/video/panel-dsi-cm.txt
 create mode 100644 Documentation/devicetree/bindings/video/sony,acx565akm.txt
 create mode 100644 Documentation/devicetree/bindings/video/ti,omap-dss.txt
 create mode 100644 Documentation/devicetree/bindings/video/ti,omap2-dss.txt
 create mode 100644 Documentation/devicetree/bindings/video/ti,omap3-dss.txt
 create mode 100644 Documentation/devicetree/bindings/video/ti,omap4-dss.txt
 create mode 100644 Documentation/devicetree/bindings/video/ti,tfp410.txt
 create mode 100644 Documentation/devicetree/bindings/video/ti,tpd12s015.txt
 create mode 100644 Documentation/devicetree/bindings/video/video-ports.txt

-- 
1.8.3.2

