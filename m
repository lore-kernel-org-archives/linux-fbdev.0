From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Mapping the framebuffer into kernel space
Date: Thu, 12 May 2005 11:14:49 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0505121112320.15959@numbat.sonytel.be>
References: <9e473391050428205517f3c8c0@mail.gmail.com> 
 <9e47339105050511522f6eff30@mail.gmail.com> 
 <Pine.LNX.4.56.0505051959350.15586@pentafluge.infradead.org> 
 <Pine.LNX.4.56.0505052141360.15586@pentafluge.infradead.org>
 <9e4733910505051402789440db@mail.gmail.com> 
 <Pine.LNX.4.56.0505060046490.15586@pentafluge.infradead.org> 
 <9e47339105050517083fadaee0@mail.gmail.com> <Pine.LNX.4.56.0505062008090.6914@pentafluge.infradead.org>
 <9e47339105050615097bdfcdcb@mail.gmail.com> <Pine.LNX.4.56.0505112345230.4268@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DW9mh-00086c-JJ
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 12 May 2005 02:15:11 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DW9me-0007tN-Ui
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 12 May 2005 02:15:11 -0700
In-Reply-To: <Pine.LNX.4.56.0505112345230.4268@pentafluge.infradead.org>
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

On Wed, 11 May 2005, James Simmons wrote:
> > > Yuck. Why not just us the image blitter for reading and writing the
> > > framebuffer?
> > 
> > Could you generically rewrite fb_read/write to just use the image blitter? 
> 
> Yes.

No.

The imageblit routines convert between chunked pixels and the actual frame
buffer representation.
fb_{read,write}() access the raw frame buffer.

Probably the best solution is to set up a small ioremap()'ed window that can be
moved in fb_{read,write}() (assumed moving such a window is much cheaper than
ioremap() + iounmap()).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
