From: Andrew Morton <akpm@osdl.org>
Subject: Re: New fb.h header
Date: Sat, 31 Jan 2004 16:49:55 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040131164955.456d13e2.akpm@osdl.org>
References: <20040129122051.798dfcaa.akpm@osdl.org>
	<Pine.LNX.4.44.0401302353290.22830-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1An5nM-0008NO-PR
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 31 Jan 2004 16:49:04 -0800
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1An5nM-0001oG-Bv
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 31 Jan 2004 16:49:04 -0800
In-Reply-To: <Pine.LNX.4.44.0401302353290.22830-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: benh@kernel.crashing.org, geert@linux-m68k.org, linux-fbdev-devel@lists.sourceforge.net

James Simmons <jsimmons@infradead.org> wrote:
>
> This header patch fixes the issue of building userland apps with fb.h. It 
>  also makes struct fb_pixmap a internal kernel object. Please apply.

It breaks the ppc64 build.



drivers/video/cfbfillrect.c:141: warning: implicit declaration of function `__raw_writeq'
drivers/video/cfbfillrect.c:141: warning: implicit declaration of function `__raw_readq'
drivers/video/cfbimgblt.c: In function `color_imageblit':
drivers/video/cfbimgblt.c:110: warning: implicit declaration of function `__raw_readl'
drivers/video/cfbimgblt.c:122: warning: implicit declaration of function `__raw_writel'
drivers/video/cfbcopyarea.c: In function `bitcpy':
drivers/video/cfbcopyarea.c:68: warning: implicit declaration of function `__raw_writeq'
drivers/video/cfbcopyarea.c:68: warning: implicit declaration of function `__raw_readq'
drivers/built-in.o(.text+0x162d44): In function `.bitfill32':
: undefined reference to `.__raw_readq'
drivers/built-in.o(.text+0x162d60): In function `.bitfill32':
: undefined reference to `.__raw_writeq'
drivers/built-in.o(.text+0x162dc0): In function `.bitfill32':
: undefined reference to `.__raw_writeq'
drivers/built-in.o(.text+0x162df4): In function `.bitfill32':
: undefined reference to `.__raw_writeq'
drivers/built-in.o(.text+0x162e08): In function `.bitfill32':
: undefined reference to `.__raw_writeq'
drivers/built-in.o(.text+0x162e1c): In function `.bitfill32':
: undefined reference to `.__raw_writeq'
drivers/built-in.o(.text+0x162e30): more undefined references to `.__raw_writeq' follow
drivers/built-in.o(.text+0x162e9c): In function `.bitfill32':


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
