From: John Zielinski <grim@undead.cc>
Subject: How can I make an inverse virtual screen?
Date: Sun, 16 Nov 2003 02:26:59 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FB726C3.5070108@undead.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ALHJs-000264-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 15 Nov 2003 23:27:40 -0800
Received: from gw-undead3.tht.net ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1ALHJJ-0003lm-4J
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 15 Nov 2003 23:27:05 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net

I just booted my linux test box hooked up to my HDTV.  The fb console 
started in 1920x540 mode.  Sweet!  The problem however is overscan.  Is 
there a easy way of doing an inverse virtual screen?  I want the virtual 
screen to be smaller than the real screen.  I was thinking to look into 
the way the logo is handled as that does the top of the screen and 
somehow make it do the same for the sides and top.

Any other suggestions?

John





-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
