From: Jon Smirl <jonsmirl@yahoo.com>
Subject: real mode entry points for PCI BIOS
Date: Tue, 11 Mar 2003 18:42:24 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030312024224.82402.qmail@web14908.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14908.mail.yahoo.com ([216.136.225.60])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18swCG-0005ZO-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 Mar 2003 18:42:24 -0800
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
To: Antonino Daplas <adaplas@pol.net>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

http://www.delorie.com/djgpp/doc/rbinter/ix/1A/B1.html
The class for video displays is 3

It should be possible to make this work. Do you have a
PCI video card that you can install along with an AGP
one? Future PCI-X allows as many video cards as you
want so we need something along these lines. This
would also solve a lot of problems in framebuffer
development.

The reset program I sent earlier shows how to disable
VGA ports and copy INT vectors, etc. It also shows how
to enable the ROMs (writing to PCI config space).
Video ROMs needs to be copied to RAM before being
executed or they won't run. The BIOS did this to the
primary adapter's ROM for you.

Is it possible to allocate an entire page for DDC
info? At 512 bytes that would support eight video
cards. When the framebuffer driver loads how is it
going to find the page with the DDC info? How does it
know which info goes to which card?

This approach should work crossplatform. The
equivalent code will need to be written for each architecture.

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________________________
Do you Yahoo!?
Yahoo! Web Hosting - establish your business online
http://webhosting.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
