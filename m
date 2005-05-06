From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Mapping the framebuffer into kernel space
Date: Fri, 6 May 2005 11:30:23 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0505061129480.5272@numbat.sonytel.be>
References: <9e473391050428205517f3c8c0@mail.gmail.com> 
 <Pine.LNX.4.56.0505021843060.24395@pentafluge.infradead.org> 
 <9e473391050504104529f1f080@mail.gmail.com> 
 <Pine.LNX.4.56.0505041902470.27026@pentafluge.infradead.org>
 <9e47339105050416415f4dfb1f@mail.gmail.com> <Pine.LNX.4.56.0505051737280.15586@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DTzAM-0002gr-Ky
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 06 May 2005 02:30:38 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DTzAJ-0005Sn-L7
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 06 May 2005 02:30:38 -0700
In-Reply-To: <Pine.LNX.4.56.0505051737280.15586@pentafluge.infradead.org>
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: Jon Smirl <jonsmirl@gmail.com>, James Simmons <jsimmons@pentafluge.infradead.org>, "Antonino A. Daplas" <adaplas@hotpop.com>

On Thu, 5 May 2005, James Simmons wrote:
> > What if we just got rid of fb_read/write and converted fbconsole to
> > use fb_imageblt?
> 
>    fbconsole does use only fb_imageblit. The only place where screen_base 
> is used is fb_write and fb_read in fbmem.c. If that could be converted to use 
> the accelerated image blitting functions then we could replace it. To do 
> that requires one thing and that is to add image blitting from screen 
> memory to system memory. Currently no driver including the software 
> blitting supports that. Plus we have no standard api to handle that. 
>    So first we have to come up with a standard way to handling image 
> blitting from card memory to system memory without breaking badly the 
> current api. Second we have to add bi directional blitting to every 
> driver. Then once we are done we can convert the fb_read and fb_write 
> functions to using the fb_imageblit functon. Have have plans to do this 
> but have not yet done it.

What if the graphics memory format is not chunked pixels? In that case
fb_{read,write}() will behave differently than mmap().

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
