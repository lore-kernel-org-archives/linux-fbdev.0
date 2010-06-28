From: Pawel Osciak <p.osciak@samsung.com>
Date: Mon, 28 Jun 2010 08:08:46 +0000
Subject: [PATCH v3 0/12] Various s3c-fb updates
Message-Id: <1277712538-23188-1-git-send-email-p.osciak@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello,

this series is rebased onto Ben Dook's framebuffer branch available at:
git://git.fluff.org/bjdooks/linux.git dev/s3c-fb

The main changes are the addition of an ability to wait for VSYNC and
display panning and a better support for S5PV210 SoCs. A number of bugs
has also been fixed.

The first patch attempts to fix some NULL pointer dereferences in case
of a failed framebuffer memory allocation attempt. This is a quick fix,
so please treat it more as an indication of what may be wrong with the
code in the probe function and not as something to merge.

Patches 3-4 add "new style" device name initialization for various
S3C/S5P devices. The 4th patch also separates S5PC100 and S5PV210 as
their framebuffer registers sets differ.

Patches 8, 10 add shadow register update locking (S3C6410+)
Patch 12 Adds support for DMA channel control found on S5PV210+

Patches 7, 9 and 11 are pure bugfixes.

Changes in v3:
- new patches:
  * fixing a section mismatch error
  * adding support for DMA channel control (enable/disable) found on S5PV210
  * disabling shadow register updates during set_par

- unified function for disabling register updates
- no need to initialize names for 64xx-type framebuffers (is being set as
  default anyway)
- updated to the new version of Ben's branch
- minor fixes

Changes in v2:
- added SHADOWCON register support found on S3C6410 and S5PC100 for disabling
  shadow register updates
- fixed osd and alpha register handling (different configurations for different
  machines)

The series includes:
[PATCH v3 01/12] s3c-fb: Fix various null references on framebuffer memory alloc failure
[PATCH v3 02/12] s3c-fb: Correct FRAMESEL1 bitfield defines for VIDINTCON0 register
[PATCH v3 03/12] s3c-fb: Separate S5PC100 and S5PV210 framebuffer driver data structures
[PATCH v3 04/12] s3c-fb: Add device name initialization
[PATCH v3 05/12] s3c-fb: Add support for display panning
[PATCH v3 06/12] s3c-fb: Add wait for VSYNC ioctl
[PATCH v3 07/12] s3c-fb: window 3 of 64xx+ does not have an osd_d register
[PATCH v3 08/12] s3c-fb: Add SHADOWCON shadow register locking support for S5PV210
[PATCH v3 09/12] s3c-fb: Correct window osd size and alpha register handling
[PATCH v3 10/12] s3c-fb: Protect window-specific registers during updates
[PATCH v3 11/12] s3c-fb: fix section mismatch
[PATCH v3 12/12] s3c-fb: Add support for DMA channel control on S5PV210

Best regards
--
Pawel Osciak
Linux Platform Group
Samsung Poland R&D Center
