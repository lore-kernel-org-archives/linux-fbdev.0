From: John Zielinski <grim@undead.cc>
Subject: Re: [PATCH] neofb patches
Date: Tue, 27 Apr 2004 21:39:45 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <408F0B61.5090806@undead.cc>
References: <Pine.LNX.4.44.0404280019070.23153-100000@phoenix.infradead.org>	 <408EF0D9.6000403@undead.cc> <1083109849.20091.1.camel@gaston>	 <408EFD18.7070702@undead.cc> <1083112862.20474.14.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIe3H-0000Jm-B4
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 18:39:55 -0700
Received: from ns2.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BIe3G-0002In-Rc
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 18:39:54 -0700
In-Reply-To: <1083112862.20474.14.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Alex Stewart <alex@foogod.com>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Benjamin Herrenschmidt wrote:

>You don't need a /dev/fb for that do you ? You need to map the current
>vt to it's fb via the existing fbdev ioctls, isn't that possible ? (just
>asking , I've never actually done that).
>
>  
>
But how does the app find this out?  It would have to figure out if it's 
running on a real console then figure out which console is mapped to 
which fb and then try to find out which /dev/fbx device points to that 
fb.  Programmer's are lazy, they'll just make it a command line switch 
to specify what device to use which is not very user friendly.

What I'm proposing is that you open /dev/fb.  If it fails you're running 
on a serial line or shh or whatever.  If it succedes you issue 
KD_GRAPHICS ioctl on the /dev/fb device and that's it.  Very simple for 
the programmer.

The kernel does all the work.  It figures out what vt you're on and 
prevents access from serial or a pty.  It also would figure out which 
framebuffer device to connect to based on the con2fb map specified by 
the fbdev ioctls.  It would pass the KD_TEXT/KD_GRAPHICS calls to the 
appropriate vt.

This makes it very user friendly.  The user just switches to the vt 
that's on the moitor they want and starts the app.  The kernel figures 
out how to route this to the appropriate fb driver according to the 
con2fb map.

I might also be possible to use /dev/tty as the starting point if you 
want to make everything start at the vt layer and work down.   The fb 
ioctls would just have to be passed down.  Once a KD_GRAPHICS was issued 
on /dev/tty then read/write/mmap would pass down to the fb layer as well. 

John




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
