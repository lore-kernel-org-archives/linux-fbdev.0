From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Dri-devel] Re: [Linux-fbdev-devel] Redesign of kernel
 graphics interface
Date: Mon, 10 May 2004 10:57:25 +1000
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <1084150645.2909.4.camel@gaston>
References: <Pine.LNX.4.44.0405062327050.20402-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0405062327050.20402-100000@phoenix.infradead.org>
Errors-To: mesa3d-dev-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:mesa3d-dev@lists.sourceforge.net>
List-Help: <mailto:mesa3d-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=mesa3d-dev>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Nicolas Souchu <nsouch@free.fr>, Jon Smirl <jonsmirl@yahoo.com>, dri-devel <dri-devel@lists.sourceforge.net>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>


> 1) Keep mode switching in the kernel. Merge DRI and fb together via 
>    sysfs interface.
> 
> 2) Ben suggestion that we mount userland inside the kernel during early 
>    boot and use a userland library. If we would use a library then it MUST 
>    be OpenGL. This would be the forced standard on all platforms. This 
>    would mean Mesa would be needed to build the kernel. We could move over 
>    Mesa into the kernel like zlib is in the tree right now.

You are mixing things. Mode setting has nothing to do with rendering. OpenGL
is a rendering client. It produces commands sent to the low level kernel
driver and provides a 3D API, but it's not the only one. In this regard,
fbcon is a client too and XFree 2D accel is another one.

What I was proposing was a library that managed the desktop environment,
not involved in any rendering activities. The main reason why I halted my
work on this (except for lack of time) is that I figured out that there
were big issues to solve first about memory management of the framebuffer,
dealing with ownership of fb regions, ability to ask client to "evict"
their data (when a new mode requires a larger space) etc...

Ben.
 



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
