From: Zack Smith <plinius@comcast.net>
Subject: Re: Optimized cfbimgblt.c
Date: Fri, 28 Jan 2005 21:15:32 -0800
Message-ID: <41FB1BF4.2070108@comcast.net>
References: <Pine.LNX.4.56.0501192015560.20796@pentafluge.infradead.org> <200501252058.13632.adaplas@hotpop.com> <Pine.LNX.4.56.0501262104140.15652@pentafluge.infradead.org> <41F949CB.405@comcast.net> <Pine.LNX.4.56.0501282053340.23195@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CuiBG-0003WJ-SN
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Jan 2005 18:17:46 -0800
Received: from rwcrmhc13.comcast.net ([204.127.198.39])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CuiBB-0000Us-Bx
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Jan 2005 18:17:46 -0800
In-Reply-To: <Pine.LNX.4.56.0501282053340.23195@pentafluge.infradead.org>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

I'm all for replacing my low level functions with existing
functions, since that will reduce the size of FBUI,
plus if people have already written accelerated routines
it could benefit FBUI greatly.


James Simmons wrote:

>Actually I have taken a look at your code. It's has potential for selling 
>to some embedded vendor. Alot of the stuff you add is indeed missing but
>mostly can be implemented with what we already have. For example:
>
>fb_clear is really fb_fillrect with a rop of ROP_CLEAR. This is something 
>I know Petr has been asking for :-) Which I want to implement.
>
>fb_vline is a rectangle with a height of 1.
>
>fb_read_point,fb_point, and fb_hline are really
>
>struct fb_pixmap {
>	inbuf
>	outbuf
>}
>
>We really need a way to get framebuffer data which you did with 
>fb_getpixels. I plan to expand fb_imageblit to create a image from 
>the framebuffer. I like to see fb_read use this.
>
>Why a copyarea2 ?
>
>  
>
>>I just want to make a tangential comment, call it trivia almost,
>>but if we wanted to use my in-kernel GUI -- FBUI -- to handle
>>the graphics during startup, including the penguin image, or
>>even to handle the virtual console terminal itself or the login
>>prompt, then I expect that can be done.
>>
>>Zack Smith
>>home.comcast.net/~plinius/fbui.html
>>    
>>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
>Tool for open source databases. Create drag-&-drop reports. Save time
>by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
>Download a FREE copy at http://www.intelliview.com/go/osdn_nl
>_______________________________________________
>Linux-fbdev-devel mailing list
>Linux-fbdev-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>
>  
>



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
