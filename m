From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH]: change nvidiafb_remove to __devexit
Date: Thu, 8 Feb 2007 18:33:56 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702081832260.7686@pentafluge.infradead.org>
References: <20070208162952.17679.45127.sendpatchset@prarit.boston.redhat.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HFE7P-0000Kd-IU for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Feb 2007 10:35:39 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HFE7N-0006qT-Nf
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Feb 2007 10:35:39 -0800
In-Reply-To: <20070208162952.17679.45127.sendpatchset@prarit.boston.redhat.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Prarit Bhargava <prarit@redhat.com>, adaplas@pol.net, Andrew Morton <akpm@osdl.org>


Acked-By: James Simmons <jsimmons@infradead.org>

> Change nvidiafb_remove to __devexit to fix MODPOST warnings:
> 
> WARNING: drivers/video/nvidia/nvidiafb.o - Section mismatch: reference to
> .exit.text:nvidiafb_remove from .data.rel.local after 'nvidiafb_driver' (at
> offset 0x28)
> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> 
> --- linux-2.6.19.ia64.orig/drivers/video/nvidia/nvidia.c	2007-02-07 09:56:37.000000000 -0500
> +++ linux-2.6.19.ia64/drivers/video/nvidia/nvidia.c	2007-02-08 11:14:13.000000000 -0500
> @@ -1347,7 +1347,7 @@ err_out:
>  	return -ENODEV;
>  }
>  
> -static void __exit nvidiafb_remove(struct pci_dev *pd)
> +static void __devexit nvidiafb_remove(struct pci_dev *pd)
>  {
>  	struct fb_info *info = pci_get_drvdata(pd);
>  	struct nvidia_par *par = info->par;
> @@ -1433,7 +1433,7 @@ static struct pci_driver nvidiafb_driver
>  	.probe    = nvidiafb_probe,
>  	.suspend  = nvidiafb_suspend,
>  	.resume   = nvidiafb_resume,
> -	.remove   = __exit_p(nvidiafb_remove),
> +	.remove   = __devexit_p(nvidiafb_remove),
>  };
>  
>  /* ------------------------------------------------------------------------- *
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier.
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
