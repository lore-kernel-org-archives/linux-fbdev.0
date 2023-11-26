Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EBF17E4
	for <linux-fbdev@vger.kernel.org>; Sun, 26 Nov 2023 06:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAD6C433C8;
	Sun, 26 Nov 2023 06:58:10 +0000 (UTC)
Date: Sun, 26 Nov 2023 07:58:08 +0100
From: Helge Deller <deller@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev fixes and updates for v6.7-rc3
Message-ID: <ZWLsgGku7j_7_eVE@ls3530>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

please pull some small fbdev fixes for 6.7-rc3.

A left margin fix and code cleanups in imxfb, and one 
sparse warning fix in fsl-diu-fb.

Thanks,
Helge

---

The following changes since commit ffc253263a1375a65fa6c9f62a893e9767fbebfa:

  Linux 6.6 (2023-10-29 16:31:08 -1000)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.7-rc3

for you to fetch changes up to 64a1aed0aa07698d12deca9b7821ea77762ff328:

  fbdev: mmp: Fix typo and wording in code comment (2023-11-25 09:54:41 +0100)

----------------------------------------------------------------
fbdev fixes and cleanups for 6.7-rc3:

- fix left margin settings in imxfb
- sparse warning fix in fsl-diu-fb
- lots of code cleanups in imxfb

----------------------------------------------------------------
Dario Binacchi (11):
      fbdev: imxfb: fix left margin setting
      fbdev: imxfb: move PCR bitfields near their offset
      fbdev: imxfb: use BIT, FIELD_{GET,PREP} and GENMASK macros
      fbdev: imxfb: replace some magic numbers with constants
      fbdev: imxfb: add missing SPDX tag
      fbdev: imxfb: drop ftrace-like logging
      fbdev: imxfb: add missing spaces after ','
      fbdev: imxfb: Fix style warnings relating to printk()
      fbdev: imxfb: use __func__ for function name
      fbdev: imxfb: add '*/' on a separate line in block comment
      fbdev: mmp: Fix typo and wording in code comment

Stanislav Kinsburskii (1):
      fbdev: fsl-diu-fb: Fix sparse warning due to virt_to_phys() prototype change

 drivers/video/fbdev/fsl-diu-fb.c     |   2 +-
 drivers/video/fbdev/imxfb.c          | 179 ++++++++++++++++++++---------------
 drivers/video/fbdev/mmp/hw/mmp_spi.c |   2 +-
 3 files changed, 104 insertions(+), 79 deletions(-)
