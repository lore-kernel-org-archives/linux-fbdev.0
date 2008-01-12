From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: Re: [PATCH] pm3fb: fix section mismatch warnings
Date: Sat, 12 Jan 2008 05:18:29 +0100
Message-ID: <20080112051829.b43a328b.krzysztof.h1@wp.pl>
References: <20080111170401.694b066f.rdunlap@xenotime.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JDXlp-0004M1-3F for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 11 Jan 2008 20:14:57 -0800
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JDXln-0007xR-I3
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 11 Jan 2008 20:14:57 -0800
Received: from host-87-99-61-239.lanet.net.pl (HELO krzysio.net)
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	12 Jan 2008 05:14:50 +0100
In-Reply-To: <20080111170401.694b066f.rdunlap@xenotime.net>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: samr <sam@ravnborg.org>, Randy Dunlap <rdunlap@xenotime.net>, romain@dolbeau.org, akpm <akpm@linux-foundation.org>, adaplas@gmail.com

On Fri, 11 Jan 2008 17:04:01 -0800
Randy Dunlap <rdunlap@xenotime.net> wrote:

> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Add __devinit to one function to clean up section mismatch warnings:
> 
> 
>  /* mmio register are already mapped when this function is called */
>  /* the pm3fb_fix.smem_start is also set */
> -static unsigned long pm3fb_size_memory(struct pm3_par *par)
> +static unsigned long __devinit pm3fb_size_memory(struct pm3_par *par)
>  {

Exactly the same patch is already in the -mm tree (by Adrian Bunk):
drivers-video-pm3fbc-section-fix.patch

Regards,
Krzysztof

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
