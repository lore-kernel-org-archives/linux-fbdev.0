From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [Dri-devel] Re: [Linux-fbdev-devel] Redesign of kernel graphics interface
Date: Thu, 6 May 2004 18:33:53 -0700 (PDT)
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <20040507013353.27791.qmail@web14929.mail.yahoo.com>
References: <E1BLu2K-0000aT-00@evo.keithp.com>
Mime-Version: 1.0
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
In-Reply-To: <E1BLu2K-0000aT-00@evo.keithp.com>
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
Cc: James Simmons <jsimmons@infradead.org>, Nicolas Souchu <nsouch@free.fr>, dri-devel <dri-devel@lists.sourceforge.net>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>, Keith Packard <keithp@keithp.com>

--- Keith Packard <keithp@keithp.com> wrote:
> 
> Around 17 o'clock on May 6, Jon Smirl wrote:
> 
> > A proposal has been made that OpenGL be promoted as the primary base
> graphics
> > API on Linux. Then things like Cairo and the xserver be implemented on top
> of
> > OpenGL.
> 
> I respectfully disagree with this plan.  OpenGL should be the sole API for 
> accessing the graphics card for systems which support it, but I encourage 
> application developers to continue coding to the X API so that there 
> aren't unexpected "surprises" when run on a machine which doesn't support 
> OpenGL.
> 
> That the X server will use OpenGL to talk to these graphics cards is an 
> implementation detail which shouldn't be visible to applications.
> 

Read point #7

7) Going to OpenGL does not mean the end of X or remote access. xserver,
http://www.freedesktop.org/Software/xserver, still talks the X protocol and
still supports xlib. It just uses OpenGL (when Keith gets it working) to draw
instead of XAA. If you use Glitz, http://www.freedesktop.org/Software/glitz, the
OpenGL Cairo implementation, it will draw direct rendered and by-pass the
xserver for local drawing.


> -keith
> 
> 
> 

> ATTACHMENT part 2 application/pgp-signature 



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
