From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: [PATCH]: image.depth fix to accomodate
 monochrome cards
Date: Fri, 10 Jan 2003 20:43:33 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0301102041130.18440-100000@vervain.sonytel.be>
References: <Pine.LNX.4.44.0301101925110.18287-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18X559-0001m8-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Jan 2003 11:44:43 -0800
In-Reply-To: <Pine.LNX.4.44.0301101925110.18287-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 10 Jan 2003, James Simmons wrote:
> > I think we still have several corner cases, such as TRUECOLOR with bpp
> > <= 8, I'm not sure if that works.
> 
> The matorx millenium has such a mode. So such things do exist.
>  
> > -	if (image->depth == 1) {
> > +	if (image->depth == 0) {
> 
> P.S
> 
>    I'm just not to crazy about the depth equal zero thing. I just pitcure 
> developers having a hard time with it.

Monochrome color expansion just works differently: it expands the zeroes and
ones in a bitmap based on fg_color and bg_color, while image drawing draws an
image containing colormap indices to the frame buffer.

Do you have a better suggestion?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
