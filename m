From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Dri-devel] Re: [Linux-fbdev-devel] Redesign of kernel graphics
 interface
Date: Tue, 11 May 2004 00:50:01 +0100 (BST)
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0405110048330.8016-100000@phoenix.infradead.org>
References: <1084232443.2911.73.camel@gaston>
Mime-Version: 1.0
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
In-Reply-To: <1084232443.2911.73.camel@gaston>
Errors-To: mesa3d-dev-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:mesa3d-dev@lists.sourceforge.net>
List-Help: <mailto:mesa3d-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=mesa3d-dev>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Nicolas Souchu <nsouch@free.fr>, Jon Smirl <jonsmirl@yahoo.com>, dri-devel <dri-devel@lists.sourceforge.net>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>


> > But we are rendering to draw fonts, clearing a area of the screen,copyarea.
> > If we are to have a universal solution it needs to OpenGL. Either that or 
> > mode switching stays in the kernel.  
> 
> Drawing fonts have _NOTING_ to do with mode switching ! Don't tell me
> that you can't make the difference between fbdev and fbcon now ;)

That is not what I'm saying. I'm sayimng we could use opengl to draw the 
fonts in fbcon. Opengl coudl be the center piece library that does 
everything. 

> > Speaking of bloat in the kernel. When will the crypto and TCP/IP stack be 
> > moved to userspace. The networking code alone is over 17 megs in size. 
> > Bloat bloat bloat. 
> 
> That has nothing to do with it. If you don't agree, come to KS or OLS
> and talk to Linus. Your arguments & comparisons are pointless

I think I'm going to have to.




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
