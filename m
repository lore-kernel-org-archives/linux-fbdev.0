From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] Re: Ruby redux
Date: Tue, 22 Feb 2005 18:28:12 +1100
Message-ID: <1109057292.5412.113.camel@gaston>
References: <4218CCF0.5030803@freemail.hu>
	 <Pine.LNX.4.56.0502212143030.16017@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.56.0502212143030.16017@pentafluge.infradead.org>
Sender: linuxconsole-dev-admin@lists.sourceforge.net
Errors-To: linuxconsole-dev-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linuxconsole-dev>,
	<mailto:linuxconsole-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linuxconsole-dev@lists.sourceforge.net>
List-Help: <mailto:linuxconsole-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linuxconsole-dev>,
	<mailto:linuxconsole-dev-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linuxconsole-dev>
Content-Type: text/plain; charset="us-ascii"
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Zoltan Boszormenyi <zboszor@freemail.hu>, Linux console project <linuxconsole-dev@lists.sourceforge.net>, Aivils <aivils@unibanka.lv>, James Simmons <jsimmons@infradead.org>, Roman Zippel <zippel@linux-m68k.org>


> The next generation X server will be based totally on top of OpenGL using 
> drm/fbdev. I'm going to be working with him to make sure that it supported 
> full multihead support!!!!! We will not have to do anymore X server hacks. 
> All the X Server hack on the PCI bus will go away. So we have alot of work 
> ahead. I say by next year this time main stream linux will be 
> multi-desktop ready. 

In fact, DRM handles hardware access arbitration. Wether it's
3D/GL/whatever depends on what userland client library is used.

For "legacy" cards, we can perfectly have a 2D driver using DRM to
submit commands (or beeing allowed to mmap the registers the good old
way eventually) and a server built on top of this (hint hint:
kdrive ? :)

The main ideas is to have a common mode setting and hw access
arbitration (& command submiting, DMA/AGP management etc...)
infrastructure that isn't in the server.

Wether you then use a 2D userland driver, a 3D userland driver, XGL on
top of the later, or whatever else is pretty much irrelevant.

I may want to rework a bit of the fbdev mode setting API if I can find
time to work on this. It needs some better ways to determine "related"
framebuffers, trigger re-probe of outputs, play with the output mapping,
and get hotplug events to userland. It also need to properly work with
the DRM for access arbitration to the HW. There are a lot of issues to
deal with before we can safely change modes on the fly while a 3D server
is running, but we'll have to be capable of it ultimately.

Ben.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
