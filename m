From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: [Linux-fbdev-devel] Redesign of kernel graphics
 interface
Date: Mon, 10 May 2004 17:14:04 +0100 (BST)
Sender: dri-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0405101708310.4338-100000@phoenix.infradead.org>
References: <1084150645.2909.4.camel@gaston>
Mime-Version: 1.0
Return-path: <dri-devel-admin@lists.sourceforge.net>
In-Reply-To: <1084150645.2909.4.camel@gaston>
Errors-To: dri-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=dri-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Nicolas Souchu <nsouch@free.fr>, Jon Smirl <jonsmirl@yahoo.com>, dri-devel <dri-devel@lists.sourceforge.net>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>


> You are mixing things. Mode setting has nothing to do with rendering. OpenGL
> is a rendering client. It produces commands sent to the low level kernel
> driver and provides a 3D API, but it's not the only one. In this regard,
> fbcon is a client too and XFree 2D accel is another one.

But we are rendering to draw fonts, clearing a area of the screen,copyarea.
If we are to have a universal solution it needs to OpenGL. Either that or 
mode switching stays in the kernel.  

Speaking of bloat in the kernel. When will the crypto and TCP/IP stack be 
moved to userspace. The networking code alone is over 17 megs in size. 
Bloat bloat bloat. 



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
--
