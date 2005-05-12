From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: Mapping the framebuffer into kernel space
Date: Thu, 12 May 2005 16:50:46 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0505121648020.19137@pentafluge.infradead.org>
References: <9e473391050428205517f3c8c0@mail.gmail.com> 
 <9e47339105050511522f6eff30@mail.gmail.com> 
 <Pine.LNX.4.56.0505051959350.15586@pentafluge.infradead.org> 
 <Pine.LNX.4.56.0505052141360.15586@pentafluge.infradead.org>
 <9e4733910505051402789440db@mail.gmail.com> 
 <Pine.LNX.4.56.0505060046490.15586@pentafluge.infradead.org> 
 <9e47339105050517083fadaee0@mail.gmail.com> <Pine.LNX.4.56.0505062008090.6914@pentafluge.infradead.org>
 <9e47339105050615097bdfcdcb@mail.gmail.com> <Pine.LNX.4.56.0505112345230.4268@pentafluge.infradead.org>
 <Pine.LNX.4.62.0505121112320.15959@numbat.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DWFxf-0000ew-F4
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 12 May 2005 08:50:55 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DWFxe-0003Nq-0U
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 12 May 2005 08:50:55 -0700
In-Reply-To: <Pine.LNX.4.62.0505121112320.15959@numbat.sonytel.be>
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
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Jon Smirl <jonsmirl@gmail.com>, James Simmons <jsimmons@pentafluge.infradead.org>, "Antonino A. Daplas" <adaplas@hotpop.com>


> > > Could you generically rewrite fb_read/write to just use the image blitter? 
> > 
> > Yes.
> 
> No.
> 
> The imageblit routines convert between chunked pixels and the actual frame
> buffer representation.
> fb_{read,write}() access the raw frame buffer.

That means that we will never uses the hardware acceleration ever in this 
case :-( It will always be slow!!!!

> Probably the best solution is to set up a small ioremap()'ed window that can be
> moved in fb_{read,write}() (assumed moving such a window is much cheaper than
> ioremap() + iounmap()).

Does such functionality exist? Second can you do the same thing with 
request_region? We need to so fbcon and /dev/fb don't step on each other 
toes.



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
