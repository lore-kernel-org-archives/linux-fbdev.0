From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 09 Aug 2019 14:07:35 +0000
Subject: [GIT PULL] fbdev fix for v5.3-rc4
Message-Id: <22bfe177-272e-afe8-31d1-75bc0cf852c7@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190809140736eucas1p2b14d3205aa7268cd1a6bba15ebd81066@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org


Hi Linus,

Please pull fbdev fix for v5.3-rc4 (fbdev patches will now go to
upstream through drm-misc tree for improved maintainership and
better integration testing so update MAINTAINERS file accordingly).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


The following changes since commit e21a712a9685488f5ce80495b37b9fdbe96c230d:

  Linux 5.3-rc3 (2019-08-04 18:40:12 -0700)

are available in the git repository at:

  https://github.com/bzolnier/linux.git tags/fbdev-v5.3-rc4

for you to fetch changes up to 6a7553e8d84d5322d883cb83bb9888c49a0f04e0:

  MAINTAINERS: handle fbdev changes through drm-misc tree (2019-08-09 15:46:40 +0200)

----------------------------------------------------------------
fbdev fix for v5.3-rc4:

- update fbdev git tree in MAINTAINERS file

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (1):
      MAINTAINERS: handle fbdev changes through drm-misc tree

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
