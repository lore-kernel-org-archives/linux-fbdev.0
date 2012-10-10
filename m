From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Date: Wed, 10 Oct 2012 18:37:44 +0000
Subject: [PATCH 3.6.0- 00/13] VIDEO: use module_platform_driver macro
Message-Id: <1349894264-9183-1-git-send-email-srinivas.kandagatla@st.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

Running below Coccinelle lookup pattern like below on the 
latest kernel showed about 52 hits. This patch series is a subset 
of those 52 patches, so that it will be easy for maintainers to review.
Hopefully these patches will get rid of some code duplication in kernel.

@  @
- initfunc(void)
- { return platform_driver_register(&dr); }

...

- module_init(initfunc);
...

- exitfunc(void)
- { platform_driver_unregister(&dr); }

...

- module_exit(exitfunc);
+ module_platform_driver(dr); 


Srinivas Kandagatla (13):
  video/au1100fb: use module_platform_driver macro
  video/au1200fb: use module_platform_driver macro
  video/bf54x-lq043fb: use module_platform_driver macro
  video/bfin-lq035q1: use module_platform_driver macro
  video/bfin-t350mcqb: use module_platform_driver macro
  video/broadsheetfb: use module_platform_driver macro
  video/cobalt_lcdfb: use module_platform_driver macro
  video/da8xx_fb: use module_platform_driver macro
  video/ep93xx_fb: use module_platform_driver macro
  video/grvga: use module_platform_driver macro
  video/hecubafb: use module_platform_driver macro
  video/jz4740_fb: use module_platform_driver macro
  video/metronomefb: use module_platform_driver macro

 drivers/video/au1100fb.c         |   14 +-------------
 drivers/video/au1200fb.c         |   16 +---------------
 drivers/video/bf54x-lq043fb.c    |   14 +-------------
 drivers/video/bfin-lq035q1-fb.c  |   13 +------------
 drivers/video/bfin-t350mcqb-fb.c |   14 +-------------
 drivers/video/broadsheetfb.c     |   14 +-------------
 drivers/video/cobalt_lcdfb.c     |   14 +-------------
 drivers/video/da8xx-fb.c         |   14 +-------------
 drivers/video/ep93xx-fb.c        |   14 +-------------
 drivers/video/grvga.c            |   15 +--------------
 drivers/video/hecubafb.c         |   14 +-------------
 drivers/video/jz4740_fb.c        |   13 +------------
 drivers/video/metronomefb.c      |   14 +-------------
 13 files changed, 13 insertions(+), 170 deletions(-)

