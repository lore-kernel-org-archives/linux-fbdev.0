From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 13/15] viafb: initialize 2D engine
 registers from loop
Date: Sat, 23 May 2009 08:27:04 +0200
Message-ID: <20090523082704.d5dc7052.krzysztof.h1@poczta.fm>
References: <1242851333-325-1-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-2-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-3-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-4-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-5-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-6-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-7-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-8-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-9-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-10-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-11-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-12-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-13-git-send-email-HaraldWelte@viatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1M7kbA-0002JL-Kv
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 May 2009 06:20:48 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M7kb5-0000Z5-Rs for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 May 2009 06:20:48 +0000
In-Reply-To: <1242851333-325-13-git-send-email-HaraldWelte@viatech.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Harald Welte <HaraldWelte@viatech.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Thu, 21 May 2009 04:28:51 +0800
Harald Welte <HaraldWelte@viatech.com> wrote:

> From: Harald Welte <laforge@gnumonks.org>
> 
> We don't need to unroll the register initialization routine when
> initializing the 2D engine registers
> 
> Signed-off-by: Harald Welte <HaraldWelte@viatech.com>
> ---
>  drivers/video/via/accel.c |   18 +++---------------
>  1 files changed, 3 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/video/via/accel.c b/drivers/video/via/accel.c
> index c3af95f..b3a414e 100644
> --- a/drivers/video/via/accel.c
> +++ b/drivers/video/via/accel.c
> @@ -41,23 +41,11 @@ void viafb_init_2d_engine(void)
>  {
>  	u32 dwVQStartAddr, dwVQEndAddr;
>  	u32 dwVQLen, dwVQStartL, dwVQEndL, dwVQStartEndH;
> +	int i;
>  
>  	/* init 2D engine regs to reset 2D engine */
> -	writel(0x0, viaparinfo->io_virt + VIA_REG_GEMODE);
> -	writel(0x0, viaparinfo->io_virt + VIA_REG_SRCPOS);
> -	writel(0x0, viaparinfo->io_virt + VIA_REG_DSTPOS);
> -	writel(0x0, viaparinfo->io_virt + VIA_REG_DIMENSION);
> -	writel(0x0, viaparinfo->io_virt + VIA_REG_PATADDR);
> -	writel(0x0, viaparinfo->io_virt + VIA_REG_FGCOLOR);
> -	writel(0x0, viaparinfo->io_virt + VIA_REG_BGCOLOR);
> -	writel(0x0, viaparinfo->io_virt + VIA_REG_CLIPTL);
> -	writel(0x0, viaparinfo->io_virt + VIA_REG_CLIPBR);
> -	writel(0x0, viaparinfo->io_virt + VIA_REG_OFFSET);
> -	writel(0x0, viaparinfo->io_virt + VIA_REG_KEYCONTROL);
> -	writel(0x0, viaparinfo->io_virt + VIA_REG_SRCBASE);
> -	writel(0x0, viaparinfo->io_virt + VIA_REG_DSTBASE);
> -	writel(0x0, viaparinfo->io_virt + VIA_REG_PITCH);
> -	writel(0x0, viaparinfo->io_virt + VIA_REG_MONOPAT1);
> +	for (i = 0; i <= 0x40; i+= 4)
> +		writel(0x0, viaparinfo->io_virt + i);
>  

Use your new viafb_2d_writel() here.

>  	/* Init AGP and VQ regs */
>  	switch (viaparinfo->chip_info->gfx_chip_name) {
> -- 
> 1.6.2.4
> 
> 
> ------------------------------------------------------------------------------
> Crystal Reports - New Free Runtime and 30 Day Trial
> Check out the new simplified licensing option that enables 
> unlimited royalty-free distribution of the report engine 
> for externally facing server and web deployment. 
> http://p.sf.net/sfu/businessobjects
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 

----------------------------------------------------------------------
Weekend w gorach za 100 PLN!
Sprawdz >>> http://link.interia.pl/f218c


------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
