From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] pnx4008: rename driver
Date: Tue, 14 Nov 2006 15:35:26 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0611141534360.5654@pentafluge.infradead.org>
References: <20061109164627.GC13505@ru.mvista.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gk0Jw-0002BM-73 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 14 Nov 2006 07:35:32 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Gk0Jv-0007Zy-ND
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 14 Nov 2006 07:35:32 -0800
In-Reply-To: <20061109164627.GC13505@ru.mvista.com>
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
Cc: Andrew Morton <akpm@osdl.org>

On Thu, 9 Nov 2006, Vitaly Wool wrote:

Acked-by: James Simmons <jsimmons@infradead.org>

> Hello folks,
> 
> the patch inlined below makes the drivers' names less generic to avoid
> possible confusion in future, as was requested by Russell King.
> 
>  drivers/video/pnx4008/pnxrgbfb.c |    2 +-
>  drivers/video/pnx4008/sdum.c     |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Signed-off-by: Vitaly Wool <vwool@ru.mvista.com>
> 
> Index: linux-2.6.18/drivers/video/pnx4008/pnxrgbfb.c
> ===================================================================
> --- linux-2.6.18.orig/drivers/video/pnx4008/pnxrgbfb.c
> +++ linux-2.6.18/drivers/video/pnx4008/pnxrgbfb.c
> @@ -191,7 +191,7 @@ err:
>  
>  static struct platform_driver rgbfb_driver = {
>  	.driver = {
> -		.name = "rgbfb",
> +		.name = "pnx4008-rgbfb",
>  	},
>  	.probe = rgbfb_probe,
>  	.remove = rgbfb_remove,
> Index: linux-2.6.18/drivers/video/pnx4008/sdum.c
> ===================================================================
> --- linux-2.6.18.orig/drivers/video/pnx4008/sdum.c
> +++ linux-2.6.18/drivers/video/pnx4008/sdum.c
> @@ -848,7 +848,7 @@ static int sdum_remove(struct platform_d
>  
>  static struct platform_driver sdum_driver = {
>  	.driver = {
> -		.name = "sdum",
> +		.name = "pnx4008-sdum",
>  	},
>  	.probe = sdum_probe,
>  	.remove = sdum_remove,
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
