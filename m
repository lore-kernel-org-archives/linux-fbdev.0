From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: How can I make an inverse virtual screen?
Date: Sun, 16 Nov 2003 10:38:44 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0311161038110.4846-100000@waterleaf.sonytel.be>
References: <3FB726C3.5070108@undead.cc>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ALJNN-0000RJ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 16 Nov 2003 01:39:25 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1ALJMm-0003lz-Px
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 16 Nov 2003 01:38:49 -0800
In-Reply-To: <3FB726C3.5070108@undead.cc>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Zielinski <grim@undead.cc>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 16 Nov 2003, John Zielinski wrote:
> I just booted my linux test box hooked up to my HDTV.  The fb console 
> started in 1920x540 mode.  Sweet!  The problem however is overscan.  Is 
> there a easy way of doing an inverse virtual screen?  I want the virtual 
> screen to be smaller than the real screen.  I was thinking to look into 
> the way the logo is handled as that does the top of the screen and 
> somehow make it do the same for the sides and top.
> 
> Any other suggestions?

Decrease the resolution and increase the sync margins?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
