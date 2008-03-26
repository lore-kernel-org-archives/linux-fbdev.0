From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] Blackfin Video Driver: Update
 the BF52x EZKIT video framebuffer driver according to LKML review
Date: Wed, 26 Mar 2008 13:32:27 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803261331260.13478@anakin>
References: <> <1206580775-23929-2-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JeUo6-0002O7-U7 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 26 Mar 2008 05:32:42 -0700
Received: from monty.telenet-ops.be ([195.130.132.56])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JeUo3-0003h1-FD
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 26 Mar 2008 05:32:42 -0700
In-Reply-To: <1206580775-23929-2-git-send-email-cooloney@kernel.org>
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
To: Bryan Wu <cooloney@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Michael Hennerich <michael.hennerich@analog.com>

On Wed, 26 Mar 2008, Bryan Wu wrote:
> @@ -552,11 +544,11 @@ static int __init bfin_t350mcqb_probe(struct platform_device *pdev)
>  		goto out7;
>  	}
>  
> -	if (request_irq(info->irq, (void *)bfin_t350mcqb_irq_error, IRQF_DISABLED,
> -			"PPI ERROR", info) < 0) {
> +	ret = request_irq(info->irq, (void *)bfin_t350mcqb_irq_error, IRQF_DISABLED,
                                     ^^^^^^^^
This cast should not be necessary. If it is, the signature of
bfin_t350mcqb_irq_error() is incorrect.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
