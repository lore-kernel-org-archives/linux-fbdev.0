From: James Simmons <jsimmons@infradead.org>
Subject: Re: fbdv/fbcon pending problems
Date: Wed, 25 Feb 2004 21:24:16 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0402252109030.24952-100000@phoenix.infradead.org>
References: <1077672403.1084.45.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aw6ey-0002Dc-Tj
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 Feb 2004 13:33:40 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1Aw6Vy-00012H-ER
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 Feb 2004 13:24:22 -0800
In-Reply-To: <1077672403.1084.45.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Otto Solares <solca@guug.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>


> It is. What we really need right now is a proper way to get the mode
> lists. but more than that. We need to expose per-output detection data,
> mapping of CRTCs to outputs, and a way to change that mapping & trigger
> a re-probe. All of that can probably not be done in a completely card
> neutral way.  

Agree.
 
> I've started working on a userland library taking care of managing
> the "environment", that is the various screens & heads, their modes,
> the geometry (relative screen positions), and such. I haven't gone
> very far yet, but the idea is ultimately to have the entire mode
> setting go through this library. 

   I think this is a bad idea. This has been tried before. In the 
opensource community there is no such a thing as a standard library. 
We can see that with directfb and X windows, sdl, gtk/qt embedded, etc. 
Understand that I have no problem with having lots of libraries. Its 
just the reality is your library will be just one amoung many. 
   The time will come when someone will send you a patch and you will 
reject it and then the person will go off and make his/her own library.
Or someone will look at your work and say I can do better. Then we end
up with a bunch of libraries doing basically similiar things. Which one 
does the developer use then? We can't force them to use the "standard"
one. 
    The kernel really needs to be the only state machine for the hardware. 
Library developers will usually use the kernel standard interfaces. 

> This library will also be responsible to broadcast, possibly via
> D-BUS, events like screen hotplug and mode changes. We are thinking
> about interfacing the fd.o xserver on this among others. It will
> not do anything about rendering though.

I like to see the D-BUS pick up these events :-) It would come in handy 
for the JVMs I work on.
 
> That leads to another issue which is arbitration at the low level
> driver between rendering & mode switching. That should be done by
> the kernel driver at some point, we need to merge the mode setting
> driver (fbdev) and the command queue diver (DRI). 

I agree they have to be merged.

> Probably moving 
> some of the higher level mode management out of the kernel driver
> down to this userland library.

Bad idea.



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
