From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] pnx4008:fix NULL dereference in
 rgbfb
Date: Tue, 14 Nov 2006 15:42:27 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0611141538130.5654@pentafluge.infradead.org>
References: <20061109164244.GB13505@ru.mvista.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gk0Qh-0002qi-Pb for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 14 Nov 2006 07:42:31 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Gk0Qg-00018S-Pe
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 14 Nov 2006 07:42:31 -0800
In-Reply-To: <20061109164244.GB13505@ru.mvista.com>
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
Cc: Vitaly Wool <vwool@ru.mvista.com>


Yipes. I see people are really getting around the blinking cursor issue.
People want printks to the framebuffer but they hate the cursor. What 
would be better is a patch for a option for fbcon to disable the cursor.

> Hello folks,
> 
> the patch inlined fixes possible NULL dereference in pnxrgbfb.
> 
>  drivers/video/pnx4008/pnxrgbfb.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Signed-off-by: Vitaly Wool <vwool@ru.mvista.com>
> 
> Index: linux-2.6.18/drivers/video/pnx4008/pnxrgbfb.c
> ===================================================================
> --- linux-2.6.18.orig/drivers/video/pnx4008/pnxrgbfb.c
> +++ linux-2.6.18/drivers/video/pnx4008/pnxrgbfb.c
> @@ -154,7 +154,8 @@ static int __devinit rgbfb_probe(struct 
>  			goto err1;
>  	}
>  
> -	if (!fb_get_options("pnxrgbfb", &option) && !strcmp(option, "nocursor"))
> +	if (!fb_get_options("pnxrgbfb", &option) && option &&
> +			!strcmp(option, "nocursor"))
>  		rgbfb_ops.fb_cursor = no_cursor;
>  
>  	info->node = -1;
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
