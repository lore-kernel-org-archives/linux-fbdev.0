From: James Simmons <jsimmons@infradead.org>
Subject: Re: fbset not working with tridentfb on 2.6.x
 kern
Date: Fri, 23 Apr 2004 17:52:40 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404231752020.3997-100000@phoenix.infradead.org>
References: <200404200100.47906.deller@gmx.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BH3ut-0006ie-N8
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 23 Apr 2004 09:52:43 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BH3ut-0004G1-8z
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 23 Apr 2004 09:52:43 -0700
In-Reply-To: <200404200100.47906.deller@gmx.de>
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
To: Helge Deller <deller@gmx.de>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


That is a problem in the general layer. It hasn't been fixed yet.


On Tue, 20 Apr 2004, Helge Deller wrote:

> Hi,
> 
> I've tried the tridentfb a few times with the last 2.6 kernel series (e.g. 2.6.6-rc1, 2.6.5, 2.6.4, 2.6.3) and with none of those kernels switching resolution with fbset worked. Everytime just screen was just scrambled with weired random graphics pixel stuff.
> 
> modprobe tridentfb on 2.6.6-rc1 gives:
> tridentfb: Trident framebuffer 0.7.8-NEWAPI initializing
> tridentfb: framebuffer size = 8192 Kb
> tridentfb: 0000:01:00.0 board found
> tridentfb: 1024x768 flat panel found
> tridentfb: fb0: Trident frame buffer device 640x480-8bpp
> 
> My system is a IBM R30 laptop with the following lspci output:
> 01:00.0 VGA compatible controller: Trident Microsystems CyberBlade/i1 (rev 5d) (prog-if 00 [VGA])
>         Subsystem: IBM ThinkPad T30
>         Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 11
>         Memory at 80800000 (32-bit, non-prefetchable)
>         Memory at 80500000 (32-bit, non-prefetchable)
>         Memory at 81000000 (32-bit, non-prefetchable)
>         Capabilities: [80] AGP version 1.0
>         Capabilities: [90] Power Management version 1
> 
> I'm willing to test any patches to get this think working correctly....
> 
> Helge
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 



-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
