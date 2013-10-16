From: Thierry Reding <thierry.reding@gmail.com>
Date: Wed, 16 Oct 2013 18:25:10 +0000
Subject: [RFR 0/2] DRM display panel support
Message-Id: <1381947912-11741-1-git-send-email-treding@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi everyone,

This mini series adds panel support for the DRM subsystem and a sample
implementation for three panels found on hardware that I have access to.

Stephen wanted be to get an OK from both device tree binding maintainers
and people involved with CDF before merging the related DTS patches into
the Tegra tree. This comes awfully late, for which I take all the blame,
because Stephen needs to include the patches in his arm-soc pull request
that he will send out on Thursday (US time).

In a nutshell the important bits that Stephen needs acknowledged are the
device tree bindings, because that needs to remain stable once merged. I
should mention that these patches have been acked by Dave Airlie for
inclusion in DRM, so besides the device tree bindings there's nothing
holding this up from getting merged.

From the CDF folks it'd be good to know if they consider these bindings
compatible with what they're working on. Note that these are simple
panels with no need for an explicit control channel or anything like
that. I'm fully aware that this doesn't cover all the use-cases that CDF
is designed to cover, but I don't think it needs to. It gives us an easy
and simple solution for all the trivial setups out there.

Stephen, have I summarized your concerns correctly in the above? If not
please correct me.

Thanks,
Thierry

Thierry Reding (2):
  drm: Add panel support
  drm/panel: Add simple panel support

 .../devicetree/bindings/panel/auo,b101aw03.txt     |   7 +
 .../bindings/panel/chunghwa,claa101wb03.txt        |   7 +
 .../bindings/panel/panasonic,vvx10f004b00.txt      |   7 +
 .../devicetree/bindings/panel/simple-panel.txt     |  21 ++
 drivers/gpu/drm/Kconfig                            |   2 +
 drivers/gpu/drm/Makefile                           |   2 +
 drivers/gpu/drm/drm_panel.c                        |  96 ++++++
 drivers/gpu/drm/panel/Kconfig                      |  17 ++
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-simple.c               | 335 +++++++++++++++++++++
 include/drm/drm_panel.h                            |  78 +++++
 11 files changed, 573 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/panel/auo,b101aw03.txt
 create mode 100644 Documentation/devicetree/bindings/panel/chunghwa,claa101wb03.txt
 create mode 100644 Documentation/devicetree/bindings/panel/panasonic,vvx10f004b00.txt
 create mode 100644 Documentation/devicetree/bindings/panel/simple-panel.txt
 create mode 100644 drivers/gpu/drm/drm_panel.c
 create mode 100644 drivers/gpu/drm/panel/Kconfig
 create mode 100644 drivers/gpu/drm/panel/Makefile
 create mode 100644 drivers/gpu/drm/panel/panel-simple.c
 create mode 100644 include/drm/drm_panel.h

-- 
1.8.4

