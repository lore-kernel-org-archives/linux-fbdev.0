From: krzysztof.h1@poczta.fm
Subject: Re: [RFC 2.6.26-rc3 06/10] gumstix: conversion
	to MFP support and add bluetooth support
Date: 31 Jul 2008 11:59:10 +0200
Message-ID: <20080731095910.DEF5C45B81F@f49.poczta.interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KOUwI-0007kk-0h for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 Jul 2008 02:59:18 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KOUwG-0000VW-Jy
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 Jul 2008 02:59:18 -0700
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
To: Andrew Morton <akpm@linux-foundation.org>, Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: "ymiao3@marvell.com" <ymiao3@marvell.com>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

> On Thu, 12 Jun 2008 12:59:17 -0400 Jaya Kumar <jayakumar.lkml@gmail.com>
> wrote:
> 
> > This patch converts gumstix over to the MFP configuration system and
> adds
> > bluetooth support. Added a CLK_32K clock to enable bluetooth.
> 
> Please be aware that the regular fbdev maintainer (Tony) has been out
> of contact for many months and that I very rarely read
> linux-fbdev-devel.  So if/when you have fbdev patches which need
> attention, please cc myself directly.
> 

Andrew,

Please skip Jaya patches. He sents them to arm-linux and fbdev-devel and got
reviews from me and Eric Miao (I review and Ack only fb related patches, so the gumstix
patch must be acked by Eric Miao).

He fixed and reposted this set few times. The latest repost is here:
http://marc.info/?l=linux-fbdev-devel&m=121742676828595&w=2

However, according to Jaya's answer he wants to push this patches through the arm tree (RMK's patch system):
http://marc.info/?l=linux-fbdev-devel&m=121734957011562&w=2

Any repost of the set to the fbdev-devel will be reviewed by me.

Regards,
Krzysztof
PS. As you are looking through the fbdev-devel, if you wants any old forgotten patch to be reviewed cc it to me and I will do today or tomorrow. I have some time for reviews as I stopped developing new crashes^Wfeatures for now ;-)


----------------------------------------------------------------------
Lubisz zagadki? Zagraj w puzzle na Smaker.pl!
Kliknij >>> http://link.interia.pl/f1eb0


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
