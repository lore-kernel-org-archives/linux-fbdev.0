From: Mike <mike@compulab.co.il>
Subject: Re: [PATCH] mbxfb: fix incorrect argument type
Date: Mon, 22 Oct 2007 10:36:00 +0200
Message-ID: <471C60F0.9030507@compulab.co.il>
References: <20071018234610.1498b21e.krzysztof.h1@poczta.fm>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ijsu5-0004SU-TR for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 22 Oct 2007 01:44:54 -0700
Received: from sa5.bezeqint.net ([192.115.104.19])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ijsu4-0006Q0-GD
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 22 Oct 2007 01:44:53 -0700
In-Reply-To: <20071018234610.1498b21e.krzysztof.h1@poczta.fm>
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
To: krzysztof.h1@poczta.fm
Cc: linux-fbdev-devel@lists.sourceforge.net


Krzysztof Helt wrote:
> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> This patch fixes wrong pointer type passed into
> the dev_dbg() function.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

Acked-by: Mike Rapoport <mike@compulab.co.il>

> This patch was done against the 2.6.23-git13 kernel.
> 
> diff -urp linux-ref/drivers/video/mbx/mbxfb.c linux-new/drivers/video/mbx/mbxfb.c
> --- linux-ref/drivers/video/mbx/mbxfb.c	2007-10-18 22:32:50.984989900 +0200
> +++ linux-new/drivers/video/mbx/mbxfb.c	2007-10-18 23:38:03.775967147 +0200
> @@ -889,7 +889,7 @@ static int __devinit mbxfb_probe(struct 
>  	struct mbxfb_info *mfbi;
>  	struct mbxfb_platform_data *pdata;
>  
> -	dev_dbg(dev, "mbxfb_probe\n");
> +	dev_dbg(&dev->dev, "mbxfb_probe\n");
>  
>  	pdata = dev->dev.platform_data;
>  	if (!pdata) {
> 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
