From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] neofb patches
Date: Tue, 27 Apr 2004 21:25:33 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404271938330.20536-100000@phoenix.infradead.org>
References: <1083060721.16473.7.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIZ9B-00043C-3V
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 13:25:41 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BIZ9A-0001lm-KC
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 13:25:40 -0700
In-Reply-To: <1083060721.16473.7.camel@gaston>
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Alex Stewart <alex@foogod.com>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


> > It's used to indicate that the frame buffer device uses hardware acceleration
> > for rectangle fill/copy and imageblit.
> > 
> > It must be explicitly disabled before a user space application can mmap the
> > MMIO registers to do its own hardware acceleration, to avoid accelerator access
> > conflicts.
> 
> I think we should stick to KD_TEXT/KD_GRAPHICS for who owns the engine.

I wouldn't bank on that. I seen this solution fall short. Consider a system 
where we have a serial console, vgacon, and fbcon (say hgafb). Well I 
leave it to the imagination what can go wrong. 
 
> I don't think fbdev should expose any "acclerated" API to userland, that
> is a hopeless goal and will lead to nothing. We need some arbitration
> layer at one point between whatever accel stuff we use (DRI, userland
> accel library) and somebody changing mode though. Lots of stuffs I've
> tried to figure out and didn't end up with anything reasonable yet, lack
> of time doesn't help...

I agree we need arbitration. Eventually fbdev and dri have to merge. Mode 
setting is still best handled kernel side. That is just a reality.






-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
