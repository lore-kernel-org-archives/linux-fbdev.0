From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Framebuffer "glich" 2.6.0-test5, radeon & Dell 4100 Laptop (fwd)
Date: Wed, 17 Sep 2003 11:32:47 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0309171132200.3644-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zYg9-0003y4-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 17 Sep 2003 02:32:53 -0700
Received: from mail2.sonytel.be ([195.0.45.172] helo=witte.sonytel.be)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19zYg8-0006DE-BL
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Sep 2003 02:32:52 -0700
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andre Smit <andre@osi.co.za>

---------- Forwarded message ----------
Date: Wed, 17 Sep 2003 04:16:52 +0200
From: Andre Smit <andre@osi.co.za>
To: geert@linux-m68k.org
Subject: Framebuffer "glich" 2.6.0-test5, radeon & Dell 4100 Laptop

Hallo Geert
 
I hope I am contacting the right person. Found your e-mail address in
framebuffer.txt distributed with 2.6.0
 
My Dell 4100 PIII laptop has a Radeon Mobility chipset. It works fine
with 2.4.20 on my Redhat 8.0 distribution.
 
I installed 2.60.0-test5, (experimenting with netfilter) then my screen
(LCD) became unreadable (stripes thing).
 
 
I booted the old kernel and did a "fsetb 1024x768-70 (-60 doesn't work
either?) in one of my rc.d scripts.
 
Now its fine, maybe the default for radeon should work with these
machines so people don't have to "FIX IT" with fbset?
 
Just a suggestion you know, I am an old Linux hacker and it took me 20
secs to solve! Others might suffer?
 
Andre Smit
Thanks



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
