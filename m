From: Zack <plinius@comcast.net>
Subject: Re: fbdraw 0.1 available
Date: Sat, 11 Sep 2004 11:09:32 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <41433F5C.70603@comcast.net>
References: <41426651.2010201@comcast.net> <Pine.GSO.4.58.0409111241390.17924@waterleaf.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C6CJ0-0001Lu-Uq
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 11 Sep 2004 11:08:58 -0700
Received: from rwcrmhc13.comcast.net ([204.127.198.39])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C6CJ0-0004YV-AH
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 11 Sep 2004 11:08:58 -0700
In-Reply-To: <Pine.GSO.4.58.0409111241390.17924@waterleaf.sonytel.be>
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

Geert Uytterhoeven wrote:
> 
>   - Is there any special reason why you implement your own fb_fill_area() and
>     fb_copy_area() (which doesn't do anything?), while fb_fillrect() and
>     fb_copyarea() already exist?

Yes, for 3 reasons:
1. I want to be able to clip graphics to a subset of the screen, so that
later the screen will be shareable between processes. In 0.1b, this
clipping works quite effectively.
2. I wanted to increase the speed. My routine's loops are slightly
unfolded to avoid branching and the performance is therefore better.
3. If I later update it for MMX or other changes, it would be
easier for me to do so if it's my code and infrastructure.

>   - Do you have compared the performance of your fbdraw compared to user space
>     mmap()ing the frame buffer and doing all drawings in user space?

Well, no. As I mentioned before the reason for putting things in the
kernel is that it ensures the code will remain small and more
carefully optimized. Most things in userspace tend to become bloated
eventually and often never get optimized.

> BTW, I'm also considering exporting fb_fillrect(), fb_copyarea(), and
> fb_imageblit() to userspace, but for a different reason.

> Right now applications need to know the exact frame buffer layout. For most
> modern PC graphics cards that's OK, since they all do cfb8/16/24/32. But older
> (usually unaccelerated) and embedded hardware may use a different layout (e.g.
> seperate buffers for even and odd display lines on some set top box hardware,
> bitplanes, ...) putting a severe burden on applications.

I agree that odd hardware is a burden, and one which fbdraw can
alleviate by hiding the complexity behind the abstraction.

Speaking of which, I wrote a set of fast 4bpp VGA routines that are
equivalent to the fbdraw routines. The latest version I wrote in
16bit x86 assembly so they are very fast. It will eventually add
these to fb.

> By letting the application draw to a fixed format cfb8 (pseudocolor) or cfb32
> (RGBA) shadow buffer and call the kernel for updating the screen, this can be
> solved in a generic way.  Currently now fb_imageblit() already has to do the
> conversion from cfb8 to native layout anyway.

But that shadow buffer is bloat, and the blit takes time.

If you want to draw an RGB image onto the screen, better to convert
it to native format and draw that quickly. If you have to draw it
again later, you'll hopefully have the native copy available.

Ciao,
Zack


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
