From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] cg6: accelerated copyarea
Date: Wed, 01 Aug 2007 21:44:03 -0700 (PDT)
Message-ID: <20070801.214403.21926765.davem@davemloft.net>
References: <20070802011735.a89bf72c.krzysztof.h1@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IGSXc-0002JM-AT for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Aug 2007 21:44:04 -0700
Received: from [74.93.104.97] (helo=sunset.davemloft.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IGSXb-0000kR-AA
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Aug 2007 21:44:03 -0700
In-Reply-To: <20070802011735.a89bf72c.krzysztof.h1@wp.pl>
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
To: krzysztof.h1@wp.pl
Cc: linux-fbdev-devel@lists.sourceforge.net

From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Thu, 2 Aug 2007 01:17:35 +0200

> This patch requires both cg6-cleanup and cg6-fbmem-size-fix patches
> to apply cleanly.

It doesn't apply cleanly.

> +/**
>   *	cg6_imageblit -	Copies a image from system memory to the screen.
>   *
>   *	@info: frame buffer structure that represents a single frame buffer

That's not what the comment baove cg6_imageblit() looks like
with all the patches applied, instead it looks like:

/**
 *      cg6_imageblit - REQUIRED function. Can use generic routines if
 *                      non acclerated hardware and packed pixel based.
 *                      Copies a image from system memory to the screen. 
 *
 *      @info: frame buffer structure that represents a single frame buffer
 *      @image: structure defining the image.
 */

Perhaps we are speaking of two different cg6-cleanup patches.

In any event, I'll add this patch in by hand.

Please just submit SBUS framebuffer driver fixes directly to me since
I'm constantly fixing errors in these drivers on my own as well and
it's easier for me to resolve the conflicts.

Thanks.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
