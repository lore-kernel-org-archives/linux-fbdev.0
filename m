From: Steve Glendinning <steve.glendinning@smsc.com>
Date: Thu, 18 Aug 2011 14:20:06 +0000
Subject: [PATCH v2] Add support for SMSC UFX6000/7000 USB display adapters
Message-Id: <1313677207-28681-1-git-send-email-steve.glendinning@smsc.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Updated following feedback from Greg K-H and Florian Schandinat.

I haven't made the changes to fb.h in this patch, so it still uses
the same hardcoded ioctl as udlfb.  The patch that adds this could
also update both udlfb and smscufx to use it.


Steve Glendinning (1):
  Add support for SMSC UFX6000/7000 USB display adapters

 MAINTAINERS             |    6 +
 drivers/video/Kconfig   |   16 +
 drivers/video/Makefile  |    1 +
 drivers/video/smscufx.c | 1994 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 2017 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/smscufx.c

-- 
1.7.4.1

