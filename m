From: Bernhard Fischer <rep.dot.nop@gmail.com>
Subject: Re: [PATCH v3] [FB] Add the carmine FB driver.
Date: Mon, 21 Apr 2008 16:39:07 +0200
Message-ID: <20080421143907.GA19553@mx.loc>
References: <20080421120706.GC11534@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JnxHN-0003tA-Jt for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Apr 2008 07:46:01 -0700
Received: from nf-out-0910.google.com ([64.233.182.190])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JnxHK-00048Q-RQ
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Apr 2008 07:46:01 -0700
Received: by nf-out-0910.google.com with SMTP id 4so537049nfv.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 21 Apr 2008 07:45:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080421120706.GC11534@Chamillionaire.breakpoint.cc>
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
To: Sebastian Siewior <frame+buffer@ml.breakpoint.cc>
Cc: tglx@linutronix.de, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, Antonino Daplas <adaplas@gmail.com>

On Mon, Apr 21, 2008 at 02:07:06PM +0200, Sebastian Siewior wrote:
>From: Sebastian Siewior <bigeasy@linutronix.de>
>
>Basic FB driver for the carmine chip. The driver registers
>two FB devices for the two possible screens.
>The DRAM settings can be be switched via Kconfig (between eval board
>and custom).
>
>Signed-off-by: Sebastian Siewior <bigeasy@linutronix.de>
>---
>Changelog:
>v3: carmine_check_var() can now fail if an invalid parameter for
>    resolution was supplied instead of using default values and keeping
>    an invalid struct fb_info (noticed by Geert Uytterhoeven).
>v2: - s/carime/carmine/ noticed by Hans J. Koch
>    - fb_get_options() isn't used anymore. The initial video can only be
>      supplied via the module parameter (recommended by Jaya Kumar).
>v1: Initial posting
>
> drivers/video/Kconfig          |   23 ++
> drivers/video/Makefile         |    1 +
> drivers/video/carminefb.c      |  801 ++++++++++++++++++++++++++++++++++++++++
> drivers/video/carminefb.h      |   64 ++++
> drivers/video/carminefb_regs.h |  159 ++++++++
> 5 files changed, 1048 insertions(+), 0 deletions(-)
> create mode 100644 drivers/video/carminefb.c
> create mode 100644 drivers/video/carminefb.h
> create mode 100644 drivers/video/carminefb_regs.h
>

>+choice
>+    depends on FB_CARMINE
>+    prompt "DRAM timming"

s/timming/timing/g

>+	/* Set default curor position */

s/curor/cursor/g

>+static void set_display_parameters(struct carmine_fb *par)
>+{
>+	u32 mode;
>+	u32 hdp, vdp, htp, hsp, hsw, vtr, vsp, vsw;
>+
>+	/*
>+	 * display timing. Parameters ae decreased by one because hardware

s/ae/are/

s/ressolution/resolution/g


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
