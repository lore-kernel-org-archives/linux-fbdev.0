From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] sm501fb: control panel pin usage
	with platform data flags
Date: Thu, 10 Jan 2008 11:53:31 +0900
Message-ID: <20080110025331.GA8906@linux-sh.org>
References: <20071228055552.813.58357.sendpatchset@clockwork.opensource.se>
	<20071228055113.807.96733.sendpatchset@clockwork.opensource.se>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JCnYN-0005up-6z for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 09 Jan 2008 18:53:59 -0800
Received: from pip10.gyao.ne.jp ([61.122.117.248] helo=mx.gate01.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JCnYL-0005IB-Oe
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 09 Jan 2008 18:53:59 -0800
Content-Disposition: inline
In-Reply-To: <20071228055552.813.58357.sendpatchset@clockwork.opensource.se>
	<20071228055113.807.96733.sendpatchset@clockwork.opensource.se>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm@linux-foundation.org, Magnus Damm <magnus.damm@gmail.com>, syrjala@sci.fi, ben-linux@fluff.org

On Fri, Dec 28, 2007 at 02:51:13PM +0900, Magnus Damm wrote:
> sm501fb: control panel pin usage with platform data flags
> 
> This patch makes it possible to control panel pins usage with flags passed
> from the platform data. Without this patch the sm501fb driver always controls
> the VBIASEN and FPEN pins. The polarity and use of these pins are very platform
> specific, so this patch introduces the flags SM501FB_FLAG_PANEL_USE_VBIASEN
> and SM501FB_FLAG_PANEL_USE_FPEN which enable the use of these pins.
> 
> This patch is needed to support the a Sharp LQ104V1DG21 lcd panel on SuperH
> platforms such as R2D-1 and R2D-PLUS boards. Letting the sm501fb driver control
> the FPEN and VBIASEN pins like today just results in lcd panel flicker.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

On Fri, Dec 28, 2007 at 02:55:52PM +0900, Magnus Damm wrote:
> sm501fb: clear framebuffer memory and palette
> 
> Avoid displaying garbage on unused framebuffers. For most users a single
> framebuffer is used together with fbcon. sm501fb supports two framebuffers
> where one often is assigned to fbcon and the other one is left unused during
> the boot.
> 
> The problem here is that framebuffers not in use by fbcon happen to display
> garbage. This can easily be solved by making sure that framebuffer memory and
> palette ram are cleared.
> 
> The problem can be observed by using looking at the panel output (fb1)
> after booting the kernel with fbcon on crt (fb0). This is the default
> configuration. It's also possible to watch the garbage on the crt framebuffer
> by passing "fbcon=map:1" on the kernel cmdline. This will assign fbcon to
> the panel (fb1) and leave the crt (fb0) unused.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

There hasn't been any updates or objections to these, and we do still
need them.  Andrew, can you roll these in to -mm?

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
