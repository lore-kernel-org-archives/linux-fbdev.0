From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Re: mode setting and console locking, nvidia failure
Date: Mon, 17 May 2004 20:38:11 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040518033811.3221.qmail@web14930.mail.yahoo.com>
References: <20040518030008.43467.qmail@web14925.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPvQi-0001Ka-3s
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 May 2004 20:38:12 -0700
Received: from web14930.mail.yahoo.com ([216.136.225.159])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BPvQh-0001LU-Mx
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 May 2004 20:38:11 -0700
In-Reply-To: <20040518030008.43467.qmail@web14925.mail.yahoo.com>
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
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@yahoo.com>, James Simmons <jsimmons@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

I have a new clue.

From console:
modprobe radeonfb
rmmod radeonfb
works, there is a one line printk on rmmod displayed on console

From X:
modprobe radeonfb
rmmod radeonfb
works, there is a one line printk on rmmod logged

From X:
modprobe radeonfb
VT switch to console
rmmod radeonfb
system hangs, but is a little active Ctrl-Alt-Del prints a line.

Now remove the code that does the printk on exit
From X:
modprobe radeonfb
VT switch to console
rmmod radeonfb
works, line from printk is displayed.

One part of this has got to be a problem with the console semaphore.  That
semaphore should not be accessed from an fbdev driver. If you need to access if
from an fbdev driver then the fbdev design is broken. Think about the case with
multiple fbdev's loaded. Since we only have one console all of the fbdev can't
play with the semaphore. That semaphore needs to be controlled from fb/vgacon
and lock only the fbdev that is displaying the console, not the others.

Next experiment is to remove all reference to the console semaphore from my
fbdev driver.

=====
Jon Smirl
jonsmirl@yahoo.com


	
		
__________________________________
Do you Yahoo!?
SBC Yahoo! - Internet access at a great low price.
http://promo.yahoo.com/sbc/


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
