From: Ian Campbell <icampbell@arcom.com>
Subject: Re: Re: [PATCH] PXA255 LCD Driver
Date: Sat, 20 Mar 2004 11:24:50 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1079781858.3148.2.camel@localhost>
References: <1079607908.2175.67.camel@icampbell-debian>
	 <Pine.LNX.4.44.0403192352580.14905-100000@phoenix.infradead.org>
	 <20040320090607.A27266@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B4eb5-0003mu-0W
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 20 Mar 2004 03:24:59 -0800
Received: from mta04-svc.ntlworld.com ([62.253.162.44])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B4eb2-0001RY-Go
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 20 Mar 2004 03:24:56 -0800
Received: from cthulhu.hellion.org.uk ([80.6.127.103])
          by mta04-svc.ntlworld.com
          (InterMail vM.4.01.03.37 201-229-121-137-20020806) with ESMTP
          id <20040320112432.FIWJ4168.mta04-svc.ntlworld.com@cthulhu.hellion.org.uk>
          for <linux-fbdev-devel@lists.sourceforge.net>;
          Sat, 20 Mar 2004 11:24:32 +0000
In-Reply-To: <20040320090607.A27266@flint.arm.linux.org.uk>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2004-03-20 at 09:06, Russell King wrote:
> It's fairly common to have one LCD controller appear in many different
> devices (because its part of the CPU) and have the same display, yet
> need different timing.

This was something that I was worried about -- it seems like this sort
of thing would negate any benefit from building a database of panels for
general use.

Perhaps it would be posible to build a database of panels as described
in their datasheets. Boards which have a CPLD could perhaps define a
per-board fixup function, since they know the sync lines are inverted or
whatever.

I'm not sure though -- my experience is with our board which has a
PXA255 and no CPLD messing with the display controller stuff. I'm wary
of coming up with a solution which is only useful to me and noone
else...

Ian.
-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road,                    Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom       Phone:  +44 (0)1223 411 200




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
