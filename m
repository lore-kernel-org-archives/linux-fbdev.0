From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH]: change rivafb_remove to __devexit
Date: Wed, 21 Feb 2007 21:32:21 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702212131530.20620@pentafluge.infradead.org>
References: <20070220161306.23688.53776.sendpatchset@prarit.boston.redhat.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HJz4h-0006bT-7q for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 13:32:31 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HJz4g-0000b0-4S
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 13:32:31 -0800
In-Reply-To: <20070220161306.23688.53776.sendpatchset@prarit.boston.redhat.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Prarit Bhargava <prarit@redhat.com>
Cc: adaplas@pol.net, akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org


Acked-By: James Simmons <jsimmons@infradead.org>

On Tue, 20 Feb 2007, Prarit Bhargava wrote:

> Resubmitting with wider audience (akpm & lkml).
> 
> Change rivafb_remove to __deviexit to fix MODPOST warnings:
> 
> WARNING: drivers/video/riva/rivafb.o - Section mismatch: reference to
> .exit.text:rivafb_remove from .data.rel.local after 'rivafb_driver' (at offset 0x28)
> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> 
> --- linux-2.6.19.ia64.orig/drivers/video/riva/fbdev.c	2007-02-07 09:56:37.000000000 -0500
> +++ linux-2.6.19.ia64/drivers/video/riva/fbdev.c	2007-02-08 11:39:35.000000000 -0500
> @@ -2154,7 +2154,7 @@ err_ret:
>  	return ret;
>  }
>  
> -static void __exit rivafb_remove(struct pci_dev *pd)
> +static void __devexit rivafb_remove(struct pci_dev *pd)
>  {
>  	struct fb_info *info = pci_get_drvdata(pd);
>  	struct riva_par *par = info->par;
> @@ -2232,7 +2232,7 @@ static struct pci_driver rivafb_driver =
>  	.name		= "rivafb",
>  	.id_table	= rivafb_pci_tbl,
>  	.probe		= rivafb_probe,
> -	.remove		= __exit_p(rivafb_remove),
> +	.remove		= __devexit_p(rivafb_remove),
>  };
>  
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
