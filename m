From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] neofb patches
Date: Tue, 27 Apr 2004 01:11:36 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404261933130.5302-100000@phoenix.infradead.org>
References: <10078.171.72.5.226.1083003170.squirrel@www.foogod.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIGCK-0002fS-V6
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 26 Apr 2004 17:11:40 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BIGCK-0004iP-E3
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 26 Apr 2004 17:11:40 -0700
In-Reply-To: <10078.171.72.5.226.1083003170.squirrel@www.foogod.com>
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
To: Alex Stewart <alex@foogod.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>


> >    The reason is because fb_find_mode calls check_var for us. No reason
> > to
> > call it twice. The large yres_virtual being 30000 that is not needed any
> >  longer. The accel flag is set in neofb_check_var. The current test is
> >
> > if (var->bits_per_pixel >= 24 || !par->neo2200)
> > 	var->accel_flags &= ~FB_ACCEL_TEXT;
> 
> Actually, look more closely at that code.  That is _unsetting_
> FB_ACCEL_TEXT under some circumstances, but under the current new code it
> never actually gets set anywhere.  I originally had my code your way, but
> then needed to add the extra bit above to get ypanning to actually work.

Your right. I need to reverse that logic.
 
> yres_virtual does need to be set larger than yres in order for ypanning to
> function, last I checked.  In order to set it to the correct value for the
> particular card, we set it to 30000 (very large), and then call check_var
> to have it scale it down to what the hardware can handle (this seems
> cleaner to me than duplicating the code to properly size things in two
> routines).  This must be done after the correct video mode is found by
> fb_find_mode, however.  We could have set FB_ACCEL_TEXT earlier, but I put
> it in the same place for clarity.

Yipes!!!!! You found a nasty bug in modedb. The present modedb code sets 
both xres/xres_virtual to the same value and yres/yres_virtual to the same
value. This means any driver that uses modedb automatically turns off 
panning. This is bad. 

> > Should we drop the bpp >= 24 test? Do you observe this problem at all
> > depths.
> 
> We probably should change that to a "> 24" yeah (or maybe just get rid of
> it all together).. I hadn't caught that before.  I haven't actually tested
> it at 24-bit but I don't see why it shouldn't work.

The new test I purpose is 

if (par->neo2200 && var->bits_per_pixel != 32)
	var->accel_flags = FB_ACCELF_TEXT;




-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
