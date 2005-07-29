From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: [PATCH] fbdev: colormap fixes
Date: Fri, 29 Jul 2005 21:13:42 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0507292106440.17988@pentafluge.infradead.org>
References: <200507280031.j6S0V3L3016861@hera.kernel.org>
 <Pine.LNX.4.62.0507280952140.24391@numbat.sonytel.be>
 <9e473391050728060741040424@mail.gmail.com> <42E8F0CD.6070500@gmail.com>
 <Pine.LNX.4.62.0507281758080.24391@numbat.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DybFW-00010z-Uo
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 13:14:30 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1DybF2-0004Nx-CY
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 13:14:30 -0700
In-Reply-To: <Pine.LNX.4.62.0507281758080.24391@numbat.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>



> >  3) Add another file in sysfs which specifies at what index and how many
> > entries will be read or written from or to the cmap. With this additional
> > sysfs file, it should be able to handle any reasonable cmap length, but
> > it will take more than one reading of the color_map file. Another
> > advantage is that the entire color map need not be read or written if
> > only one field needs to be changed.
> > 
> > I've attached a test patch.  Let me know what you think.
> 
> I like it! ... But, a disadvantages is that it needs to store state between two
> non-atomic operations. E.g. imagine two processes doing this at the same time.

   That is really nice. Setting the values in the color map don't have to 
be atomic. Programming the hardware color registers do!! You could do a 
loop filling the color map and then do a sync operation that would flush 
the values to the hardware. It would be really nice if sysfs files had 
hooks for syncing so we could do atomic operations :-) 
     I realized for the cursor it is the same things. We have several 
fields to set but we don't want to program the cursor over and over 
again for every slight change. Instead we shoudl cache the changes
until we want to send those changes to the hardware.





-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
