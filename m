From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [Linux-fbdev-devel] Redesign of kernel graphics interface
Date: Thu, 6 May 2004 17:50:40 -0700 (PDT)
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <20040507005040.18258.qmail@web14925.mail.yahoo.com>
References: <Pine.LNX.4.44.0405062327050.20402-100000@phoenix.infradead.org>
Mime-Version: 1.0
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
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>, Nicolas Souchu <nsouch@free.fr>
Cc: Jon Smirl <jonsmirl@yahoo.com>, dri-devel <dri-devel@lists.sourceforge.net>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

--- James Simmons <jsimmons@infradead.org> wrote:
> 2) Ben suggestion that we mount userland inside the kernel during early 
>    boot and use a userland library. If we would use a library then it MUST 
>    be OpenGL. This would be the forced standard on all platforms. This 
>    would mean Mesa would be needed to build the kernel. We could move over 
>    Mesa into the kernel like zlib is in the tree right now.

It is not true that it must be OpenGL. The suggestion is for an independent
library that would support mode setting and cursor control. Actually OpenGL does
not specify an API for these things, we would need to develop one.

But broader issues are at work. Microsoft has decided to recode all graphics in
Longhorn to use Direct3D. This was done to get at the performance gains provided
by D3D and hardware accelerated graphics. For example a Cairo implementation hat
uses X rendering vs Cairo on OpenGL was benchmarked at being a 100:1 faster.

A proposal has been made that OpenGL be promoted as the primary base graphics
API on Linux. Then things like Cairo and the xserver be implemented on top of
OpenGL.

1) OpenGL is the only fully accelerated API that Linux has. We don't have D3D or
anything else like it. Fully accelerated interfaces are a pain to build and it
would stupid to do another one.

2) OpenGL is extremely well documented. Just go to your local book store and you
can buy a manual for it. It is available on Linux, Mac, Windows, Solaris, etc.
Colleges teach classes on how to use it.

3) It is a high level interface, the framebuffer interface is way too low level
and is mostly impossible to accelerate. Only about half of OpenGL is currently
accelerated, over the next two or three chip generations it will probably become
100% accelerated. Using OpenGL as the API allows these features to be integrated
into hardware without disrupting the apps.

4) It makes life easy for Nvidia and ATI. This is actually an important one if
you want to use the latest hardware. Even though we don't like it this design
makes it easy to releaese a monolithic blob that only exposes the OpenGL API.

5) Don't think of this as 2D vs 3D. xserver and Cairo only use the 2D features
of OpenGL. Think of this as accelerated coprocessor vs programmed IO.

6) What about low memory embedded systems? mesa has an excellent implementation
of OpenGL-ES available for free. http://www.khronos.org/opengles/ It already
supports running out of a dumb framebuffer. OpenGL-ES is small enough that
Qualcomm is putting it into phones. Of course you can always ignore the GUI
standard and do what you want in an embedded system.

7) Going to OpenGL does not mean the end of X or remote access. xserver,
http://www.freedesktop.org/Software/xserver, still talks the X protocol and
still supports xlib. It just uses OpenGL (when Keith gets it working) to draw
instead of XAA. If you use Glitz, http://www.freedesktop.org/Software/glitz, the
OpenGL Cairo implementation, it will draw direct rendered and by-pass the
xserver for local drawing.

8) If we don't get our act together soon, Longhorn is going to kick Linux's butt
on the desktop. Go look at some of the demos if you don't believe this.
http://www.osnews.com/topic.php?icon=37

Longhorn's Real Job: Trying to Gore Linux 
http://www.eweek.com/article2/0,1759,1580477,00.asp?kc=ewnws043004dtx1k0000599


=====
Jon Smirl
jonsmirl@yahoo.com


	
		
__________________________________
Do you Yahoo!?
Win a $20,000 Career Makeover at Yahoo! HotJobs  
http://hotjobs.sweepstakes.yahoo.com/careermakeover 


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
