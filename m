From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Questions about fbdriver integration
	(solved)
Date: Sun, 25 Nov 2007 23:17:46 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0711252316510.5532@anakin>
References: <20071124214325.GD3183@pruts.nl>
	<Pine.LNX.4.64.0711250947380.21779@anakin>
	<20071125105153.GH3183@pruts.nl> <20071125125145.GK3183@pruts.nl>
	<20071125133209.GL3183@pruts.nl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IwPnT-0002TM-UX for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Nov 2007 14:17:52 -0800
Received: from hoboe1bl1.telenet-ops.be ([195.130.137.72])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IwPnT-0001xY-BB
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Nov 2007 14:17:51 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by hoboe1bl1.telenet-ops.be (Postfix) with SMTP id 88BBBD4050
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 25 Nov 2007 23:17:47 +0100 (CET)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by hoboe1bl1.telenet-ops.be (Postfix) with ESMTP id 68632D4047
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 25 Nov 2007 23:17:47 +0100 (CET)
Received: from anakin.of.borg (localhost [127.0.0.1])
	by anakin.of.borg (8.14.1/8.14.1/Debian-9) with ESMTP id lAPMHk3E027360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 25 Nov 2007 23:17:47 +0100
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.1/8.14.1/Submit) with ESMTP id lAPMHkKw027357
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 25 Nov 2007 23:17:46 +0100
In-Reply-To: <20071125133209.GL3183@pruts.nl>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

On Sun, 25 Nov 2007, Ico Doornekamp wrote:
> * On 2007-11-25 Ico Doornekamp <fbdev@zevv.nl> wrote  :
> > * On 2007-11-25 Ico Doornekamp <fbdev@zevv.nl> wrote  :
> > > > Fbcon writes to the memory at fb_info.screen_base.
> > > That is what I expected. I'll have to do a bit more debugging here then.
> > 
> > It seems that my driver did not fill the line_length member of
> > fb_fix_screeninfo, and no gets was copied by fbcon when this is missing.
> > 
> > I filled in this field, but now
> > 
> >   BUG: unable to handle kernel paging request at virtual address c882a800
> > 
> >   [<c882450c>] mbarcfb_imageblit+0xc/0x20 [mbarcfb]
> >   [<c881315d>] soft_cursor+0x15d/0x1bc [softcursor]
> >   [<c8817b38>] bit_cursor+0x338/0x5a8 [bitblit]
> >   [<c01c5c53>] vsnprintf+0x303/0x690
> > 
> > happens. Back to do some more debugging.
> 
> Ok, one more reply to myself: all problems seem to be solved now - I

Good!

> changed my driver to support 8-bit pseudocolor instead of 1-bit mono,
> and suddenly both the console and X are working just fine. It seems that
> the MONO01 visual is just not well supported in various other parts
> interacting with the framebuffer code.

That's strange. Monochrome is known to work on Amiga. Last one I tried
was 2.6.24-rcX.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
