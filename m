From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH v4] [FB] Add the carmine FB driver.
Date: Mon, 21 Apr 2008 12:48:37 -0700
Message-ID: <20080421124837.aa4dcf91.randy.dunlap@oracle.com>
References: <20080421194344.GA18378@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jo21x-0007ki-Lo for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Apr 2008 12:50:25 -0700
Received: from rgminet01.oracle.com ([148.87.113.118])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Jo21w-0007b3-Bv
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Apr 2008 12:50:25 -0700
In-Reply-To: <20080421194344.GA18378@Chamillionaire.breakpoint.cc>
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

On Mon, 21 Apr 2008 21:43:44 +0200 Sebastian Siewior wrote:

> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 1bd5fb3..613849f 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -1629,6 +1629,32 @@ config FB_PM3
>  	  similar boards, 3DLabs Permedia3 Create!, Appian Jeronimo 2000
>  	  and maybe other boards.
>  
> +config FB_CARMINE
> +	tristate "Fujitsu carmine frame buffer support"
> +	depends on FB && PCI
> +	select FB_CFB_FILLRECT
> +	select FB_CFB_COPYAREA
> +	select FB_CFB_IMAGEBLIT
> +	help
> +	  This is the frame buffer device driver for the Fujitsu Carmine chip.
> +	  The driver provides two independent frame buffer devices.
> +
> +choice
> +    depends on FB_CARMINE
> +    prompt "DRAM timing"
> +    default FB_CARMINE_DRAM_EVAL
> +
> +config FB_CARMINE_DRAM_EVAL
> +    bool "Eval board timings"
> +    help
> +      Use timings which work on the eval card.
> +
> +config CARMINE_DRAM_CUSTOM
> +    bool "Custom board timings"
> +    help
> +      Use custom board timings"

Drop the ending quotation mark.  Actually, change it to a period.

> +endchoice
> +
>  config FB_AU1100
>  	bool "Au1100 LCD Driver"
>  	depends on (FB = y) && MIPS && SOC_AU1100

---
~Randy

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
