From: Ajay Kumar <ajaykumar.rs@samsung.com>
Date: Tue, 20 Sep 2011 09:28:54 +0000
Subject: [PATCH 0/3] FB: Add window positioning support
Message-Id: <1316532641-2657-1-git-send-email-ajaykumar.rs@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patchset adds support for positioning the overlay windows on the LCD.

These patches are based on the discussion about adding features to fbdev at:
http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg06292.html

To Florian:
  	include: fb: Add definiton for window positioning structure
  	video: s3c-fb: Modify s3c-fb driver to support window positioning

To Kukjin,
  	ARM: SAMSUNG: Embed window positioning data structure in s3c-fb plat
  		      data

 arch/arm/plat-samsung/include/plat/fb.h |    3 ++
 drivers/video/s3c-fb.c                  |   37 ++++++++++++++++++++++++++----
 include/linux/fb.h                      |    7 ++++++
 3 files changed, 42 insertions(+), 5 deletions(-)

