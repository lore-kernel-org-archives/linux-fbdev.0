From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 28 Feb 2014 12:20:07 +0000
Subject: [PATCH 0/9] Doc/DT: DT bindings for various display components
Message-Id: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>

Hi,

This series is a re-send of
http://article.gmane.org/gmane.linux.drivers.devicetree/61739

I'm cc'ing more people, and I want to clarify the contents of the series:

While this has been developed for OMAP, only the first patch is about OMAP
bindings. The rest are generic bindings for video components, which can be used
on any platform.

The bindings use the V4L2 style video port/endpoint system, described in
Documentation/devicetree/bindings/media/video-interfaces.txt, to connect the
components. The same port/endpoint bindings are used by Philipp Zabel in his
imx-drm patch series.

Shortly about the display components in the series, in the order of probable
public interest:

* Analog TV, DVI and HDMI Connectors represent a respective connector on the
  board. They don't do much, but they do mark the end of the video pipeline (from
  the board's pov), and they should also in the future offer ways to handle
  things like the +5V pin on DVI and HDMI connector and HPD pin.
  
* MIPI DPI panel and MIPI DSI CM panels represent bindings for simple panels
  using the respective video bus.
  
* Sony acx565akm is an SPI controlled panel using flatlink video bus.
  
* TFP410 is a DPI to DVI encoder.
  
* TPD12S015 is a HDMI companion chip, used on OMAP boards.

These patches, on top of the OMAP DSS DT work, can be found from:

git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git work/dss-dt

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

