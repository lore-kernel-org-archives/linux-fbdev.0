From: Roger Quadros <roger.quadros@nokia.com>
Date: Fri, 12 Mar 2010 15:37:52 +0000
Subject: [RFC][PATCH 0/3] OMAP: DSS2: Allow us to use SDI
Message-Id: <1268408275-31633-1-git-send-email-roger.quadros@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

I want to get DSS2 working on N900. N900 requires SDI.

Technically we should be able to use SDI without having DSI
regulators enabled.
Thes patches also add the vdds_sdi supply support to SDI.

NOTE: I cannot yet confirm that SDI was working or will work with this.

---
Roger Quadros (3):
  OMAP: DSS2: Do regulator stuff in dpi_init_display()
  OMAP: DSS2: Prevent recursive Panel Enable/Disable calls from SDI
  OMAP: DSS2: Use vdds_sdi regulator supply in SDI

 drivers/video/omap2/dss/dpi.c |   10 +++++-----
 drivers/video/omap2/dss/sdi.c |   32 +++++++++++++++++++++-----------
 2 files changed, 26 insertions(+), 16 deletions(-)

