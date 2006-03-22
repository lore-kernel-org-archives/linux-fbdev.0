From: Thomas Arendsen Hein <thomas@intevation.de>
Subject: cyblafb in kernel 2.6.16: corrupted display in Xfree86
Date: Thu, 23 Mar 2006 00:48:12 +0100
Message-ID: <20060322234812.GB2361@intevation.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMD3p-0007EU-OK
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 22 Mar 2006 15:48:17 -0800
Received: from aktaia.intevation.org ([212.95.126.10] helo=mail.intevation.de)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FMD3o-0007FL-HM
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 22 Mar 2006 15:48:17 -0800
Received: from localhost (localhost [127.0.0.1])
	by mail.intevation.de (Postfix) with ESMTP id 764DC36DC3
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Mar 2006 00:48:15 +0100 (CET)
Received: from intevation.de (eukrante.hq [192.168.11.14])
	by mail.intevation.de (Postfix) with SMTP id BDA6B36D6F
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Mar 2006 00:48:12 +0100 (CET)
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: linux-fbdev-devel@lists.sourceforge.net

Hi!

The cyblafb driver workes fine for me up to Linux kernel 2.6.15.6,
but with 2.6.16 I get the following problem:

After booting the system, the framebuffer console comes up fine, but
when xdm starts up the X server, I get this diplay:
http://ftp.intevation.de/users/thomas/cyblafb/cyblafb-1.jpg

After switching to the console with Ctrl-Alt-F1 and back to X:
http://ftp.intevation.de/users/thomas/cyblafb/cyblafb-2.jpg

When I use Ctrl-Alt-Backspace to restart xdm everything looks fine:
http://ftp.intevation.de/users/thomas/cyblafb/cyblafb-3.jpg

I use Debian sarge on a Lex Light (CV860A board):
0000:01:00.0 VGA compatible controller: Trident Microsystems CyberBlade/i1 (rev 6a) (prog-if 00 [VGA])
        Subsystem: Trident Microsystems CyberBlade/i1
        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 5
        Memory at e4000000 (32-bit, non-prefetchable) [size=8M]
        Memory at e5000000 (32-bit, non-prefetchable) [size=128K]
        Memory at e4800000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at 10000000 [disabled] [size=64K]
        Capabilities: <available only to root>


Resolution 1152x864 pixels (16 bpp) with fbdev driver in XF86Config-4.

/etc/fb.modes:
mode "1152x864-70"
    # D: 100.0 MHz, H: 66.138 kHz, V: 69.99 Hz
    geometry 1152 864 1152 864 8
    timings 10000 168 40 57 13 152 11
    hsync high
    vsync high
endmode

To enable this resolution I use:

/etc/rcS.d/S42cyblafb:
/sbin/modprobe cyblafb bpp=16 mode=1024x768 ref=85 && /usr/sbin/fbset -a 1152x864-70
(because the cyblafb driver doesn't understand mode=1152x864 as parameter)

XFree86 is standard Debian sarge: 4.3.0.dfsg.1-14sarge1

One further thing to note is that I compiled 2.6.15.6 with gcc
2.95.4 and 2.6.16 with gcc 3.4.3, can this make a difference?

Any idea what's happening here?

Regards,
Thomas

-- 
Email: thomas@intevation.de
http://intevation.de/~thomas/


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
