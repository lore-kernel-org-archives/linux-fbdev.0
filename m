From: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Subject: Re: [PATCH] atmel_lcdfb: Correct fifo size for
	some products
Date: Tue, 19 May 2009 10:02:01 +0200
Message-ID: <20090519100201.775d844b@hskinnemoen-d830>
References: <4A0D452A.4000805@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <haavard.skinnemoen@atmel.com>) id 1M6KyL-0007s1-Np
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 May 2009 08:46:53 +0000
Received: from relay.atmel.no ([80.232.32.139])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M6KyB-0006Ea-F3
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 May 2009 08:46:53 +0000
In-Reply-To: <4A0D452A.4000805@atmel.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Haavard, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, Andrew Victor <avictor.za@gmail.com>, Skinnemoen <hskinnemoen@atmel.com>

Nicolas Ferre wrote:
> Remove wrong fifo size definition for some AT91 products.
> 
> Due to a misunderstanding of some AT91 datasheets, a fifo size of 2048 (words)
> has been introduced by mistake. In fact, all products (AT91/AT32) are sharing
> the same fifo size of 512 words.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> Can we consider this fix for .30-final ?

Fine by me as it doesn't affect AVR32 in any way.

Haavard

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
