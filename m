From: John Zielinski <grim@undead.cc>
Subject: Re: Framebuffer fbtest issues
Date: Thu, 27 Nov 2003 21:46:06 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FC6B6EE.9000307@undead.cc>
References: <Pine.GSO.4.21.0311271103000.19234-100000@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1APYeD-0007Jn-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 27 Nov 2003 18:46:21 -0800
Received: from gw-undead3.tht.net ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1APYeB-0004GV-UA
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 27 Nov 2003 18:46:20 -0800
In-Reply-To: <Pine.GSO.4.21.0311271103000.19234-100000@waterleaf.sonytel.be>
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Geert Uytterhoeven wrote:

> How much memory does the Radeon 9200 have? Probably at least 64 MiB. 
> Usually
> reading from video memory across PCI/AGP is slow, that's why usually it's
> faster for fbcon to scroll by redrawing all characters instead of 
> copying video
> data.
>
>  
>
It has 128 MiB.  I didn't realize that reading video memory was that 
slow...

So it's a better idea to not save the frame buffer if it's in KD_TEXT 
mode and just have the fbcon redraw it.  I'll post  my patches to fbtest 
later so you can see what I'm talking about.

John





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
