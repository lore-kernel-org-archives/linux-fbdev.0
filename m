From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Dri-devel] Re: [Linux-fbdev-devel] Redesign of kernel
 graphics interface
Date: Tue, 11 May 2004 09:40:44 +1000
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <1084232443.2911.73.camel@gaston>
References: <Pine.LNX.4.44.0405101708310.4338-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: James Simmons <jsimmons@infradead.org>
Cc: Nicolas Souchu <nsouch@free.fr>, Jon Smirl <jonsmirl@yahoo.com>, dri-devel <dri-devel@lists.sourceforge.net>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2004-05-11 at 02:14, James Simmons wrote:
> > You are mixing things. Mode setting has nothing to do with rendering. OpenGL
> > is a rendering client. It produces commands sent to the low level kernel
> > driver and provides a 3D API, but it's not the only one. In this regard,
> > fbcon is a client too and XFree 2D accel is another one.
> 
> But we are rendering to draw fonts, clearing a area of the screen,copyarea.
> If we are to have a universal solution it needs to OpenGL. Either that or 
> mode switching stays in the kernel.  

Drawing fonts have _NOTING_ to do with mode switching ! Don't tell me
that you can't make the difference between fbdev and fbcon now ;)

> Speaking of bloat in the kernel. When will the crypto and TCP/IP stack be 
> moved to userspace. The networking code alone is over 17 megs in size. 
> Bloat bloat bloat. 

That has nothing to do with it. If you don't agree, come to KS or OLS
and talk to Linus. Your arguments & comparisons are pointless

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
