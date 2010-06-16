From: Marek Szyprowski <m.szyprowski@samsung.com>
Date: Wed, 16 Jun 2010 09:34:43 +0000
Subject: [PATCH v2] Various s3c-fb updates
Message-Id: <1276680892-14760-1-git-send-email-m.szyprowski@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1275296935-2693-1-git-send-email-p.osciak@samsung.com>
In-Reply-To: <1275296935-2693-1-git-send-email-p.osciak@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello,

Im sending a new version of the s3c-fb patch series on behalf of Pawel
Osciak.

This series is rebased onto Ben Dook's framebuffer branch available at:
git://git.fluff.org/bjdooks/linux.git dev/s3c-fb

The main changes are the addition of an ability to wait for VSYNC and
display panning and better support for S5PV210 SoCs. A lot of various
bugs has been also fixed.

The first patch attempts to fix some NULL pointer dereferences in case
of a failed framebuffer memory allocation attempt. This is a quick fix,
so please treat it more as an indication of what may be wrong with the
code in the probe function and not as something to merge.

Patches 3-4 add "new style" device name initialization for various
S3C/S5P devices. The 4th patch also separates S5PC100 and S5PV210 as
their framebuffer registers sets differ.

Patch 7 nd 9 are pure bugfixes.

Patch 8 adds support for the new feature available on S5PV210.

The complete list of patches:
[PATCH 1/9] s3c-fb: Fix various null references on framebuffer memory alloc failure
[PATCH 2/9] s3c-fb: Correct FRAMESEL1 bitfield defines for VIDINTCON0 register
[PATCH 3/9] s3c-fb: Add device name initialization.
[PATCH 4/9] s3c-fb: Separate S5PC100 and S5PV210 framebuffer driver data structures
[PATCH 5/9] s3c-fb: Add support for display panning
[PATCH 6/9] s3c-fb: Add wait for VSYNC ioctl
[PATCH 7/9] s3c-fb: window 3 of 64xx+ does not have an osd_d register
[PATCH 8/9] s3c-fb: Add SHADOWCON shadow register locking support for S5PV210
[PATCH 9/9] s3c-fb: Correct window osd size and alpha register handling

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
