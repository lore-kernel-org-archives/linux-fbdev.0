From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: Optimized cfbimgblt.c
Date: Fri, 28 Jan 2005 21:04:37 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0501282053340.23195@pentafluge.infradead.org>
References: <Pine.LNX.4.56.0501192015560.20796@pentafluge.infradead.org>
 <200501252058.13632.adaplas@hotpop.com> <Pine.LNX.4.56.0501262104140.15652@pentafluge.infradead.org>
 <41F949CB.405@comcast.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CudJ0-000622-SB
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Jan 2005 13:05:26 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CudII-0006NT-VJ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Jan 2005 13:05:26 -0800
Received: from jsimmons (helo=localhost)
	by pentafluge.infradead.org with local-esmtp (Exim 4.43 #1 (Red Hat Linux))
	id 1CudID-0006In-IL
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Jan 2005 21:04:39 +0000
In-Reply-To: <41F949CB.405@comcast.net>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net


Actually I have taken a look at your code. It's has potential for selling 
to some embedded vendor. Alot of the stuff you add is indeed missing but
mostly can be implemented with what we already have. For example:

fb_clear is really fb_fillrect with a rop of ROP_CLEAR. This is something 
I know Petr has been asking for :-) Which I want to implement.

fb_vline is a rectangle with a height of 1.

fb_read_point,fb_point, and fb_hline are really

struct fb_pixmap {
	inbuf
	outbuf
}

We really need a way to get framebuffer data which you did with 
fb_getpixels. I plan to expand fb_imageblit to create a image from 
the framebuffer. I like to see fb_read use this.

Why a copyarea2 ?

> I just want to make a tangential comment, call it trivia almost,
> but if we wanted to use my in-kernel GUI -- FBUI -- to handle
> the graphics during startup, including the penguin image, or
> even to handle the virtual console terminal itself or the login
> prompt, then I expect that can be done.
> 
> Zack Smith
> home.comcast.net/~plinius/fbui.html


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
