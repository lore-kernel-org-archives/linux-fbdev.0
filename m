From: Otto Wyss <otto.wyss@bluewin.ch>
Subject: Re: Portrait display mode
Date: Wed, 11 Sep 2002 22:18:35 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3D7FA51A.EC5A6FD5@bluewin.ch>
References: <3D7E59B0.5FC023D3@bluewin.ch> <1031696622.548.13.camel@daplas>
Reply-To: otto.wyss@bluewin.ch
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from relay03.cablecom.net ([62.2.33.103])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17pDwd-00082z-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 11 Sep 2002 13:18:40 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Antonino Daplas <adaplas@pol.net>
Cc: "'linux-fbdev-devel@lists.sourceforge.net'" <linux-fbdev-devel@lists.sourceforge.net>

> I posted a patch under the thread titled "Console Rotation" 2 days ago.
> It should support rotation in 3 additional directions (90, 180 and 270
> degrees).  As far as fb-based apps, they have to do the rotation on

I should have looked more closely at the messages, "Console ..." misguided me.

> their own.  XFbdev in 4.2.0 already does that.
> 
When the fb drivers support rotation, XFbdev doesn't need rotation anymore.

> Doing this in 2.4 will be trickier because of absence of support for
> drawing primitives.  (The i810fb driver had console rotation for half a
> year now, though)
> 
Does this mean I have to use 2.5 to get rotation?

> If you are interested, try the patches (apply them in the order I
> mentioned).  http://i810fb.sourceforge.net/fb_rotate.tar.gz
> 
I'm currently using "aty128fb" but may be able to switch to "matroxfb". I'm also
considering buying card with an DVI plug (hopefully without fan :-( )

O. Wyss

-- 
Author of "Debian partial mirror synch script"
("http://dpartialmirror.sourceforge.net/")


-------------------------------------------------------
In remembrance
www.osdn.com/911/
