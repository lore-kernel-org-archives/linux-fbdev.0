From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Reading the EDID block for x86 machines
Date: Mon, 17 Mar 2003 15:41:43 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030317234143.79388.qmail@web14914.mail.yahoo.com>
References: <1047940105.3693.40.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14914.mail.yahoo.com ([216.136.225.241])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18v4Ei-0004fN-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 17 Mar 2003 15:41:44 -0800
In-Reply-To: <1047940105.3693.40.camel@localhost.localdomain>
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

The C000 must be a PCI restriction, it was not there
during ISA days.

Plan A: how is C000:0 protected; does the chipset
hardware do it or is it done via the descriptor
tables? Descriptor tables can be fixed but there is
probably no general solution to chipset protection. 

On the other hand, we may be lucky and the PCI spec
has specified a standard way for enabling write
protect. Could there be a BIOS INT xx function for
this?

Plan B is to copy the ROM to something like 8000 or
9000. But the question there is, are VBIOS ROMs still
written to run position independent give the PCI C000
requirement?

Plan C is go into VM86 mode during early boot and
remap the memory.

Plan D would be to get enough info to write the code
in protected mode.

Are there more ways to do this?

I'll go poke around in google and see what I can come
up with. Let me know if you come up with anything.

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________________________
Do you Yahoo!?
Yahoo! Platinum - Watch CBS' NCAA March Madness, live on your desktop!
http://platinum.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
