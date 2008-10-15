From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: i.MX framebuffer patches
Date: Wed, 15 Oct 2008 10:28:00 +0200
Message-ID: <20081015082800.GG756@pengutronix.de>
References: <1220354697-13648-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sha@pengutronix.de>) id 1Kq1nZ-0000LZ-4P
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 15 Oct 2008 08:32:05 +0000
Received: from metis.extern.pengutronix.de ([83.236.181.26])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Kq1jh-0000bA-JR
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 15 Oct 2008 08:32:03 +0000
Content-Disposition: inline
In-Reply-To: <1220354697-13648-1-git-send-email-s.hauer@pengutronix.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Dyer <amdyer@gmail.com>

On Tue, Sep 02, 2008 at 01:24:43PM +0200, Sascha Hauer wrote:
> These patches are the rework of the patches I sent some time ago based
> on comments from Krzysztof Helt, Andrew Dyer and Russell King. The patches
> are also available as git:
> 
> git://pasiphae.extern.pengutronix.de/git/imx/linux-2.6.git imxfb

Are these patches being cared upon? They didn't show up in any tree yet.
To show off my growing git experience here's a proper pull request ;)

Sascha

The following changes since commit 278429cff8809958d25415ba0ed32b59866ab1a8:
  Linus Torvalds (1):
        Merge branch 'i2c-for-linus' of git://jdelvare.pck.nerim.net/jdelvare-2.6

are available in the git repository at:

  git://pasiphae.extern.pengutronix.de/git/imx/linux-2.6.git imxfb

Juergen Beisert (1):
      i.MX Framebuffer: Use readl/writel instead of direct pointer deref

Sascha Hauer (5):
      i.MX Framebuffer: remove gpio setup function
      i.MX Framebuffer: fix margins
      i.MX Framebuffer: remove header file
      i.MX Framebuffer: Cleanup Coding style
      i.MX Framebuffer: rename imxfb_mach_info to imx_fb_platform_data

sascha Hauer (1):
      i.MX Framebuffer: add TFT support

 arch/arm/mach-imx/include/mach/imxfb.h |   50 ++++-
 drivers/video/imxfb.c                  |  468 ++++++++++++++++++--------------
 drivers/video/imxfb.h                  |   73 -----
 3 files changed, 315 insertions(+), 276 deletions(-)
 delete mode 100644 drivers/video/imxfb.h



-- 
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
