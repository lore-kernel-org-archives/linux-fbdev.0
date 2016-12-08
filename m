From: Steve Longerbeam <slongerbeam@gmail.com>
Date: Thu, 08 Dec 2016 00:57:41 +0000
Subject: [PATCH 00/12] i.MX media devices and connections
Message-Id: <1481158673-15937-1-git-send-email-steve_longerbeam@mentor.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, tomi.valkeinen@ti.com, p.zabel@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Steve Longerbeam <steve_longerbeam@mentor.com>

Hi Philipp, Sascha, Shawn, et al,

I've been working for the past few months on a media driver for i.MX.
In addition to the media entities for the IPU-external units involved
with video capture (video mux and MIPI CSI-2 receiver), I've created
media entities for the IPU CSI, SMFC, and IC subunits. The IC entities
carry out scaling, CSC, horizontal/vertical flip, and rotation. In
addition, the IC-PRPVF entity carries out motion compensated
de-interlace.

The following series adds the OF device nodes and graphs that define
all the possible hardware connections supported by the i.MX involved
in video capture and image conversion.

Here are some of the pipelines defined by the OF graphs:

CSI -> IC-PRPENC
CSI -> IC-PRPVF
CSI -> IC-PRPVF -> IC-PP
CSI -> SMFC
CSI -> SMFC -> IC-PRPVF
CSI -> SMFC -> IC-PP
CSI -> SMFC -> IC-PRPVF -> IC-PP

You will notice that three IC-PP nodes are defined (ipu1_ic_pp0,
ipu1_ic_pp1, ipu1_ic_pp2, and same for ipu2). The reason for that
is that the IC-PP media entity uses the new ipu-image-conversion
API, which allows for multiple conversion contexts to be created.
Each IC-PP entity thus creates its own conversion context, and there
can be any number of IC-PP entities instantiated as needed by the OF
graph.

Camera sensor nodes are also added for the SabreAuto, SabreSD, and
SabreLite reference platforms.

The media driver is now in fairly good shape. It parses the OF graphs
to create the media pads and links. All the pipelines defined by the
OF graphs have been tested and are working. My media driver work is
at:

git@github.com:slongerbeam/mediatree.git, branch imx-media-staging-md-v2.

For an overview of the pipelines supported and usage notes for the
reference boards, you can refer to Documentation/media/v4l-drivers/imx.rst.

I realize there is collision here with the recent patch series posted by
Philipp, particularly around the video multiplexer and mipi csi-2 receiver
subdevs and OF graphs, as well as v4l2 capture drivers.



Philipp Zabel (1):
  ARM: dts: imx6qdl: add video capture devices and connections

Steve Longerbeam (11):
  ARM: dts: imx6qdl: Add compatible, clocks, irqs to MIPI CSI-2 node
  ARM: dts: imx6qdl: rename ipu client nodes
  ARM: dts: imx6-sabrelite: add OV5642 and OV5640 camera sensors
  ARM: dts: imx6-sabresd: add OV5642 and OV5640 camera sensors
  ARM: dts: imx6-sabreauto: create i2cmux for i2c3
  ARM: dts: imx6-sabreauto: add reset-gpios property for max7310_b
  ARM: dts: imx6-sabreauto: add pinctrl for gpt input capture
  ARM: dts: imx6-sabreauto: add the ADV7180 video decoder
  gpu: ipu-v3: Add ipu_unit_type enumeration
  gpu: ipu-v3: lookup ipu client nodes by name
  gpu: ipu-v3: Add smfc and ic client devices

 arch/arm/boot/dts/imx6dl-sabrelite.dts   |   5 +
 arch/arm/boot/dts/imx6dl-sabresd.dts     |   5 +
 arch/arm/boot/dts/imx6dl.dtsi            | 190 ++++++++++++
 arch/arm/boot/dts/imx6q-sabrelite.dts    |   6 +
 arch/arm/boot/dts/imx6q-sabresd.dts      |   5 +
 arch/arm/boot/dts/imx6q.dtsi             | 497 ++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 148 +++++++--
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 122 +++++++-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi   | 114 ++++++-
 arch/arm/boot/dts/imx6qdl.dtsi           | 385 +++++++++++++++++++++++-
 drivers/gpu/ipu-v3/ipu-common.c          | 142 ++++++++-
 include/video/imx-ipu-v3.h               |  21 ++
 12 files changed, 1593 insertions(+), 47 deletions(-)

-- 
2.7.4

