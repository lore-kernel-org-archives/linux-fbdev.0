From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] atmel_lcdfb: FIFO underflow
	management
Date: Mon, 19 May 2008 16:00:06 -0700
Message-ID: <20080519160006.12a30e71.akpm@linux-foundation.org>
References: <482D7F44.7040404@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JyELc-0001C9-UY for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 19 May 2008 16:00:53 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JyELb-0006j8-M8
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 19 May 2008 16:00:52 -0700
In-Reply-To: <482D7F44.7040404@atmel.com>
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
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, hskinnemoen@atmel.com, adaplas@gmail.com, linux@maxim.org.za

On Fri, 16 May 2008 14:34:12 +0200
Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> Manage atmel_lcdfb FIFO underflow
> 
> Resetting the LCD and DMA allows to fix screen shifting after a 
> FIFO underflow. It follows reset sequence from errata 
> "LCD Screen Shifting After a Reset".
> 

This looks like 2.6.26-worthy bugfix to me?  But as commonly happens,
that isn't terribly clear.

> +	if (status & ATMEL_LCDC_UFLWI) {
> +		dev_warn(info->device, "FIFO underflow %#x\n", status);
> +		/* reset DMA and FIFO to avoid screen shifting */
> +		schedule_work(&sinfo->task);
> +	}
> +	lcdc_writel(sinfo, ATMEL_LCDC_ICR, status);
>  	return IRQ_HANDLED;
>  }

Shouldn't there be a cancel_work_sync() in atmel_lcdfb_exit()?


> +	/* Initialize bottom half workqueue */

Well.  "bottom half" is an ancient term for softirqs, not for the
new-fangled process-context callbacks.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
