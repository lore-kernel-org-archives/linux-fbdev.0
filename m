From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Reading the EDID block for x86 machines
Date: Tue, 11 Mar 2003 14:05:39 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030311220539.20321.qmail@web14912.mail.yahoo.com>
References: <1047418384.1100.5.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14912.mail.yahoo.com ([216.136.225.248])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18srsS-0002ar-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 Mar 2003 14:05:40 -0800
In-Reply-To: <1047418384.1100.5.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>, James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

If your in messing with the early boot sequence, why
don't you make the kernel initialize all of the video
cards in the system instead of only the primary one.

Alsom is it really better to continue messing with
these real mode X86 BIOS calls, or would it just be
better to try and extract the info from the card
vendors on how to do reset or get the DDC info? If we
had the info about the cards we could just ignore the
VBIOS and write this code into the protected mode FB
drivers where it belongs. This problem just keeps
recurring over and over on the non-X86 platforms; it's
stupid having to carry around an X86 emulator just to
run the VBIOS code.

Personally I'd like to be able to insmod a fb driver
for a secondary card. If the card needs it, it would
get initialized, read the DDC data, and come up in a
mode that makes sense.

I have a user space program that can reset secondary
cards using their VBIOS and emulating X86 real mode.
It can probably be easily modified to get the DDC info
and then IOCTL it into the fb driver. I'll post it if
you want.

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
