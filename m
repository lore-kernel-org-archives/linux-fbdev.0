From: Sebastian Reichel <sre@debian.org>
Date: Fri, 13 Dec 2013 18:17:26 +0000
Subject: [PATCH 0/4] OMAPDSS: DT support for N900 panel
Message-Id: <1386958650-2404-1-git-send-email-sre@debian.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sebastian Reichel <sre@ring0.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Sebastian Reichel <sre@debian.org>

Hi,

This patchset adds DT support for the N900 panel. The patchset is based on
Tomi's work/dss-dt-2 branch [0]. I suggest to send the DT changes through
Benoits queue, since I have more N900 DT changes for 3.14. Also the patch
editing the rx51 boardcode can be dropped, since the file is removed in 3.14.
I included those two with this patchset, since they are needed to test the
other two patches.

I did not include a documentation for the DT API, since the omapdss
documentation is still missing.

I have successfully tested this on the N900.

[0] https://git.kernel.org/cgit/linux/kernel/git/tomba/linux.git/log/?h=work/dss-dt-2

-- Sebastian

Sebastian Reichel (4):
  OMAPDSS: Add DT support to SDI
  OMAPDSS: ACX565AKM: Add DT support
  ARM: OMAP: rx51: DT boot: disable legacy dss init
  ARM: dts: omap3-n900: Add display support

 arch/arm/boot/dts/omap3-n900.dts                   | 18 ++++++++++-
 arch/arm/mach-omap2/board-rx51-video.c             |  2 +-
 .../omap2/displays-new/panel-sony-acx565akm.c      | 35 +++++++++++++++++++++-
 drivers/video/omap2/dss/sdi.c                      | 20 +++++++++++++
 4 files changed, 72 insertions(+), 3 deletions(-)

-- 
1.8.5.1

