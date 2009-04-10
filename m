From: Dave Airlie <airlied@linux.ie>
Subject: Re: intelfb-support-i854.patch
Date: Fri, 10 Apr 2009 09:42:23 +0100 (IST)
Message-ID: <alpine.DEB.2.00.0904100941380.27029@skynet.skynet.ie>
References: <20090410073651.365197DC943@f47.poczta.interia.pl>
	<20090410010528.09e0e153.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <airlied@linux.ie>) id 1LsCJj-000343-D8
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Apr 2009 08:42:31 +0000
Received: from gir.skynet.ie ([193.1.99.77])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LsCJf-00045j-53
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Apr 2009 08:42:31 +0000
In-Reply-To: <20090410010528.09e0e153.akpm@linux-foundation.org>
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
Cc: Stefan Husemann <shusemann@googlemail.com>, Keith Packard <keithp@keithp.com>, linux-fbdev-devel@lists.sourceforge.net

On Fri, 10 Apr 2009, Andrew Morton wrote:

> On 10 Apr 2009 09:36:50 +0200 krzysztof.h1@poczta.fm wrote:
> 
> > Andrew Morton napisa__(a):
> > > 
> > > Guys, I&#039;ve been sitting on this patch for ages because there was some
> > > issue wrt interactions with drm (iirc).
> > > 
> > > Could you please refresh our memories on what the problem was and help
> > > find the resolution here?
> > > 
> > 
> > I have searched on the google and there were never a comment about the patch. It just went unnoticed.
> > 
> > It seems safe (only ids are added). The only possible regression is that drm is broken on i854 that previously was not recognized at all.
> > 
> 
> hm, I'm sure that someone had issues, but I grepped all my email and
> can't find it.
> 
> Oh well, I guess I'll just merge it and see what happens.

Well I think I jsut had my usual objections to adding anything to intelfb,

but I'll grab the agp/drm additions which should be fine.

Dave.

> 
> 

------------------------------------------------------------------------------
This SF.net email is sponsored by:
High Quality Requirements in a Collaborative Environment.
Download a free trial of Rational Requirements Composer Now!
http://p.sf.net/sfu/www-ibm-com
