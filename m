From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
 one works ;-)
Date: Wed, 21 Apr 2004 19:03:01 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404211851520.9207-100000@phoenix.infradead.org>
References: <1082507399.2056.26.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BGM3u-00032b-Tq
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Apr 2004 11:03:06 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BGM3u-0006Kx-Dc
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Apr 2004 11:03:06 -0700
In-Reply-To: <1082507399.2056.26.camel@gaston>
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
Cc: David Eger <eger-dated-1082943669.d79d33@theboonies.us>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


> Why not simply
> 
>  1) Document properly what those various options do
>  2) Let the driver provide it's "preferred" scroll mode ? It's sort-of
>     a stack violation since it really only affects fbcon at this point,
>     but since it's just an "hint", it's perfectly acceptable.
> 
> (Note: I'm not sure about controlfb at this point, I have to dig
> out some old HW and test)
> 
> Also, we sort-of lost the ability to have fbcon specific accels in the
> drivers... 

I agree. I don't doubt that in time we will find that the low level driver 
has to deal with this. Also it would really nice if userland new which is 
better for when it would using the accel engine.

> It would have been nice to be able to store the font in
> vram and use blits to composite text, but that would have meant having
> fbcon-related hooks =P Or maybe we can find a clean way to express that
> to fbcon without clobbering fbdev's with fbcon-related datas ? Simply by
> having fbcon request a vres big enough to store the font data outside
> of the visible area and using copyarea ?

Struct fb_pixmap. We have data pointer *addr. The only problem is using 
the memory space to the right of the visible framebuffer

------------|
|	|   |
|	|   |
--------------

At the bottom of the framebuffer it would be no problem. We could even use 
struct fb_pixmap with texture maps. Store fonts as texture maps and just 
draw them to a surface. You can do lots of fancy tricks. The only issue I 
have thought about is we might need to had a hook for fb_get_buffer_offset.
Not to big a deal.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
