From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: Mapping the framebuffer into kernel space
Date: Thu, 12 May 2005 01:38:20 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0505120101210.6290@pentafluge.infradead.org>
References: <9e473391050428205517f3c8c0@mail.gmail.com> 
 <200505071108.36733.adaplas@hotpop.com> <9e47339105050620312618d2b7@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DW1ii-000887-Dn
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 11 May 2005 17:38:32 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DW1ig-00057c-3K
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 11 May 2005 17:38:32 -0700
In-Reply-To: <9e47339105050620312618d2b7@mail.gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Jon Smirl <jonsmirl@gmail.com>
Cc: adaplas@pol.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > It can be done but not without difficulty.  A few drivers use sections of
> > the framebuffer space for the cursor, DMA buffer and whatever.  So
> > when fbcon starts mapping the framebuffer space, it must make sure
> > that it does not overlap with the driver's, or the space left to the driver
> > is of the correct size and alignment.
> 
> We have to start transitioning to a new model. 512MB cards are
> shipping today. There is only 1GB of x86 kernel address space and the
> kernel has to fit into it too. Blindly mapping the entire VRAM into
> kernel space has to be replaced with a scheme that only maps what is
> required.

This can be done. I was moving that way using fb_pixmap. See my 
resource.diff patch I posted some time ago. Using request_region we should
be able to lock down a area so no one else can use it.

> Space for the cursor, DMA buffer, etc doesn't have to stay mapped. The
> driver can map it in, write the cursor and then map it out. DMA
> buffers don't need to be mapped in.

The cursor is really small memory. Mapping and unmapping it would be 
expensive with fbconsole because it flashs the cursor. As for DMA that
can be mapped and unmapped. 
 
> Another issue is multihead cards. For two heads it makes sense to put
> the two scanout buffers at either end of VRAM. But these buffers can
> change size. A better model might be:
> 
> cursor
> head 1 scanout
> free VRAM
> head 2 scanout
> cursor
> 
> The location of these items would be pointed to by a field in fb_info.

Each struct fb_info represent each displayable surface with a cursor[s].
It has the data the fbcon needs to function. The function check_var
needs to valided if changing one head can safely affect the other.
The function set_par would handle doing the moving around of resources.

> What's the least painful way to start a transition?

Design a clean buffer implementation that dri and fb would use.


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
