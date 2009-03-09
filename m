From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] remove cyblafb driver
Date: Mon, 9 Mar 2009 22:58:20 +0100
Message-ID: <20090309225820.0bfea4a8.krzysztof.h1@poczta.fm>
References: <20090307234902.55295e2c.krzysztof.h1@poczta.fm>
	<20090309133432.ac6173cd.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1LgnOi-0007Q1-G1
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Mar 2009 21:52:32 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LgnOZ-0006r8-LX for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Mar 2009 21:52:32 +0000
In-Reply-To: <20090309133432.ac6173cd.akpm@linux-foundation.org>
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
Cc: jani@ubuntu.com, linux-fbdev-devel@lists.sourceforge.net, Knut_Petersen@t-online.de

On Mon, 9 Mar 2009 13:34:32 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Sat, 7 Mar 2009 23:49:02 +0100
> Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:
> 
> > A tridentfb driver has all functionality
> > of the cyblafb driver without bugs of
> > the latter.
> 
> So what are the implications of this for users?  They'll do an
> `oldconfig', will discover that their driver isn't there any more and
> will then need to dig around through commit messges to find out what
> happened to it?
> 
> I guess we can live with that, and I can't immediately think of a way
> of improving their lives, so ho hum..
> 
> 
> 

Well, a good stop gap is to rename a Kconfig option from
 "Trident support" to "Trident and CyberBlade support". It
should help find a new driver to users.

Regards,
Krzysztof


----------------------------------------------------------------------
Udar sloneczny prezesa Kaczynskiego... >>> http://link.interia.pl/f2083


------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
