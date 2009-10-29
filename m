From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] atmel_lcdfb: silence compiler
 warning in device info printk
Date: Thu, 29 Oct 2009 14:17:37 +0100
Message-ID: <4AE995F1.6010307@atmel.com>
References: <1256818234-16955-1-git-send-email-hans-christian.egtvedt@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <nicolas.ferre@atmel.com>) id 1N3Ut8-0005Z0-I4
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 29 Oct 2009 13:18:02 +0000
Received: from mail.atmel.fr ([81.80.104.162] helo=atmel-es2.atmel.fr)
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N3Ut3-0005Up-H8 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 29 Oct 2009 13:18:02 +0000
Received: from fwat.rfo.atmel.com (gateway [192.168.1.1])
	by atmel-es2.atmel.fr (8.11.6+Sun/8.11.6) with SMTP id e9TDH5O26399
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 29 Oct 2000 14:17:10 +0100 (MET)
In-Reply-To: <1256818234-16955-1-git-send-email-hans-christian.egtvedt@atmel.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Hans-Christian Egtvedt :
> This patch will tell printk the format for irq_base is a decimal and not an
> unsigned long. The irq_base is defined as an int in the struct
> atmel_lcdfb_info.

Hi Hans-Christian,

I guess this patch is already submitted using the name:

    atmel_lcdfb.c: fix printk() type mismatch

It goes his way using "trivial" git tree. It is already in linux-next
(baad1b580a7d08a4062a7f50eab0e06f90ad94d6) and I hope it will be
included in 2.6.32-final.

> Signed-off-by: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
> ---
>  drivers/video/atmel_lcdfb.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
> index 2830ffd..317afab 100644
> --- a/drivers/video/atmel_lcdfb.c
> +++ b/drivers/video/atmel_lcdfb.c
> @@ -959,7 +959,7 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
>  	if (sinfo->atmel_lcdfb_power_control)
>  		sinfo->atmel_lcdfb_power_control(1);
>  
> -	dev_info(dev, "fb%d: Atmel LCDC at 0x%08lx (mapped at %p), irq %lu\n",
> +	dev_info(dev, "fb%d: Atmel LCDC at 0x%08lx (mapped at %p), irq %d\n",
>  		       info->node, info->fix.mmio_start, sinfo->mmio, sinfo->irq_base);
>  
>  	return 0;

Thanks, Bye,
-- 
Nicolas Ferre


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
