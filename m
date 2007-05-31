From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: tty-related oops in latest kernel(s)?
Date: Thu, 31 May 2007 09:17:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705310916240.17047@anakin>
References: <84144f020705280022lf3902caj1def02ed56e0bff@mail.gmail.com>
	<84144f020705280234g39aa04b3hfe369f4477e6043d@mail.gmail.com>
	<Pine.LNX.4.64.0705291900001.32656@jalava.cc.jyu.fi>
	<84144f020705291157k465ec6c4sb81081844bb57514@mail.gmail.com>
	<Pine.LNX.4.64.0705300654493.5241@jalava.cc.jyu.fi>
	<84144f020705292254o319f6619m787bf29491c92509@mail.gmail.com>
	<Pine.LNX.4.64.0705301458400.4634@jalava.cc.jyu.fi>
	<20070530083953.9909bcef.akpm@linux-foundation.org>
	<Pine.LNX.4.64.0705301857370.29485@jalava.cc.jyu.fi>
	<20070530090945.ab9d51d9.akpm@linux-foundation.org>
	<20070530180428.GA5731@martell.zuzino.mipt.ru>
	<1180566886.4570.14.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hteun-0005VV-1n for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 May 2007 00:17:45 -0700
Received: from adicia.telenet-ops.be ([195.130.132.56])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hteum-0005XH-C8
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 May 2007 00:17:44 -0700
In-Reply-To: <1180566886.4570.14.camel@daplas>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, Pekka Enberg <penberg@cs.helsinki.fi>, Tero Roponen <teanropo@jyu.fi>, Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@linux-foundation.org>, Alexey Dobriyan <adobriyan@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Thu, 31 May 2007, Antonino A. Daplas wrote:
> On Wed, 2007-05-30 at 22:04 +0400, Alexey Dobriyan wrote:
> > 2) palette in neofb_par is "u32 palette[16];" which is 4x16 = 64 bytes.
> >    struct fb_info::pseudo_palette is assigned to it in neo_alloc_fb_info().
> >    Yet, we check at the beginning of neofb_setcolreg() for color map
> >    length which neofb advertises as 256 which seems too many.
> > 
> 
> Yes, 256 is too many. the pseudo_palette is used for the 16-color
> console only.
> 
> I'm impressed that this bug has escaped notice for this long. That bug
> is present since the 2.5.x era.
> 
> Probably, the best thing to do is hide the pseudo_palette from the
> drivers and move it to the console layer where it belongs to spare
> future driver writers from palette usage confusion. That will be a
> thankless job.

The console layer doesn't know how to fill in the pseudo palette in all
cases, that's why the driver have to do it.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
