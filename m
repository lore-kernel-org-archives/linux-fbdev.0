From: Alex Bennee <kernel-hacker@bennee.com>
Subject: Memory corruption 2.4.21 caused by loading a console driver?
Date: 22 Aug 2003 19:01:08 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <6305.60059003091$1061575547@news.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from host81-152-26-251.range81-152.btcentralplus.com ([81.152.26.251] helo=cambridge.braddahead)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19qGDv-0003Sr-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 22 Aug 2003 11:01:19 -0700
Received: from localhost (localhost [127.0.0.1])
	by cambridge.braddahead (Postfix) with ESMTP id 4CC951C1E2
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 22 Aug 2003 19:01:09 +0100 (BST)
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Hi,

Hopefully this will get through the chunks of sobig responses. Anyway
onwards.

I've hit a problem with 2.4.21 where loading a console driver and
performing a simple action is causing memory corruption within the
kernel. To re-create the bug on my system I did:

insmod shcon_driver.o
clear > /dev/tty0

and then attempted to ssh into box (its an embedded system) causing a
kernel pageing fault at dcache.c:718 (due to a bad dentry pointer). I
cannot reproduce this fault on 2.4.20. Being suspicious of my own code
(the console driver) had gone mad and corrupted something I removed all
my code and left it as stubs. The actual act of clearing the console did
nothing in my code but still manages to cause this strangeness. However
I'm hoping someone could explain what the difference is between these
two traces (of doing the clear > /dev/tty0), one before loading a
console driver (which damages nothing) and one after. Why are they so
different? Especially considering clearing the screen is a few simple
ioctls?

Trace 1 (Before Loading Console Driver)

Before Loading the shcon driver
do_tty_write: func(8807fe00), tty(88385000), file(89f5b2e0),
buf(004ae008), count(22)

do_tty_write: func(8807fe00), tty(89d1d000), file(89f5b760),
buf(00468698), count(3)
do_tty_write: func(8807fe00), tty(88385000), file(89f5b2e0),
buf(004ae008), count(53)

do_tty_write: func(8807fe00), tty(89d1d000), file(89f5b760),
buf(00468698), count(3)
do_tty_write: func(8807fe00), tty(88385000), file(89f5b2e0),
buf(004ae008), count(43)

do_tty_write: func(8807fe00), tty(89d1d000), file(89f5b760),
buf(00468698), count(1)
do_tty_write: func(8807fe00), tty(88385000), file(89f5b2e0),
buf(004ae008), count(1)

vt_ioctl: cmd=0x5401, arg=0x7bfffd1c
vt_ioctl: cmd=0x5401, arg=0x7bfffcf8
vt_ioctl: cmd=0x5401, arg=0x7bfffc3c
tty_write: if(00000000), write(00000000,2956e000,7,00000020)
do_tty_write: func(8807fe00), tty(899b4000), file(88246aa0),
buf(2956e000), count(7)
do_tty_write: func(8807fe00), tty(88385000), file(89f5b2e0),
buf(004ae008), count(22)

Trace 2 (After Loadiing Console Driver)

After Loading the shcon driver
do_tty_write: func(8807fe00), tty(88385000), file(89f5b2e0),
buf(004ae008), count(22)

do_tty_write: func(8807fe00), tty(89d1d000), file(89f5b760),
buf(00468698), count(3)
do_tty_write: func(8807fe00), tty(88385000), file(89f5b2e0),
buf(004ae008), count(52)

do_tty_write: func(8807fe00), tty(89d1d000), file(89f5b760),
buf(00468698), count(3)
do_tty_write: func(8807fe00), tty(88385000), file(89f5b2e0),
buf(004ae008), count(66)

do_tty_write: func(8807fe00), tty(89d1d000), file(89f5b760),
buf(00468698), count(3)
do_tty_write: func(8807fe00), tty(88385000), file(89f5b2e0),
buf(004ae008), count(45)

do_tty_write: func(8807fe00), tty(89d1d000), file(89f5b760),
buf(00468698), count(1)
do_tty_write: func(8807fe00), tty(88385000), file(89f5b2e0),
buf(004ae008), count(1)

vt_ioctl: cmd=0x5401, arg=0x7bfffd1c
vt_ioctl: cmd=0x5401, arg=0x7bfffcf8
vt_ioctl: cmd=0x5401, arg=0x7bfffc3c
tty_write: if(00000000), write(00000000,2956e000,7,00000020)
do_tty_write: func(8807fe00), tty(899b4000), file(899c50a0),
buf(2956e000), count(7)
shcon_driver:Called shcon_cursor
do_tty_write: func(8807fe00), tty(88385000), file(89f5b2e0),
buf(004ae008), count(22)

Is anyone else using loadable modules for console drivers and noticed
anything like this from 2.4.20 to 2.4.21?

Regards,


-- 
Alex, homepage: http://www.bennee.com/~alex/
"...[Linux's] capacity to talk via any medium except smoke signals."
(By Dr. Greg Wettstein, Roger Maris Cancer Center)



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
