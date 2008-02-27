From: "eric miao" <eric.y.miao@gmail.com>
Subject: [PATCH 0/8] pxafb cleanup
Date: Wed, 27 Feb 2008 10:32:29 +0800
Message-ID: <f17812d70802261832l78840912r4dcb0403e9fe4385@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JUC5v-00038G-MT for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 26 Feb 2008 18:32:31 -0800
Received: from wa-out-1112.google.com ([209.85.146.183])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JUC5u-0002U2-D9
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 26 Feb 2008 18:32:31 -0800
Received: by wa-out-1112.google.com with SMTP id k22so3024889waf.18
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 26 Feb 2008 18:32:30 -0800 (PST)
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net

The following series of patches try to address several issues of the
current PXA framebuffer driver. Some of these patches are already
submitted for review, here are more:

pxa: un-nest pxafb_parse_options() to cleanup the coding style issue
pxa: fix various coding style issues for pxafb
pxa: purge unnecessary pr_debug and comments from pxafb
pxa: sanitize the usage of #ifdef .. processing pxafb parameters
pxa: convert fb driver to use ioremap() and __raw_{readl, writel}
pxa: introduce "struct pxafb_dma_buff" for palette and dma descriptors
pxa: introduce register independent LCD connection type for pxafb
pxa: make lubbock/mainstone/zylonite/littleton to use new LCD connection type

Board maintainers are encouraged to use the new way for LCD connection
types.

To further clean-up the driver, I suggest to make the following changes:
1. removal of set_ctrlr_state(), the original code is written so because
the fb_blank() is called within interrupt context in 2.4 kernel, but this is
no longer the case in 2.6. And states can be simplified.

2. introduce a "vram" module parameter or boot option to indicate the
size of the video memory, so that frame buffer offset can be specified
within this video memory range, and PAN_DISPLAY can be done.
And the start offset of each overlay can also be specified.

3. a "pxafb_layer" structure describing each possible layers,
base, overlay1 and overlay2 for pxa27x can be described. From this
layer information, frame buffer device can be dynamically allocated
and registered. Palette manipulation, parameter checking and
layer activation code can be generalized.

-- 
Cheers
- eric

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
