From: Roger Quadros <roger.quadros@nokia.com>
Date: Wed, 17 Mar 2010 12:35:18 +0000
Subject: [PATCHv2 0/3] OMAP: DSS2: Allow us to use SDI
Message-Id: <1268829321-29769-1-git-send-email-roger.quadros@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi.Valkeinen@nokia.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

SDI now makes use of vdds_sdi regulator supply.
DPI can now be disabled on systems that don't have it

changes since v1:
- Incorporated review comments
- no more omap3xx checks for regulator enable/disable in SDI
- Added Kconfig option to enable/disable DPI

Roger Quadros (3):
  OMAP: DSS2: Add Kconfig option for DPI display type
  OMAP: DSS2: Remove redundant enable/disable calls from SDI
  OMAP: DSS2: Use vdds_sdi regulator supply in SDI

 drivers/video/omap2/dss/Kconfig   |    6 ++++++
 drivers/video/omap2/dss/Makefile  |    3 ++-
 drivers/video/omap2/dss/core.c    |    4 ++++
 drivers/video/omap2/dss/display.c |    4 ++++
 drivers/video/omap2/dss/sdi.c     |   26 +++++++++++++++-----------
 5 files changed, 31 insertions(+), 12 deletions(-)

