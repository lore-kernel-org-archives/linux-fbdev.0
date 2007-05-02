From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH 17/41] fbdev: Add drawing functions
 forframebuffers in system RAM
Date: Wed, 2 May 2007 21:55:29 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705022154230.12422@pentafluge.infradead.org>
References: <462EF7F0.6050606@gmail.com> 
	<CA6404BA52C51146981195CF9A147C1C01A9A04D@GBISE0BASMSX01.eu.sony.com> 
	<Pine.LNX.4.64.0705022119090.6403@pentafluge.infradead.org>
	<1178137954.4606.36.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HjLrK-0003qp-OT for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 May 2007 13:55:38 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HjLrK-0003sa-6p
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 May 2007 13:55:34 -0700
In-Reply-To: <1178137954.4606.36.camel@daplas>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > > 	Hi Tony,
> > > 
> > > > The generic drawing functions (cfbimgblt, cfbcopyarea, 
> > > > cfbfillrect) assume
> > > > that the framebuffer is in IO memory.  However, we have 3 
> > > > drivers (hecubafb,
> > > > arcfb, and vfb) where the framebuffer is allocated from 
> > > > system RAM (via
> > > > vmalloc). Using _raw_read/write and family for these drivers 
> > > > (as used in
> > > > the cfb* functions) is illegal, especially in other platforms.
> > > 
> > > This is also true for ps3fb. I'll update the support for that once this
> > > patch has hit mainline.
> > 
> > Bloat.
> 
> Only the source gets larger.  Only drivers that need it will compile it.
> 
> >  It would be much easier to replace the FB_WRITEL and FB_READL 
> > macros.
> 
> Of course it's not as simple as replacing FB_WRITEL and FB_READL. Think
> very carefully. 
> 
> Hint1: #define FB_MAX 32
> Hint2: sparse

Yeap. fbwrite/fbread are not flexable enough. The is way I put hooks into
struct fb_pixmap for writing/reading the framebuffer.

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
