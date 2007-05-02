From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH 17/41] fbdev: Add drawing functions
 forframebuffers in system RAM
Date: Wed, 2 May 2007 21:22:55 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705022119090.6403@pentafluge.infradead.org>
References: <462EF7F0.6050606@gmail.com>
	<CA6404BA52C51146981195CF9A147C1C01A9A04D@GBISE0BASMSX01.eu.sony.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HjLLo-0000Ar-3y for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 May 2007 13:23:00 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HjLLm-0007So-Mn
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 May 2007 13:23:00 -0700
In-Reply-To: <CA6404BA52C51146981195CF9A147C1C01A9A04D@GBISE0BASMSX01.eu.sony.com>
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
Cc: Andrew Morton <akpm@osdl.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@gmail.com>


> 	Hi Tony,
> 
> > The generic drawing functions (cfbimgblt, cfbcopyarea, 
> > cfbfillrect) assume
> > that the framebuffer is in IO memory.  However, we have 3 
> > drivers (hecubafb,
> > arcfb, and vfb) where the framebuffer is allocated from 
> > system RAM (via
> > vmalloc). Using _raw_read/write and family for these drivers 
> > (as used in
> > the cfb* functions) is illegal, especially in other platforms.
> 
> This is also true for ps3fb. I'll update the support for that once this
> patch has hit mainline.

Bloat. It would be much easier to replace the FB_WRITEL and FB_READL 
macros. Last year I was working on a general solution that I wanted to 
submit but I have been pushing other patches I considered higher priority.
Perhaps I should move them up the que.


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
