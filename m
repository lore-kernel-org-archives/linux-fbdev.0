From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: writing a framebuffer driver and font
 problem..
Date: Fri, 31 Oct 2003 11:41:37 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0310311118590.17237-100000@waterleaf.sonytel.be>
References: <004501c39f87$480b7e60$54dc10c3@amos>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AFWir-0002jS-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 31 Oct 2003 02:41:41 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AFWir-0000Bh-4N
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 31 Oct 2003 02:41:41 -0800
In-Reply-To: <004501c39f87$480b7e60$54dc10c3@amos>
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
To: Kaj-Michael Lang <milang@tal.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 31 Oct 2003, Kaj-Michael Lang wrote:
> I hope someone here can help me. I've started writing support for the b/w
> framebuffer on
> VAXstation for the Linux/VAX project. And I've got so far that it sort-of
> works, I can output text
> on the framebuffer and such. Problem is that all font are flipped/mirrored,
> like a "b" looks like "d", this picture
> might show it a little bit better: http://home.tal.org/~milang/vax/2.html
> And as you can se from the picture the logo looks strange.
> 
> What might be the problem, and what should I do to fix it ?
> 
> I'm totaly new a writing kernel code so it might be something obvious that
> I'm missing.

Are you using 2.4 or 2.6?

You have to swap the character data in
drivers/video/fbcon-mfb.c:fbcon_mfb_putc{,s}() (2.4.x) or
drivers/video/cfbimgblt.c.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
