From: John Zielinski <grim@undead.cc>
Subject: Re: Running frame buffer programs using a VGA
 console?
Date: Sat, 29 Nov 2003 16:11:29 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FC90B81.30406@undead.cc>
References: <Pine.GSO.4.21.0311292147300.22995-100000@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AQCNS-0004MC-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 29 Nov 2003 13:11:42 -0800
Received: from gw-undead3.tht.net ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AQCNR-0001Km-U8
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 29 Nov 2003 13:11:42 -0800
In-Reply-To: <Pine.GSO.4.21.0311292147300.22995-100000@waterleaf.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Geert Uytterhoeven wrote:

>I meant that you can't use the KDSETMODE ioctl if there's no console attached
>to the frame buffer device.
>  
>
Ok.  My last patched fixed that.  I tried it using a remote ssh 
connection and it worked perfectly.

What's happening here is that the radeon driver doesn't switch the 
card's video mode when I run the test.  The fbtest program also shows a 
limited set of capabilities (no color modes) when I run it and aborts 
with a signal 11.  It also kills the VGA font since I'm not saving video 
memory anymore.   I noticed the other drivers do a VGA save/restore when 
they are opened or closed.

Time to look at the code some more...

John





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
