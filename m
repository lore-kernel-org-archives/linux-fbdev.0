From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Reading the EDID block for x86 machines
Date: Mon, 17 Mar 2003 11:33:38 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030317193338.94491.qmail@web14908.mail.yahoo.com>
References: <1047883995.1234.7.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14908.mail.yahoo.com ([216.136.225.60])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18v0Mc-0000eZ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 17 Mar 2003 11:33:38 -0800
In-Reply-To: <1047883995.1234.7.camel@localhost.localdomain>
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

--- Antonino Daplas <adaplas@pol.net> wrote:
> You're talking about other device's expansion ROM's.
>  VGA ROM's,
> especially for the x86, are an exception and has to
> be always mapped at
> c000:0000.

Reboot and add pci=rom (case sensitive) to your kernel
parameters. That will show you where the video ROMs
are really located.

My x86 PC's boot video ROM is located at dd000000 not
C00000. C00000 is only a copy of the ROM in RAM.

01:00.0 VGA compatible controller: ATI Technologies
Inc Radeon R250 If [Radeon 9
000] (rev 01) (prog-if 00 [VGA])
        Subsystem: C.P. Technology Co. Ltd: Unknown
device 2039
        Flags: stepping, 66Mhz, medium devsel, IRQ 5
        Memory at d0000000 (32-bit, prefetchable)
[disabled] [size=64M]
        I/O ports at c000 [disabled] [size=256]
        Memory at de000000 (32-bit, non-prefetchable)
[disabled] [size=64K]
        Expansion ROM at dd000000 [size=128K]
        Capabilities: [58] AGP version 2.0
        Capabilities: [50] Power Management version 2

The ROM on my other video card is located here:

00:0b.0 VGA compatible controller: ATI Technologies
Inc Rage 128 PD/PRO TMDS (pr
og-if 00 [VGA])
        Subsystem: ATI Technologies Inc Rage 128 AIW
        Flags: bus master, stepping, medium devsel,
latency 32, IRQ 10
        Memory at d8000000 (32-bit, prefetchable)
[size=64M]
        I/O ports at e400 [size=256]
        Memory at df000000 (32-bit, non-prefetchable)
[size=16K]
        Expansion ROM at 20060000 [size=128K]
        Capabilities: [5c] Power Management version 2

> Remember, ROM's are supposed to be read-only, so
> even if they are
> shadowed, the BIOS write protects it.

How is this write protection being achieved? Is it
done via manipulation of the processor descriptor
tables; if so just undo it.


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
