From: Heiko Schocher <hs@denx.de>
Date: Tue, 22 Mar 2011 08:27:26 +0000
Subject: [PATCH v6 0/6] powerpc, 52xx: add charon board support
Message-Id: <1300782452-528-1-git-send-email-hs@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1291451028-22532-1-git-send-email-hs@denx.de>
In-Reply-To: <1291451028-22532-1-git-send-email-hs-ynQEQJNshbs@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Vincent Sanders <vince-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>

cc: Wolfram Sang <w.sang@pengutronix.de>
cc: Grant Likely <grant.likely@secretlab.ca>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: linux-fbdev@vger.kernel.org
cc: devicetree-discuss@ozlabs.org
cc: Ben Dooks <ben@simtec.co.uk>
cc: Vincent Sanders <vince@simtec.co.uk>
cc: Samuel Ortiz <sameo@linux.intel.com>
cc: linux-kernel@vger.kernel.org
cc: Randy Dunlap <rdunlap@xenotime.net>
cc: Wolfgang Denk <wd@denx.de>
cc: Paul Mundt <lethal@linux-sh.org>

changes since v5:
- repost complete patchseries, as Paul Mundt suggested
- rebased against current head
- add Acked-by from Samuel Ortiz (MFD parts)
  http://www.spinics.net/lists/linux-fbdev/msg02550.html
  http://linux.derkeiler.com/Mailing-Lists/Kernel/2011-01/msg11798.html

  and Benjamin Herrenschmidt (DTS parts)
  http://lists.ozlabs.org/pipermail/linuxppc-dev/2011-February/088279.html
- removed patch 
  "powerpc, mpc5200: update mpc5200_defconfig to fit for charon board."
  therefore added
  "powerpc, tqm5200: update tqm5200_defconfig to fit for charon board."

  Paul: before adding this patchseries, this patch should get
        an Acked-by from a powerpc maintainer. 

checkpatch says:
total: 0 errors, 0 warnings, 233 lines checked

20110322/0001-powerpc-5200-add-support-for-charon-board.patch has no obvious style problems and is ready for submission.
total: 0 errors, 0 warnings, 841 lines checked

20110322/0002-video-sm501-add-I-O-functions-for-use-on-powerpc.patch has no obvious style problems and is ready for submission.
total: 0 errors, 0 warnings, 109 lines checked

20110322/0003-video-sm501-add-edid-and-commandline-support.patch has no obvious style problems and is ready for submission.
total: 0 errors, 0 warnings, 106 lines checked

20110322/0004-video-sm501-add-OF-binding-to-support-SM501.patch has no obvious style problems and is ready for submission.
total: 0 errors, 0 warnings, 22 lines checked

20110322/0005-powerpc-video-add-SM501-support-for-charon-board.patch has no obvious style problems and is ready for submission.
total: 0 errors, 0 warnings, 82 lines checked

20110322/0006-powerpc-tqm5200-update-tqm5200_defconfig-to-fit-for-.patch has no obvious style problems and is ready for submission.

Heiko Schocher (6):
  powerpc, 5200: add support for charon board
  video, sm501: add I/O functions for use on powerpc
  video, sm501: add edid and commandline support
  video, sm501: add OF binding to support SM501
  powerpc, video: add SM501 support for charon board.
  powerpc, tqm5200: update tqm5200_defconfig to fit for charon board.

 Documentation/fb/sm501.txt                   |   10 +
 Documentation/powerpc/dts-bindings/sm501.txt |   34 ++++
 arch/powerpc/boot/dts/charon.dts             |  236 ++++++++++++++++++++++
 arch/powerpc/configs/52xx/tqm5200_defconfig  |   20 ++-
 arch/powerpc/platforms/52xx/mpc5200_simple.c |    1 +
 drivers/mfd/sm501.c                          |  133 +++++++------
 drivers/video/sm501fb.c                      |  272 +++++++++++++++++---------
 include/linux/sm501.h                        |    8 +
 8 files changed, 555 insertions(+), 159 deletions(-)
 create mode 100644 Documentation/fb/sm501.txt
 create mode 100644 Documentation/powerpc/dts-bindings/sm501.txt
 create mode 100644 arch/powerpc/boot/dts/charon.dts

-- 
1.7.4

