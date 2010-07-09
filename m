From: Pawel Osciak <p.osciak@samsung.com>
Date: Fri, 09 Jul 2010 08:49:48 +0000
Subject: [PATCH v4 0/19] Various s3c-fb updates
Message-Id: <1278665407-18002-1-git-send-email-p.osciak@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello,

This series contains various Samsung framebuffer driver updates.
I believe that it has reached the stage of being ready for merging.

The main highlights of this series are:
- Ben Dook's unification of the plethora of Samsung framebuffer header
files with configuration selection at probe time, machine naming;
- palette setup code moved to the main driver;
- added ability to wait for VSYNC and to pan the display;
- better support for new features found in S5PV210 SoCs, including
  shadow register handling and DMA channel control,
- various small changes,
- a number of bugs has also been fixed.


Changes in v4:
- corrected fb_dealloc_cmap condition on window probe failure
- fixed a race condition in wait for VSYNC ioctl
- removed has_osd_size flag from window variant; osd_size_off != 0
  now implies has_osd_size = 1
- cosmetic changes, as suggested by Ben Dooks, and more comments

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

[PATCH 01/19] s3c-fb: Change to depending on CONFIG_S3C_FB_DEV
[PATCH 02/19] s3c-fb: add default window feature.
[PATCH 03/19] s3c-fb: fixed distortedness situation for the mode more then 24bpp.
[PATCH 04/19] s3c-fb: only init window colour key controls for windows with blending
[PATCH 05/19] s3c-fb: Initial move to unifying the header files
[PATCH 06/19] s3c-fb: udpate to support s3c2416/s3c2443 style hardware
[PATCH 07/19] s3c-fb: Integrate palette setup code into main driver
[PATCH 08/19] s3c-fb: Fix various null references on framebuffer memory alloc failure
[PATCH 09/19] s3c-fb: Correct FRAMESEL1 bitfield defines for VIDINTCON0 register
[PATCH 10/19] s3c-fb: Separate S5PC100 and S5PV210 framebuffer driver data structures
[PATCH 11/19] s3c-fb: Add device name initialization
[PATCH 12/19] s3c-fb: Add support for display panning
[PATCH 13/19] s3c-fb: Add wait for VSYNC ioctl
[PATCH 14/19] s3c-fb: window 3 of 64xx+ does not have an osd_d register
[PATCH 15/19] s3c-fb: Add SHADOWCON shadow register locking support for S5PV210
[PATCH 16/19] s3c-fb: Correct window osd size and alpha register handling
[PATCH 17/19] s3c-fb: Protect window-specific registers during updates
[PATCH 18/19] s3c-fb: fix section mismatch
[PATCH 19/19] s3c-fb: Add support for DMA channel control on S5PV210

Best regards
--
Pawel Osciak
Linux Platform Group
Samsung Poland R&D Center
