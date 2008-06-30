From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 13/13] viafb: via_utility.c,
 via_utility.h, vt1636.c, vt1636.h
Date: Mon, 30 Jun 2008 10:44:07 +0100
Message-ID: <20080630104407.6adf59ab@lxorguk.ukuu.org.uk>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB8074E78BE@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KDGCm-0005rv-3y for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Jun 2008 03:01:52 -0700
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]
	helo=lxorguk.ukuu.org.uk)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KDGCl-0006CM-Cc
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Jun 2008 03:01:51 -0700
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB8074E78BE@exchtp03.taipei.via.com.tw>
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
Cc: JosephChan@via.com.tw, geert@linux-m68k.org, akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

> +void get_gamma_table(unsigned int *gamma_table)

Still more globals with names asking to cause clashes

> +{
> +	unsigned char color_r[256];
> +	unsigned char color_g[256];
> +	unsigned char color_b[256];
> +	unsigned char sr1a = 0;

and possibly excesive stack usage


I think at this point however the code is in a state where it would be
more productive to merge it and then fix up the remaining smaller details
than keep going round back to VIA to change it internally and return.

So

Acked-by: Alan Cox <alan@redhat.com>  - for the patch series, subject to
further tidyups getting done after it is all merged.

Alan

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
