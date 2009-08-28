From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: open and close semanthics
Date: Fri, 28 Aug 2009 11:43:28 +0200
Message-ID: <4A97A6C0.1000006@gmx.de>
References: <4A946A59.20307@manoweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <FlorianSchandinat@gmx.de>) id 1Mgxzd-0007PW-SA
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Aug 2009 09:43:37 +0000
Received: from mail.gmx.net ([213.165.64.20])
	by 29vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1MgxzY-0007fR-Oo for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Aug 2009 09:43:37 +0000
In-Reply-To: <4A946A59.20307@manoweb.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Alessio Sangalli <alesan@manoweb.com>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

Hi,

this is not authoritative but I hope that's better than no answer:

Alessio Sangalli schrieb:
> Hi, can somebody give me an authoritative answer:
> what is the semanthics associated to the "open" and "release" (close) calls?
> 
> More specifically, "open" and "release" can/must/must not change any 
> setting (resolution etc)?
> 
> Should those functions keep a "counter" of how many programs opened it?

I'd say that's not well defined. skeletonfb lists them even as optional. 
I've read that some drivers use it for mode changes, some keep counters 
and others just return 0.
If you are writing a driver: use it as you need it or don't use it at all.
If you write something that needs this behavior: there is none you can 
expect along all drivers, sorry.

For more information:
http://www.linux-fbdev.org/HOWTO/4.html
<linux kernel tree>/drivers/video/skeletonfb.c


Regards,

Florian Tobias Schandinat

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
