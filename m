From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Patch 2] Console Rotation
Date: Mon, 9 Sep 2002 16:35:49 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0209091634380.12337-100000@vervain.sonytel.be>
References: <1031580820.633.11.camel@daplas>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17oPeA-0006Sf-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 09 Sep 2002 07:36:15 -0700
In-Reply-To: <1031580820.633.11.camel@daplas>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

On 9 Sep 2002, Antonino Daplas wrote:
> cfbcopyarea.c is just a 'copy 'n paste' of Geert's version I leached
> from fbutils (I hope this is okay with you, Geert :)  The only changes
> are using FB_WRITEL and FB_READL where appropriate. 

Of course (actually that was my intention ;-)

Did you measure any noticeable differences (performance-wise) with the old
routines?

BTW, expect a fillrect() for arbitrary bitdepths soon...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
