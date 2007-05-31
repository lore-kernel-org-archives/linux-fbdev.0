From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: tty-related oops in latest kernel(s)?
Date: Thu, 31 May 2007 17:04:38 +0800
Message-ID: <1180602278.4570.42.camel@daplas>
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
	<Pine.LNX.4.64.0705310916240.17047@anakin>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HtgaO-0003Mh-KG for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 May 2007 02:04:48 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HtgaM-0001Aj-TQ
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 May 2007 02:04:48 -0700
Received: by py-out-1112.google.com with SMTP id u77so186032pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 31 May 2007 02:04:46 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0705310916240.17047@anakin>
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
Cc: linux-kernel@vger.kernel.org, Pekka Enberg <penberg@cs.helsinki.fi>, Tero Roponen <teanropo@jyu.fi>, Andy Whitcroft <apw@shadowen.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, Alexey Dobriyan <adobriyan@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Thu, 2007-05-31 at 09:17 +0200, Geert Uytterhoeven wrote:
> On Thu, 31 May 2007, Antonino A. Daplas wrote:
> > On Wed, 2007-05-30 at 22:04 +0400, Alexey Dobriyan wrote:
> > > 2) palette in neofb_par is "u32 palette[16];" which is 4x16 = 64 bytes.
> > >    struct fb_info::pseudo_palette is assigned to it in neo_alloc_fb_info().
> > >    Yet, we check at the beginning of neofb_setcolreg() for color map
> > >    length which neofb advertises as 256 which seems too many.
> > > 
> > 
> > Yes, 256 is too many. the pseudo_palette is used for the 16-color
> > console only.
> > 
> > I'm impressed that this bug has escaped notice for this long. That bug
> > is present since the 2.5.x era.
> > 
> > Probably, the best thing to do is hide the pseudo_palette from the
> > drivers and move it to the console layer where it belongs to spare
> > future driver writers from palette usage confusion. That will be a
> > thankless job.
> 
> The console layer doesn't know how to fill in the pseudo palette in all
> cases, that's why the driver have to do it.
> 

I have actually started working on that.  It involves breaking down
fb_setcolreg() so it deals only with writing to the actual hardware
registers.  The part of fb_setcolreg() that adds entries to the
pseudo_palette can be separated as a new method, fb_get_pixel(), which
given red, blue, green, transp, the driver returns a u32 pixel value
that can be written to the pseudo_palette.

So fbcon can hold a copy of the pseudo_palette and fills it up by
calling info->fbops->fb_get_pixel() successively.

This will touch the logo code, the drawing libraries, each driver, etc
so it's a lot of work.  During the conversion period,  we support having
info->pseudo_palette and fbcon->pseudo_palette at the same time. Once
all drivers are converted, we can remove info->pseudo_palette.

One use for having an fb_get_pixel() method is we can use this as an
rgb888-image-to-raw-framebuffer-format converter.

Currently, I have only converted vesafb. Once the core code is done,
I'll start converting the rest of the drivers one by one.

Tony




-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
