From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: resizing results.
Date: Mon, 15 Mar 2004 22:48:36 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0403152247130.24575@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0403151732090.19671-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B2zx1-0002sX-0B
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Mar 2004 13:48:47 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B2zwx-0005nO-AV
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Mar 2004 13:48:43 -0800
In-Reply-To: <Pine.LNX.4.44.0403151732090.19671-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 15 Mar 2004, James Simmons wrote:
>    I have been doing some work on cleaning up and debugging the resize
> issue of fbcon. The first think I discovered where I never paid attention
> to before was that the number of columns and rows change you you run
> setfont. Isn't this wrong. The number of rows and columns should remain
> the same. Only the font size chaneg which causes a console resolution
> change.

It depends: from a text console point of view, changing the font doesn't change
the number of columns and rows.

However, from a graphics point of view, changing the font can change the number
of columns and rows, since the display resolution is constant.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
