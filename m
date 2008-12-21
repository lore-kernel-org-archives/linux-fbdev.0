From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.27 1/2] fbdev: add E-Ink
	Broadsheet controller support
Date: Sun, 21 Dec 2008 06:12:04 -0500
Message-ID: <45a44e480812210312i2ebf8624pc85cc5447adec204@mail.gmail.com>
References: <12298571743158-git-send-email-jayakumar.lkml@gmail.com>
	<20081221110657.GA20251@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jayakumar.lkml@gmail.com>) id 1LEMED-00023V-13
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 21 Dec 2008 11:12:09 +0000
Received: from mail-ew0-f21.google.com ([209.85.219.21])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LEMEB-0001fa-1s for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 21 Dec 2008 11:12:09 +0000
Received: by ewy14 with SMTP id 14so1920239ewy.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 21 Dec 2008 03:12:05 -0800 (PST)
In-Reply-To: <20081221110657.GA20251@n2100.arm.linux.org.uk>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux@arm.linux.org.uk
Cc: Eric Miao <eric.miao@marvell.com>, linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>, linux-arm-kernel@lists.arm.linux.org.uk

On Sun, Dec 21, 2008 at 6:06 AM,  <linux@arm.linux.org.uk> wrote:
> On Sun, Dec 21, 2008 at 06:59:34PM +0800, Jaya Kumar wrote:
>> +static void broadsheetfb_dpy_update_pages(struct broadsheetfb_par *par,
>> +                                             u16 y1, u16 y2)
>> +{
>> +     u16 args[5];
>> +     unsigned char *buf = (unsigned char __force *)par->info->screen_base;
>
> You shouldn't add __force inside drivers.

Ok, will take that out.

>
>> +     videomemorysize = (DPY_W*DPY_H);
>> +     videomemory = vmalloc(videomemorysize);
>> +     if (!videomemory)
>> +             goto err_fb_rel;
>> +
>> +     memset(videomemory, 0, videomemorysize);
>> +
>> +     info->screen_base = (char __force __iomem *)videomemory;
>
> Ditto.

Ok, will take that out.

>
> Also, using vmalloc for the backing store means this memory can't be
> mmap()'d into userspace, which is a very common thing for framebuffer
> using programs to do.  If mmap() is to be denied, then you should
> provide a mmap implementation in the fb_ops structure.
>

I'm not sure I understand. broadsheetfb relies on defio to handle the
mmap and setup the fb_ops mmap handler. I'm using Xfbdev with this and
it works fine.

youtube clip of broadsheetfb with xeyes, xclock and rgbpaint here:
http://www.youtube.com/watch?v=ph48pWz2B3s

Thanks,
jaya

------------------------------------------------------------------------------
