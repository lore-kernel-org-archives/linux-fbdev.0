From: Antonino Daplas <adaplas@pol.net>
Subject: Re: fbdev changes.
Date: 19 Oct 2002 06:24:59 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1034979869.615.68.camel@daplas>
References: <Pine.LNX.4.33.0210181400360.3591-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 182fem-0007Cv-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Oct 2002 15:31:48 -0700
In-Reply-To: <Pine.LNX.4.33.0210181400360.3591-100000@maxwell.earthlink.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, 2002-10-19 at 05:19, James Simmons wrote:
> 
> > Hi James,
> >
> > Since you seem to be very busy, here's an idea for the framebuffer
> > cursor API.
> 
> I looked over your patch and even tested it out. Then I thought about it a
> long time. The question I had to ask myself is what do we want when we
> have fbdev stand alone and fbdev with framebuffer console. Also how to use
> a little code as possible (for embedded systems). So the goals are
True, that's why the main bulk of the code is in fbcon.c and
fbcon-accel.c.  The driver specific method, fbops->fb_cursor, will only
need to do the minimum, show and display the cursor.  How it wants to
display the cursor does not matter, it can choose to just display a
simple rectangle, ignoring most fields in fbcursor, or use the entire
gamut of information passed by fbcursor to display the correct
attributes of the cursor.  gen_cursor is just fallback.

> 
> 1) For stand alone fbdev we want the maximum support for a cursor. But
>    what if we don't have a hardware cursor. In this case we should leave
>    it to userland to handle making it own cursor. The userland app might
>    not even want a cursor. So we avoid having extra code in the kernel for
>    a software cursor.
I completely agree with you on this.

> 
> 2) For fbcon the only thing we need for a cursor is a little rectangle. We
>    could still use imageblit but is seems really heavy when you consider
>    saving a bitmap of the current text under the cursor. True you have a
>    cost at reading the framebuffer when using fillrect but doesn't it cost
>    also to save the text bitmap under the cursor as well ? The question is
>    which cost more.
> 
Actually the cost of getting the current text under the cursor is not
expensive.  It's just a pointer to the current character in
display->fontdata.  This is extra information which can be completely
ignored if the hardware can do the inversion itself.

Whether we use fillrect or imageblit is a matter of preference.  For
one, fillrect is definitely slower with ROP_XOR than with ROP_COPY (14
seconds vs .256 secs). Secondly, I just thought that imageblit is more
flexible than fillrect.  Also, usage of imageblit, which implies the
presence of a bitmap, is more appropriate for hardware cursors that
require the usage of some form of bitmap. The bitmap will only be loaded
into memory if FB_CUR_SETSIZE and FB_CUR_SETSHAPE flags are set (change
in fontsize and shape), so it will not be very expensive.

My goal was to make the cursor behave correctly, and at the same time,
minimize driver-specific code. I was actually surprised when the cursor
did what it was supposed to do when I followed some of the examples in
linux/Documentation/VGA-Softcursor.txt.  

This is just a suggestion. 

Tony
  
PS:  Is the "final update" patch for fbdev ready?  I downloaded it once,
but it just deleted most of the files :)






-------------------------------------------------------
This sf.net email is sponsored by:
Access Your PC Securely with GoToMyPC. Try Free Now
https://www.gotomypc.com/s/OSND/DD
