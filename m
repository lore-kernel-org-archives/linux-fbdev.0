From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Wed, 13 Feb 2013 10:40:23 +0000
Subject: [PATCH 0/5] Cleanups and fixes for the Himax HX8357
Message-Id: <1360752028-7301-1-git-send-email-maxime.ripard@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

This patchset does minor cleanups and fixes as suggested in private by
Joe Perches to the HX8357 LCD driver.

Thanks,
Maxime

Maxime Ripard (5):
  fb: hx8357: Change parameters of the write function to u8
  fb: hx8357: Fix inverted parameters for kcalloc
  fb: hx8357: Remove useless error message
  fb: hx8357: Remove trailing period
  fb: hx8357: Use static arrays for LCD configuration

 drivers/video/backlight/hx8357.c |  187 ++++++++++++++++++++------------------
 1 file changed, 101 insertions(+), 86 deletions(-)

-- 
1.7.10.4

