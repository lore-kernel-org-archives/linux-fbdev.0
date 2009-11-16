From: Jun Nie <niej0001@gmail.com>
Date: Mon, 16 Nov 2009 09:33:58 +0000
Subject: [PATCH 0/8] enable pxa168 LCD on two platform
Message-Id: <7c34ac520911160133i47cfe4ectdcf8004204b51b3e@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <7c34ac520911100011x60a354b0mf2e27e1c5fd0422@mail.gmail.com>
In-Reply-To: <7c34ac520911100011x60a354b0mf2e27e1c5fd0422@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This the v3 of the serial patches, it add LCD controller SPI support
and enable frame
buffer on two platform. Several small fix are included. Comments from
Russell and Eric are merged. Thank you!


 arch/arm/configs/pxa168_defconfig       |   86 ++++++++++++++-
 arch/arm/configs/pxa910_defconfig       |   39 +++++++-
 arch/arm/mach-mmp/aspenite.c            |  182 +++++++++++++++++++++++++++++++
 arch/arm/mach-mmp/include/mach/pxa168.h |    8 ++
 arch/arm/mach-mmp/include/mach/pxa910.h |    8 ++
 arch/arm/mach-mmp/pxa168.c              |    3 +
 arch/arm/mach-mmp/pxa910.c              |    4 +
 arch/arm/mach-mmp/ttc_dkb.c             |  144 ++++++++++++++++++++++++
 drivers/gpio/pca953x.c                  |    1 +
 drivers/video/pxa168fb.c                |  105 ++++++++++++++++++
 drivers/video/pxa168fb.h                |   24 +----
 include/video/pxa168fb.h                |   52 +++++++++-
 12 files changed, 628 insertions(+), 28 deletions(-)
