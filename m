From: James Simmons <jsimmons@infradead.org>
Subject: Re: fbdev changes.
Date: Fri, 18 Oct 2002 14:19:21 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210181400360.3591-100000@maxwell.earthlink.net>
References: <1034813995.563.32.camel@daplas>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 182edG-00063H-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Oct 2002 14:26:10 -0700
In-Reply-To: <1034813995.563.32.camel@daplas>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> Hi James,
>
> Since you seem to be very busy, here's an idea for the framebuffer
> cursor API.

I looked over your patch and even tested it out. Then I thought about it a
long time. The question I had to ask myself is what do we want when we
have fbdev stand alone and fbdev with framebuffer console. Also how to use
a little code as possible (for embedded systems). So the goals are

1) For stand alone fbdev we want the maximum support for a cursor. But
   what if we don't have a hardware cursor. In this case we should leave
   it to userland to handle making it own cursor. The userland app might
   not even want a cursor. So we avoid having extra code in the kernel for
   a software cursor.

2) For fbcon the only thing we need for a cursor is a little rectangle. We
   could still use imageblit but is seems really heavy when you consider
   saving a bitmap of the current text under the cursor. True you have a
   cost at reading the framebuffer when using fillrect but doesn't it cost
   also to save the text bitmap under the cursor as well ? The question is
   which cost more.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
