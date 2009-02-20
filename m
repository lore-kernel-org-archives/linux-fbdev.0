From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] cirrusfb: do not calculate line
	length twice
Date: Thu, 19 Feb 2009 16:27:54 -0800
Message-ID: <20090219162754.d175d6c0.akpm@linux-foundation.org>
References: <20090214185045.c288650e.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1LaJG7-0001Sr-6n
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 20 Feb 2009 00:28:51 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LaJG3-0004O2-6v
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 20 Feb 2009 00:28:51 +0000
In-Reply-To: <20090214185045.c288650e.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: arthur.marsh@internode.on.net, linux-fbdev-devel@lists.sourceforge.net

On Sat, 14 Feb 2009 18:50:45 +0100
Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:

> A line length is calculated twice: first in
> the cirrusfb_decode_var() then in 
> the cirrusfb_set_par_foo().
> 
> Use the first calculated value. A nice side
> effect is that 32bpp mode works now.

Do you get these as well?

drivers/video/cirrusfb.c: In function 'cirrusfb_set_par_foo':
drivers/video/cirrusfb.c:663: warning: 'format' may be used uninitialized in this function
drivers/video/cirrusfb.c:663: warning: 'threshold' may be used uninitialized in this function
drivers/video/cirrusfb.c:663: warning: 'control' may be used uninitialized in this function

they're false positives, but it would be nice to squash them somehow.


------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
