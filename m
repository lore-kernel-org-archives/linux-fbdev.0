From: "vivens" <vivens@berflo.dhs.org>
Subject: RE: (no subject)
Date: Tue, 10 Dec 2002 22:05:59 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <001301c2a08f$f49d9250$3c01a8c0@berflo.lan>
References: <Pine.LNX.4.33.0212101031010.2617-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from fia64-72.dsl.hccnet.nl ([62.251.72.64] helo=flatrix.berflo.lan)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18LraH-0006pW-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 10 Dec 2002 13:06:29 -0800
In-Reply-To: <Pine.LNX.4.33.0212101031010.2617-100000@maxwell.earthlink.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: 'James Simmons' <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Well, I mend it like this:
I'm trying to build a framebuffer for an embedded ARM platform (which
doesn't use any kind of a Lunix distr).
I want to use a framebuffer, because some apps need it. For example the
ZEN browser I want to implement on this platform.
So my question is:
What basic functions does a framebuffer normally have, what is need to
initialize for these functions?
Can I see the framebuffer as the API between the video hardware and any
application what uses the video hardware?

Whit kind regards,
Vincent Ivens


-----Original Message-----
From: linux-fbdev-devel-admin@lists.sourceforge.net
[mailto:linux-fbdev-devel-admin@lists.sourceforge.net] On Behalf Of
James Simmons
Sent: dinsdag 10 december 2002 19:32
To: Vincent Ivens
Cc: linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] (no subject)


> New to the list, is this an appropriate place to ask basic question
about
> framebuffer divices?
>
> for example:
> what are the basic funtions i can expect in a framebuffer?

WHat do you mean? Functionality from a userland perspective or from
inside
the kernel. Which version of the kernel are you looking at?




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel




-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
