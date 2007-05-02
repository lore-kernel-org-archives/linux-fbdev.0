From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 17/41] fbdev: Add drawing
	functions	forframebuffers in system RAM
Date: Thu, 03 May 2007 04:32:34 +0800
Message-ID: <1178137954.4606.36.camel@daplas>
References: <462EF7F0.6050606@gmail.com>
	<CA6404BA52C51146981195CF9A147C1C01A9A04D@GBISE0BASMSX01.eu.sony.com>
	<Pine.LNX.4.64.0705022119090.6403@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HjLVS-0001DK-7v for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 May 2007 13:32:58 -0700
Received: from py-out-1112.google.com ([64.233.166.176])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HjLVC-0005pu-E7
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 May 2007 13:32:58 -0700
Received: by py-out-1112.google.com with SMTP id a29so222411pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 02 May 2007 13:32:41 -0700 (PDT)
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
To: James Simmons <jsimmons@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2007-05-02 at 21:22 +0100, James Simmons wrote:
> > 	Hi Tony,
> > 
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
> Bloat.

Only the source gets larger.  Only drivers that need it will compile it.

>  It would be much easier to replace the FB_WRITEL and FB_READL 
> macros.

Of course it's not as simple as replacing FB_WRITEL and FB_READL. Think
very carefully. 

Hint1: #define FB_MAX 32
Hint2: sparse

Tony  



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
