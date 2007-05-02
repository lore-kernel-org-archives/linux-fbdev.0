From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 17/41] fbdev: Add drawing functions
 forframebuffers in system RAM
Date: Wed, 2 May 2007 22:31:14 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705022230470.29177@anakin>
References: <462EF7F0.6050606@gmail.com>
	<CA6404BA52C51146981195CF9A147C1C01A9A04D@GBISE0BASMSX01.eu.sony.com>
	<Pine.LNX.4.64.0705022119090.6403@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HjLTr-00014K-LL for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 May 2007 13:31:19 -0700
Received: from europa.telenet-ops.be ([195.130.137.75])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HjLTr-0001SI-17
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 May 2007 13:31:19 -0700
In-Reply-To: <Pine.LNX.4.64.0705022119090.6403@pentafluge.infradead.org>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>, "Antonino A. Daplas" <adaplas@gmail.com>

On Wed, 2 May 2007, James Simmons wrote:
> > > The generic drawing functions (cfbimgblt, cfbcopyarea, 
> > > cfbfillrect) assume
> > > that the framebuffer is in IO memory.  However, we have 3 
> > > drivers (hecubafb,
> > > arcfb, and vfb) where the framebuffer is allocated from 
> > > system RAM (via
> > > vmalloc). Using _raw_read/write and family for these drivers 
> > > (as used in
> > > the cfb* functions) is illegal, especially in other platforms.
> > 
> > This is also true for ps3fb. I'll update the support for that once this
> > patch has hit mainline.
> 
> Bloat. It would be much easier to replace the FB_WRITEL and FB_READL 
> macros. Last year I was working on a general solution that I wanted to 
> submit but I have been pushing other patches I considered higher priority.
> Perhaps I should move them up the que.

That's true: just replace those macros and recompile...

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
