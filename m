From: Ian Molton <spyro@f2s.com>
Subject: Re: [RESEND][PATCH 1/2] fbdev: add new TMIO
 framebuffer driver
Date: Fri, 03 Oct 2008 12:35:53 +0100
Message-ID: <48E60399.4010302@f2s.com>
References: <1222763910-22816-1-git-send-email-dbaryshkov@gmail.com>
	<20081003022323.a523a510.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <spyro@f2s.com>) id 1KljMx-0004fh-Cu
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 03 Oct 2008 12:02:51 +0000
Received: from mk-outboundfilter-3.mail.uk.tiscali.com ([212.74.114.23])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KljMr-0000IL-M7 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 03 Oct 2008 12:02:51 +0000
In-Reply-To: <20081003022323.a523a510.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>, Samuel Ortiz <sameo@openedhand.com>, linux-fbdev-devel@lists.sourceforge.net

Andrew Morton wrote:

> I realise it isn't your code, but these:
> 
> #define tmio_ioread32(addr) \

...are my fault. Sorry about that.

> As is so often the case, these never needed to be implemented as macros
> and hence should not have been.  C is better.

Good point, well made. I'm happy for them to be changed to inline 
functions. They grew out of the MMC code, where they were used to clean 
up the IO transfer loops. I'll send a patch to Samuel for his MFD tree 
to effect this change.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
