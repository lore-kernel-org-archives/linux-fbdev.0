From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] neofb patches
Date: Tue, 27 Apr 2004 20:12:02 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1083060721.16473.7.camel@gaston>
References: <10078.171.72.5.226.1083003170.squirrel@www.foogod.com>
	 <Pine.LNX.4.44.0404261933130.5302-100000@phoenix.infradead.org>
	 <10682.171.72.5.133.1083028534.squirrel@www.foogod.com>
	 <Pine.GSO.4.58.0404271047520.14434@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIPeg-0000Yn-Tz
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 03:17:34 -0700
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BIPeg-0004HD-GX
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 03:17:34 -0700
In-Reply-To: <Pine.GSO.4.58.0404271047520.14434@waterleaf.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Alex Stewart <alex@foogod.com>, James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


> It's used to indicate that the frame buffer device uses hardware acceleration
> for rectangle fill/copy and imageblit.
> 
> It must be explicitly disabled before a user space application can mmap the
> MMIO registers to do its own hardware acceleration, to avoid accelerator access
> conflicts.

I think we should stick to KD_TEXT/KD_GRAPHICS for who owns the engine.

I don't think fbdev should expose any "acclerated" API to userland, that
is a hopeless goal and will lead to nothing. We need some arbitration
layer at one point between whatever accel stuff we use (DRI, userland
accel library) and somebody changing mode though. Lots of stuffs I've
tried to figure out and didn't end up with anything reasonable yet, lack
of time doesn't help...

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
