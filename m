From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 11 Mar 2016 02:28:16 +0000
Subject: [PATCH 0/2] fbdev: sh_mobile_meram: use ARCH_RENESAS
Message-Id: <1457663298-31973-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Use ARCH_RENESAS in place of ARCH_SHMOBILE.

This is part of an ongoing process to migrate from ARCH_SHMOBILE to
ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.

As a follow-up also depend on COMPILE_TEST to provided for increased
compile testing.

Based on v4.5-rc1

Simon Horman (2):
  fbdev: sh_mobile_meram: use ARCH_RENESAS
  fbdev: sh_mobile_meram: depend on COMPILE_TEST

 drivers/video/fbdev/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.7.0.rc3.207.g0ac5344

