From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: Re: kernel: matrox fb - missing files, doesn't compile
Date: Sat, 14 Dec 2002 23:44:26 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021214224426.GG1186@ppc.vc.cvut.cz>
References: <A31FF58755A@vcnet.vc.cvut.cz> <1039912121.1008.59.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from r2w12.mistral.cz
	([62.245.86.12] helo=ppc.vc.cvut.cz ident=root)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18NL28-0003Hj-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 14 Dec 2002 14:45:20 -0800
Content-Disposition: inline
In-Reply-To: <1039912121.1008.59.camel@localhost.localdomain>
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
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Ariel <aslinux@dsgml.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sun, Dec 15, 2002 at 05:30:43AM +0500, Antonino Daplas wrote:
> On Fri, 2002-12-13 at 15:09, Petr Vandrovec wrote:
> > Current interface just supports only cfb, and only very bad for my needs.
> > And because of matroxfb supports also other modes (such as native text
> > mode, or loading font into accelerator), bye-bye. For now I recommend you 
> > either to not upgrade, or use vesafb. Besides that accel_putcs() does not 
> > call fb_sync when using font width which is not multiple of 8, and that 
> Can you explain why an fb_sync is needed for every character?

It is not needed after every character. But I thought that it will be called
before we return to userspace... And I want to rely on fb_sync
because of hardware setup to change fg_color and bg_color is very costly.

In my tests I'm not able to get accelerated code running faster than
at 50% of old speed with 12x22 font, and I'm hoping that eliminating these
two PCI writes could speed it a bit... It will not get on par, but better than
nothing.
 
> > with fonts greater than 16*16 pixels (I believe that such fonts are still 
> > supported...) it will corrupt memory...
> 
> I agree.  To be more specific, buffer overruns will occur if (xres *
> fontheight/8 > 8192).  The pixmap needs to be dynamically allocated and
> resized somewhere in the fbcon layer (ideally in accel_setup(), but this
> was removed).  For those concerned about this problem, you can try this
> patch as a temporary measure until fbcon is fixed. It should not cause
> to much slowdown:

But we may try to allocate buffers of order 2 or even 3 with kmalloc, and
if I remember fork() problems with allocating stack with order=1 correctly,
it is not best idea under the sun. But using physically non-continuous
area is probably even worse idea.

> For anyone concerned, this is a heads up:  The data in the pixmap must
> be read completely by the hardware before exiting, otherwise font
> corruption will occur.  If you think this will be a problem, the
> function can be easily modified to do multiple buffering instead.

What if I'll decide to paint characters through busmastering? Then
I need font data in buffers allocated by pci_alloc_consistent...
In the past it was not a win to use busmastering, but now, when
upper layers might prepare images much larger than 8x16, it may be 
worth of rechecking that...
					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
