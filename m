From: John Zielinski <grim@undead.cc>
Subject: Re: Running frame buffer programs using a VGA
 console?
Date: Fri, 28 Nov 2003 18:25:55 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FC7D983.2020804@undead.cc>
References: <Pine.GSO.4.21.0311280933080.21469-100000@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1APrzz-0004Yf-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 28 Nov 2003 15:26:07 -0800
Received: from gw-undead3.tht.net ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1APrzy-0005eW-Kb
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Nov 2003 15:26:06 -0800
In-Reply-To: <Pine.GSO.4.21.0311280933080.21469-100000@waterleaf.sonytel.be>
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

> So you have an active frame buffer device (you can check this using `cat
>
>/proc/fb')....
>
>  
>
Yep.  Same contents as when using fbcon.

>... and fbtest should work. You cannot switch between graphcis and text mode,
>though, since there's no console attached to your frame buffer device.
>
>  
>
Huh?  Now I'm confused.  Do you mean that I can't go between text and 
graphics using fbset or some other such utility or do you mean that 
fbtest can't go between text and graphics modes?  Because it's the 
latter that's happening by the looks of things.  It's not going into 
graphics mode to do the test.

John





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
