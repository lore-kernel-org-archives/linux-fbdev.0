From: linux@arm.linux.org.uk
Subject: Re: [RFC 2.6.27 1/2] fbdev: add E-Ink
	Broadsheet controller support
Date: Sun, 21 Dec 2008 11:06:57 +0000
Message-ID: <20081221110657.GA20251@n2100.arm.linux.org.uk>
References: <12298571743158-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69) (envelope-from
	<linux+linux-fbdev-devel=lists.sourceforge.net@arm.linux.org.uk>)
	id 1LEM9j-0002Wz-0b for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 21 Dec 2008 11:07:31 +0000
Received: from caramon.arm.linux.org.uk ([78.32.30.218])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LEM9e-0006tc-JM
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 21 Dec 2008 11:07:30 +0000
Content-Disposition: inline
In-Reply-To: <12298571743158-git-send-email-jayakumar.lkml@gmail.com>
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

On Sun, Dec 21, 2008 at 06:59:34PM +0800, Jaya Kumar wrote:
> +static void broadsheetfb_dpy_update_pages(struct broadsheetfb_par *par,
> +						u16 y1, u16 y2)
> +{
> +	u16 args[5];
> +	unsigned char *buf = (unsigned char __force *)par->info->screen_base;

You shouldn't add __force inside drivers.

> +	videomemorysize = (DPY_W*DPY_H);
> +	videomemory = vmalloc(videomemorysize);
> +	if (!videomemory)
> +		goto err_fb_rel;
> +
> +	memset(videomemory, 0, videomemorysize);
> +
> +	info->screen_base = (char __force __iomem *)videomemory;

Ditto.

Also, using vmalloc for the backing store means this memory can't be
mmap()'d into userspace, which is a very common thing for framebuffer
using programs to do.  If mmap() is to be denied, then you should
provide a mmap implementation in the fb_ops structure.

------------------------------------------------------------------------------
