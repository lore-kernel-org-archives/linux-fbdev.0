From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] - video/hgafb.c warning fix.
Date: Wed, 14 Apr 2004 19:00:51 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404141900240.13481-100000@phoenix.infradead.org>
References: <20040414143053.2210fbe9.lcapitulino@prefeitura.sp.gov.br>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BDohO-0000TN-FT
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Apr 2004 11:01:22 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BDohN-0002eu-Ug
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Apr 2004 11:01:22 -0700
In-Reply-To: <20040414143053.2210fbe9.lcapitulino@prefeitura.sp.gov.br>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
Cc: kronos@kronoz.cjb.net, benh@kernel.crashing.org, linux-fbdev-devel@lists.sourceforge.net


> Kronos <kronos@kronoz.cjb.net> escreveu:
> 
> | Il Tue, Apr 13, 2004 at 04:45:34PM -0300, Luiz Fernando N. Capitulino ha scritto: 
> | > 
> | > Hi,
> | > 
> | >  I'm getting the fallowing warnings:
> | > 
> | > drivers/video/hgafb.c:452: warning: `hgafb_fillrect' defined but not used
> | > drivers/video/hgafb.c:472: warning: `hgafb_copyarea' defined but not used
> | > drivers/video/hgafb.c:502: warning: `hgafb_imageblit' defined but not used
> | > 
> | >  They are caused by dead code, this patch remove then:
> | 
> | Please don't do that. The functions that you are removing are
> | accelerated helpers. Don't know why they are not in use ATM (lack of
> | testing?) If you want to remove the warning wrap the code with #if 0 /
> | #endif
> 
>  Ok, my first version to Andrew used #if 0 / #end, but as he said to send to
> the mantainers, so I thought it could be removed.
> 
>  Will rediff.

Its a matter of not testings. I haven't got around to it. 



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
