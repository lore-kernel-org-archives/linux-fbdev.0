From: Otto Wyss <otto.wyss@bluewin.ch>
Subject: Re: Portrait display mode
Date: Tue, 17 Sep 2002 19:50:19 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3D876B5C.4152DF38@bluewin.ch>
References: <3D7E59B0.5FC023D3@bluewin.ch> <1031696622.548.13.camel@daplas>
		<3D7FA51A.EC5A6FD5@bluewin.ch> <1031850411.1810.0.camel@daplas> 
		<3D84D045.404EA715@bluewin.ch> <1032145647.568.29.camel@daplas>
Reply-To: otto.wyss@bluewin.ch
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from relay03.cablecom.net ([62.2.33.103])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17rMUU-0002ET-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 17 Sep 2002 10:50:26 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Antonino Daplas <adaplas@pol.net>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

> Diagramatically, the fb-based console looks something like this:
> 
> Console -> fbcon -> fbdev -> graphics-capable hardware
> 
> Rotation is done at the fbcon layer. fbdev on the other hand is just an
> abstraction of the underlying graphics hardware.  It is fbdev that is
> actually used by fb-based applications, such as Xfree86.  fbdev does not
> know about display orientation, but Xfbdev does, and so can fbcon.
> 
What about applications compiled with GTK+ target linux-fb or similar toolsets?
If I understand it right only the fbcon layer should be used (if possible) to be
on the save side.

> > What does a rotation unter X bring as long as the console doesn't? Okay for
> This is actually what triggered me to submit the patches, it is quite
> disconcerting to switch from a rotated Xfree86 display to an upright
> console.
> 
Okay I'm not so much interested in Xfbdev than in fbcon. Can you transferred
your code to the generic part as Geert Uytterhoeven already asked. I could help
test patches against kernel 2.4.19. And what about kernel 2.5, I've read of a
feature freeze soon?

O. Wyss

-- 
Author of "Debian partial mirror synch script"
("http://dpartialmirror.sourceforge.net/")


-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
