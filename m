From: Mika Pruikkonen <mpruikko@cc.hut.fi>
Subject: Crude savagefb driver for 2.6 kernels
Date: Thu, 17 Jun 2004 05:31:27 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040617023127.GD41088@cc.hut.fi>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bamgh-0002C3-Ug
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 19:31:35 -0700
Received: from smtp-2.hut.fi ([130.233.228.92] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1Bamgh-0004dt-AI
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 19:31:35 -0700
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: directfb-dev@directfb.org

Hi,

You can find a crude patch for S3 Savage framebuffers in:

http://www.hut.fi/~mpruikko/savagefb/patch-2.6.7-savagefb

It's based on the 2.4 savagefb driver found in the directfb project's 
cvs tree, with minor resyncing to the X driver. I really have no clue 
about video driver programming, nor actually about kernel hacking
either, but I wanted to be able to do acpi suspend and have the 
framebuffer work after the resume too, so here's the result. :)

I use this on an IBM Thinkpad T23, which has a S3 SuperSavage IXC and 
a 1024x768 lcd screen, and the driver hasn't been tested on anything 
else, so it will very probably not work without tweaking on most 
savages.

Features: screen corruption during mode switching, interesting text 
scroll effects, refreshingly unusual console color scheme at 16bpp, 
hard-coded boot resolution 1024x768@8bpp, warranty void if you're 
trying to use other resolutions than 1024x768. And I wouldn't try
compiling it as a module.

I also noticed that the driver was noticeably slower than vesafb (e.g. 
using mplayer with fbdev/fbdev2, text scrolling, etc). Following patch 
(incremental) hard-codes some timing registers to values which were in 
use when using vesafb (with vga=792):

http://www.hut.fi/~mpruikko/savagefb/patch-2.6.7-savagefb-hardcoded-timing

With this patch the performance seems comparable to vesafb. I have 
no idea how to fix this in general, though. I converted the timing 
calculation functions to use non-floating-point arithmetic, but I think 
they should produce the same results as in the directfb driver. Also, I 
remember reading that someone complained about worse-than-vesafb 
performance in the directfb driver too. Any ideas?

I hope someone can find this useful and/or maybe even get it to work, 
and I would welcome patches for the known "features" (or unknown ones), 
or much-needed cleanup.. best of all would of course be, if someone
who actually knew what he was doing would produce a proper driver to
be included in the kernel. :)

Regards,

  mp


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
