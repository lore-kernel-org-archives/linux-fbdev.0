From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: cfb* routines and high mem
Date: Mon, 22 Sep 2003 09:48:45 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030922164845.42403.qmail@web14914.mail.yahoo.com>
References: <Pine.GSO.4.21.0309220923020.4957-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A1Trm-0007E4-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Sep 2003 09:48:50 -0700
Received: from web14914.mail.yahoo.com ([216.136.225.241])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A1Tri-0001Ck-3p
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Sep 2003 09:48:46 -0700
In-Reply-To: <Pine.GSO.4.21.0309220923020.4957-100000@vervain.sonytel.be>
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
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

We have to do something about the ioremap of large framebuffers in 2.6. Right
now in 2.6, if you have 1GB or more RAM most framebuffers will fail to load.
With the price of memory falling 1GB will become common during the life of 2.6.

The failure is caused by the individual framebuffer drivers ioremap'ing the
framebuffer into kernel address space. With 1GB memory or more it is almost a
certainty that there is not enough kernel address space available.  Even my
16MB cards fail to load.

I believe the best solution to this is to push the ioremap and all fb access
down into fbconsole. This will localize it to a single point. Then modify
fbconsole to map the framebuffer into high mem address space. All accesses to
the high mem framebuffer will need to be bracketed by the high mem access
marcos. I also don't think the kernel has a high mem ioremap() so one will need
to be written.

Will this work for the penguin code?
Are there non-cfb drivers? How hard would it be to convert them?
Is there another solution to the problem?

Don't we pretty much have to do this? I don't think we can just ignore it. 

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
