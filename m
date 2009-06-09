From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] atmel_lcdfb: Correct fifo size for
	some products
Date: Mon, 8 Jun 2009 17:21:21 -0700
Message-ID: <20090609002121.GA22622@suse.de>
References: <4A0D452A.4000805@atmel.com>
	<20090528003526.542d306e.akpm@linux-foundation.org>
	<4A2D2FF4.1010304@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gregkh@suse.de>) id 1MDprE-00068t-8o
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 09 Jun 2009 01:10:32 +0000
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MDpqF-0003lf-1f
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 09 Jun 2009 01:10:32 +0000
Content-Disposition: inline
In-Reply-To: <4A2D2FF4.1010304@atmel.com>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, Andrew Victor <avictor.za@gmail.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>

On Mon, Jun 08, 2009 at 05:36:20PM +0200, Nicolas Ferre wrote:
> Andrew Morton :
> > On Fri, 15 May 2009 12:34:18 +0200 Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> > 
> >> Remove wrong fifo size definition for some AT91 products.
> >>
> >> Due to a misunderstanding of some AT91 datasheets, a fifo size of 2048 (words)
> >> has been introduced by mistake. In fact, all products (AT91/AT32) are sharing
> >> the same fifo size of 512 words.
> >>
> > 
> > Changelog fails to describe the impact of the bug, so people who are
> > working out which kernel versions it should be ported into don't know
> > what to do.
> > 
> > Furthermore, people who are hitting a bug in this driver in older
> > kernel versions will have difficulty working out whether this patch
> > might fix their bug.
> 
> Ok, you are right, I will try to add some information.
> 
> In fact, if you mis-configure the fifo watermark making it too high you
> end without the capacity of issuing burst transfers on the internal AHB
> bus. This will decrease overall system performance as the LCD will ask
> for data as soon as the fifo will have one byte available (not efficient
> single accesses).
> 
> >> Can we consider this fix for .30-final ?
> > 
> > Sure, but for what reason?
> > 
> > What about 2.6.29.x, 2.6.28.x, earlier?
> 
> Indeed, should be valuable to extend this correction to stable kernel
> series. I added Greg to the loop for this purpose.

For stable stuff, please send any requested patches, with the git commit
id of the patch in Linus's tree, to stable@kernel.org, otherwise I might
miss it :)

Also, you can add:
	Cc: stable <stable@kernel.org>
to the signed-off-by area of the patch, and when it is taken into
Linus's tree, the stable team will automatically get notified of it and
include it in the next stable releases without any other work needed to
be done by you.

hope this helps,

greg k-h

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
