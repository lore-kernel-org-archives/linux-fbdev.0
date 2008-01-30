From: Ben Dooks <ben@fluff.org>
Subject: Re: [RESEND][PATCH] sm501fb: clear
	framebuffer	memory and palette
Date: Wed, 30 Jan 2008 11:14:41 +0000
Message-ID: <20080130111441.GB7089@fluff.org.uk>
References: <20080121105925.12446.36815.sendpatchset@clockwork.opensource.se>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JKAu1-0004DV-H9 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 30 Jan 2008 03:14:49 -0800
Received: from 87-194-8-8.bethere.co.uk ([87.194.8.8] helo=kira.home.fluff.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JKAtz-0000Nf-RG
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 30 Jan 2008 03:14:49 -0800
Received: from ben by kira.home.fluff.org with local (Exim 4.68)
	(envelope-from <ben@fluff.org.uk>) id 1JKAtt-0006rB-4V
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 30 Jan 2008 11:14:41 +0000
Content-Disposition: inline
In-Reply-To: <20080121105925.12446.36815.sendpatchset@clockwork.opensource.se>
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

On Mon, Jan 21, 2008 at 07:59:25PM +0900, Magnus Damm wrote:
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

Can you please add a no-clear-on-init flag incase people do not want
their framebuffers cleared.
 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
> 
>  This is the same patch that was sent to linux-fbdev-devel on 20071228.
> 
>  drivers/video/sm501fb.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> --- 0002/drivers/video/sm501fb.c
> +++ work/drivers/video/sm501fb.c	2007-12-27 13:24:20.000000000 +0900
> @@ -1264,6 +1264,7 @@ static int sm501fb_start(struct sm501fb_
>  {
>  	struct resource	*res;
>  	struct device *dev;
> +	int k;
>  	int ret;
>  
>  	info->dev = dev = &pdev->dev;
> @@ -1325,6 +1326,13 @@ static int sm501fb_start(struct sm501fb_
>  
>  	info->fbmem_len = (res->end - res->start)+1;
>  
> +	/* clear framebuffer memory - avoids garbage data on unused fb */
> +	memset(info->fbmem, 0, info->fbmem_len);
> +
> +	/* clear palette ram - undefined at power on */
> +	for (k = 0; k < (256 * 3); k++)
> +		writel(0, info->regs + SM501_DC_PANEL_PALETTE + (k * 4));
> +
>  	/* enable display controller */
>  	sm501_unit_power(dev->parent, SM501_GATE_DISPLAY, 1);
>  
> 
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
