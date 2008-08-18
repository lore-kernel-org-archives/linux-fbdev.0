From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] RADEON: duplicate
	PIXCLKS_CNTL__R300_P2G2CLK_ALWAYS_ONb
Date: Tue, 19 Aug 2008 08:06:40 +1000
Message-ID: <1219097200.28339.94.camel@pasglop>
References: <48AA3900.80305@gmail.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KVCsE-00015s-Rm for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 Aug 2008 15:06:50 -0700
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX1+Bu5GS2kcBpTdIlLxtB57IeFG/PCIkHqU=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KVCsD-0008FF-9w
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 Aug 2008 15:06:50 -0700
In-Reply-To: <48AA3900.80305@gmail.com>
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
To: roel kluin <roel.kluin@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Mon, 2008-08-18 at 23:07 -0400, roel kluin wrote:
> untested, is it correct?
> ---
> duplicate PIXCLKS_CNTL__R300_P2G2CLK_ALWAYS_ONb

Hard to say... this code originates from ATI. I'll have to dig a bit
to see what is the right bit combo I suppose.

> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> diff --git a/drivers/video/aty/radeon_pm.c b/drivers/video/aty/radeon_pm.c
> index 675abda..74d2e65 100644
> --- a/drivers/video/aty/radeon_pm.c
> +++ b/drivers/video/aty/radeon_pm.c
> @@ -210,7 +210,7 @@ static void radeon_pm_disable_dynamic_mode(struct radeonfb_info *rinfo)
>  			 PIXCLKS_CNTL__R300_PIXCLK_TRANS_ALWAYS_ONb	|
>  			 PIXCLKS_CNTL__R300_PIXCLK_TVO_ALWAYS_ONb	|
>  			 PIXCLKS_CNTL__R300_P2G2CLK_ALWAYS_ONb		|
> -			 PIXCLKS_CNTL__R300_P2G2CLK_ALWAYS_ONb		|
> +			 PIXCLKS_CNTL__R300_P2G2CLK_DAC_ALWAYS_ONb	|
>  			 PIXCLKS_CNTL__R300_DISP_DAC_PIXCLK_DAC2_BLANK_OFF);
>                  OUTPLL(pllPIXCLKS_CNTL, tmp);
>  
> @@ -392,7 +392,7 @@ static void radeon_pm_enable_dynamic_mode(struct radeonfb_info *rinfo)
>  			PIXCLKS_CNTL__R300_PIXCLK_TRANS_ALWAYS_ONb      |
>  			PIXCLKS_CNTL__R300_PIXCLK_TVO_ALWAYS_ONb        |
>  			PIXCLKS_CNTL__R300_P2G2CLK_ALWAYS_ONb           |
> -			PIXCLKS_CNTL__R300_P2G2CLK_ALWAYS_ONb);
> +			PIXCLKS_CNTL__R300_P2G2CLK_DAC_ALWAYS_ONb);
>  		OUTPLL(pllPIXCLKS_CNTL, tmp);
>  
>  		tmp = INPLL(pllMCLK_MISC);


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
