From: linux@arm.linux.org.uk
Subject: Re: [RFC 2.6.27 1/2] fbdev: add E-Ink
	Broadsheet controller support
Date: Sun, 21 Dec 2008 11:15:23 +0000
Message-ID: <20081221111523.GB20251@n2100.arm.linux.org.uk>
References: <12298571743158-git-send-email-jayakumar.lkml@gmail.com>
	<20081221110657.GA20251@n2100.arm.linux.org.uk>
	<45a44e480812210312i2ebf8624pc85cc5447adec204@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69) (envelope-from
	<linux+linux-fbdev-devel=lists.sourceforge.net@arm.linux.org.uk>)
	id 1LEMHl-0006by-HV for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 21 Dec 2008 11:15:49 +0000
Received: from caramon.arm.linux.org.uk ([78.32.30.218])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LEMHi-0001sb-H5
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 21 Dec 2008 11:15:49 +0000
Content-Disposition: inline
In-Reply-To: <45a44e480812210312i2ebf8624pc85cc5447adec204@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: Eric Miao <eric.miao@marvell.com>, linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>, linux-arm-kernel@lists.arm.linux.org.uk

On Sun, Dec 21, 2008 at 06:12:04AM -0500, Jaya Kumar wrote:
> On Sun, Dec 21, 2008 at 6:06 AM,  <linux@arm.linux.org.uk> wrote:
> > Also, using vmalloc for the backing store means this memory can't be
> > mmap()'d into userspace, which is a very common thing for framebuffer
> > using programs to do.  If mmap() is to be denied, then you should
> > provide a mmap implementation in the fb_ops structure.
> >
> 
> I'm not sure I understand. broadsheetfb relies on defio to handle the
> mmap and setup the fb_ops mmap handler. I'm using Xfbdev with this and
> it works fine.

Ah, I see how it's working.  That's fine.

------------------------------------------------------------------------------
