From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: New fb.h header
Date: Sun, 01 Feb 2004 12:03:38 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1075597418.4368.108.camel@gaston>
References: <20040129122051.798dfcaa.akpm@osdl.org>
	 <Pine.LNX.4.44.0401302353290.22830-100000@phoenix.infradead.org>
	 <20040131164955.456d13e2.akpm@osdl.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1An64d-0006jn-8B
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 31 Jan 2004 17:06:55 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1An64c-0007xD-RN
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 31 Jan 2004 17:06:54 -0800
In-Reply-To: <20040131164955.456d13e2.akpm@osdl.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: James Simmons <jsimmons@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 2004-02-01 at 11:49, Andrew Morton wrote:
> James Simmons <jsimmons@infradead.org> wrote:
> >
> > This header patch fixes the issue of building userland apps with fb.h. It 
> >  also makes struct fb_pixmap a internal kernel object. Please apply.
> 
> It breaks the ppc64 build.
> 
> 
> 
> drivers/video/cfbfillrect.c:141: warning: implicit declaration of function `__raw_writeq'
> drivers/video/cfbfillrect.c:141: warning: implicit declaration of function `__raw_readq'
> drivers/video/cfbimgblt.c: In function `color_imageblit':
> drivers/video/cfbimgblt.c:110: warning: implicit declaration of function `__raw_readl'
> drivers/video/cfbimgblt.c:122: warning: implicit declaration of function `__raw_writel'

I'd say the bug is in the ppc64 headers... I'll check that out tomorrow
with Anton.

Ben.



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
