From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 19 Feb 2013 02:57:31 +0000
Subject: [GIT PULL] exynos-dp updates for v3.9
Message-Id: <003a01ce0e4c$dc0f80f0$942e82d0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Linus Torvalds' <torvalds@linux-foundation.org>
Cc: 'linux-fbdev' <linux-fbdev@vger.kernel.org>, 'linux-kernel' <linux-kernel@vger.kernel.org>, 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>, 'Andrew Morton' <akpm@linux-foundation.org>, 'Jingoo Han' <jg1.han@samsung.com>

Hi Linus,

Florian, the fbdev maintainer, has been very busy lately, so I send the pull request
for exynos-dp for this merge window.

The following changes since commit 19f949f52599ba7c3f67a5897ac6be14bfcb1200:

 Linux 3.8 (Mon Feb 18 15:58:34 2013 -0800)

are available in the git repository at:
  git://github.com/jingoo/linux.git exynos-dp-next

for you to fetch changes up to bb80934325dab97b479815aed237ebec33ed1c57:

 video: exynos_dp: move disable_irq() to exynos_dp_suspend() (Tue Jan 29 18:26:05 2013 +0900)

----------------------------------------------------------------
exynos-dp updates for the v3.9:

- The missing function calls are fixed.
----------------------------------------------------------------

Ajay Kumar (1):
      video: exynos_dp: move disable_irq() to exynos_dp_suspend()

Jingoo Han (1):
      video: exynos_dp: add missing of_node_put()

drivers/video/exynos/exynos_dp_core.c |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)

--
Best regards,
Jingoo Han

