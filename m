From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Re: [Dri-devel] Re: [Linux-fbdev-devel] Redesign of kernel graphics interface
Date: Mon, 10 May 2004 11:29:40 -0700 (PDT)
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <20040510182940.14049.qmail@web14924.mail.yahoo.com>
References: <Pine.LNX.4.44.0405101708310.4338-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0405101708310.4338-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Nicolas Souchu <nsouch@free.fr>, Jon Smirl <jonsmirl@yahoo.com>, dri-devel <dri-devel@lists.sourceforge.net>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

It's not just bloat, the network code is used millions of times per second. Mode
setting happens occaisonally. 

The other problem is memory management. What is going to happen when fbdev
starts setting the mode for both heads? Who is going to mananage the VRAM when
the buffers get resized? OpenGL has a very complex memory management scheme
where things can migrate from VRAM to AGP to system memory.

--- James Simmons <jsimmons@infradead.org> wrote:
> 
> > You are mixing things. Mode setting has nothing to do with rendering. OpenGL
> > is a rendering client. It produces commands sent to the low level kernel
> > driver and provides a 3D API, but it's not the only one. In this regard,
> > fbcon is a client too and XFree 2D accel is another one.
> 
> But we are rendering to draw fonts, clearing a area of the screen,copyarea.
> If we are to have a universal solution it needs to OpenGL. Either that or 
> mode switching stays in the kernel.  
> 
> Speaking of bloat in the kernel. When will the crypto and TCP/IP stack be 
> moved to userspace. The networking code alone is over 17 megs in size. 
> Bloat bloat bloat. 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by Sleepycat Software
> Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
> deliver higher performing products faster, at low TCO.
> http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
> _______________________________________________
> Mesa3d-dev mailing list
> Mesa3d-dev@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/mesa3d-dev


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
