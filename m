From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] neofb patches
Date: Wed, 28 Apr 2004 18:39:37 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404281829410.1187-100000@phoenix.infradead.org>
References: <20040428070832.GA23411@guug.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIt26-0007n2-4a
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 10:39:42 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BIt25-0003uV-Fc
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 10:39:42 -0700
In-Reply-To: <20040428070832.GA23411@guug.org>
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
To: Otto Solares <solca@guug.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


> I currently have now.  I like the fbdev abstraction but it has
> too many limitations:
> 
> - Improper video mode handling.  Simply the device driver should
>   hint about valid modes, EDID, etc.

Being worked on. We have fbmon.c and modedb.c

> - When an app crashes the layer is unable to recover it's
>   previous state even when proper semantics exist (KD_TEXT/GRAPH),
>   when the kernel closes the fbdev it must trigger a return to
>   KD_TEXT if in KD_GRAPHICS and set the fix and var settings
>   remembering that settings before leaving KD_TEXT.

This has always been. In the old days when X crashed you lost your 
display. That was life. The X drivers are better but its up to X to 
restore the console.

> - It should exist a field in the fixed info for the bus_id, so
>   intelligent apps will realize which card is attached to a fbdev.

Sysfs will solve this.

> - Cards with various display ports must be handled by the layer,
>   with a new API just to handle ports.

Create a fb_info for each display port.

> - It dangerously coexists currently with the DRM queues and
>   SAREA areas.  Both must merge in fbdev.

Agree.

> - VCs mess.

2.7.X. I have been working on that for a couple of years.

> - Wasted effort in accel engines handling is only useful to fbcon,
>   nobody needs acceleration to drive a X x Y character matrix
>   in fbcon.  The argument that hw without a framebuffer will
>   exist and that's why the accel engine must be used is BS,
>   the PC, the BIOS and the video framebuffers will never die,
>   framebuffer exists in the best video cards money can buy
>   today and it exists in planned cards from major manufacturers
>   for tomorrow, probably the framebuffer can't be accessed when
>   the accel engine is being used in forthcoming cards but that
>   is completely a different story.

I disagree. It's also a performace issue. Even if we use software
drawing routines the fbcon layer still needs to draw a image, fill 
a region and copy a area. We can't just dump that into fbcon easily.
Plus with the software cursor we do use fb_imageblit. Also I'm 
beginning to realize we need to clear out the framebuffer memory.
People complain about left over junk on there screen when the console 
takes over. 

> IMHO this must be addressed ASAP if we want to compete with
> Longhorn and MacOSX.  People should realize that fbdev is a
> linux standard that needs to be modernized and it must be fixed,

I agree.

> we should not devote more resources to implement complex accel
> engines in the fbdev drivers, 

I'm not focusing on that. We have a basic api and that's it. If 
you don't want to program the accel engine just use the software 
routines. Look at the debate about how to handle setting the resolution.
Yipes it been fierce.




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
