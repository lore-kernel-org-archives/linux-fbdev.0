From: James Simmons <jsimmons@infradead.org>
Subject: Re: vesafb and *fb
Date: Sat, 24 Apr 2004 00:31:45 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404240031030.5826-100000@phoenix.infradead.org>
References: <Pine.GSO.4.58.0404210949590.7657@waterleaf.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BHA96-0003Ep-Jg
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 23 Apr 2004 16:31:48 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BHA96-0005qy-26
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 23 Apr 2004 16:31:48 -0700
In-Reply-To: <Pine.GSO.4.58.0404210949590.7657@waterleaf.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


I don't know why it is that way. I would think it should fail at this 
point. Anyone know why this is?


> Yesterday I noticed on a box at work that if you compile in both vesafb and
> atyfb (the box has an ATI 3D RAGE PRO), you get both fb0 (atyfb) and fb1
> (vesafb). That's not supposed to happen.
> 
> Vesafb did print that the frame buffer was already in use, but it just
> continued, cfr. this code:
> 
>     if (!request_mem_region(vesafb_fix.smem_start, vesafb_fix.smem_len, "vesafb")) {
> 	    printk(KERN_WARNING
> 		   "vesafb: abort, cannot reserve video memory at 0x%lx\n",
> 		    vesafb_fix.smem_start);
> 	    /* We cannot make this fatal. Sometimes this comes from magic
> 	       spaces our resource handlers simply don't know about */
>     }
> 
> That was on plain 2.6.5. But to my surprise the latest 2.4 behaves the same.
> This seems to have been changed in 2.4.15.
> Does anyone know why this was changed?
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
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
