From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 19 Feb 2013 02:51:17 +0000
Subject: [GIT PULL] samsung-fb updates for v3.9
Message-Id: <003901ce0e4b$fd839c40$f88ad4c0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Linus Torvalds' <torvalds@linux-foundation.org>
Cc: 'linux-fbdev' <linux-fbdev@vger.kernel.org>, 'linux-kernel' <linux-kernel@vger.kernel.org>, 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>, 'Andrew Morton' <akpm@linux-foundation.org>, 'Jingoo Han' <jg1.han@samsung.com>

Hi Linus,

Florian, the fbdev maintainer, has been very busy lately, so I send the pull request
for samsung-fb for this merge window.

The following changes since commit 19f949f52599ba7c3f67a5897ac6be14bfcb1200:

 Linux 3.8 (Mon Feb 18 15:58:34 2013 -0800)

are available in the git repository at:
  git://github.com/jingoo/linux.git samsung-fb-next

for you to fetch changes up to 5a415ae252d5922de9eadefabe8510115395fbc6:

 video: s3c-fb: Fix typo in definition of VIDCON1_VSTATUS_FRONTPORCH value (Sat Nov 17 21:31:00 2012 +0000)

----------------------------------------------------------------
samsung-fb updates for the v3.9:

- The bit definitions of header file are updated.
- The dependancy is fixed.
----------------------------------------------------------------

Jingoo Han (4):
      video: s3c-fb: use ARCH_ dependancy
      video: s3c-fb: remove duplicated S3C_FB_MAX_WIN
      video: s3c-fb: remove unnecessary brackets
      video: s3c-fb: add the bit definitions for CSC EQ709 and EQ601

Tomasz Figa (1):
      video: s3c-fb: Fix typo in definition of VIDCON1_VSTATUS_FRONTPORCH value

 drivers/video/Kconfig        |    3 +-
 include/video/samsung_fimd.h |  205 ++++++++++++++++++++---------------------
 2 files changed, 102 insertions(+), 106 deletions(-)

--
Best regards,
Jingoo Han

