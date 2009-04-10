From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: intelfb-support-i854.patch
Date: Fri, 10 Apr 2009 01:05:28 -0700
Message-ID: <20090410010528.09e0e153.akpm@linux-foundation.org>
References: <20090410073651.365197DC943@f47.poczta.interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1LsBn0-0003II-92
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Apr 2009 08:08:42 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LsBmt-0004RH-GA
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Apr 2009 08:08:39 +0000
In-Reply-To: <20090410073651.365197DC943@f47.poczta.interia.pl>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: krzysztof.h1@poczta.fm
Cc: Dave Airlie <airlied@linux.ie>, Stefan Husemann <shusemann@googlemail.com>, Keith Packard <keithp@keithp.com>, linux-fbdev-devel@lists.sourceforge.net

On 10 Apr 2009 09:36:50 +0200 krzysztof.h1@poczta.fm wrote:

> Andrew Morton napisa__(a):
> > 
> > Guys, I&#039;ve been sitting on this patch for ages because there was some
> > issue wrt interactions with drm (iirc).
> > 
> > Could you please refresh our memories on what the problem was and help
> > find the resolution here?
> > 
> 
> I have searched on the google and there were never a comment about the patch. It just went unnoticed.
> 
> It seems safe (only ids are added). The only possible regression is that drm is broken on i854 that previously was not recognized at all.
> 

hm, I'm sure that someone had issues, but I grepped all my email and
can't find it.

Oh well, I guess I'll just merge it and see what happens.

------------------------------------------------------------------------------
This SF.net email is sponsored by:
High Quality Requirements in a Collaborative Environment.
Download a free trial of Rational Requirements Composer Now!
http://p.sf.net/sfu/www-ibm-com
