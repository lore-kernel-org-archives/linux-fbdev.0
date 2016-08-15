From: Vladimir Murzin <vladimir.murzin@arm.com>
Date: Mon, 15 Aug 2016 10:10:29 +0000
Subject: [RESEND PATCH 0/3] fbdev: vfb: make VirtualFB more flexible
Message-Id: <1471255832-44793-1-git-send-email-vladimir.murzin@arm.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

This short patch series is supposed to add some flexibility to the VFB
which should help with testing in display-less environment.

Thanks!

Vladimir Murzin (3):
  fbdev: vfb: add description to module parameters
  fbdev: vfb: add option for video mode
  fbdev: vfb: simplify memory management

 drivers/video/fbdev/vfb.c |  129 ++++++++++-----------------------------------
 1 file changed, 27 insertions(+), 102 deletions(-)

-- 
1.7.9.5

