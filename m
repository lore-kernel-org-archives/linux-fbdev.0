From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Subject: Re: [PATCH][1/2] add new Cobalt LCD framebuffer
	driver
Date: Wed, 25 Jun 2008 22:46:53 +0900
Message-ID: <20080625224653.35f4478a.yoichi_yuasa@tripeaks.co.jp>
References: <20080624224654.1ef3d665.yoichi_yuasa@tripeaks.co.jp>
	<20080624141515.f710969a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KBVLW-0007KA-4x for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Jun 2008 06:47:38 -0700
Received: from mo30.po.2iij.net ([210.128.50.53])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KBVLU-0001tH-MT
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Jun 2008 06:47:38 -0700
In-Reply-To: <20080624141515.f710969a.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mips@linux-mips.org, linux-fbdev-devel@lists.sourceforge.net, ralf@linux-mips.org, yoichi_yuasa@tripeaks.co.jp

On Tue, 24 Jun 2008 14:15:15 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 24 Jun 2008 22:46:54 +0900
> Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> 
> > Add new Cobalt LCD framebuffer driver.
> > 
> > Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> > 
> >
> > ...
> >
> > +static ssize_t cobalt_lcdfb_read(struct fb_info *info, char __user *buf,
> > +				 size_t count, loff_t *ppos)
> > +{
> > +	char src[LCD_CHARS_MAX];
> > +	unsigned long pos;
> > +	int len, retval;
> > +
> > +	pos = *ppos;
> > +	if (pos >= LCD_CHARS_MAX)
> > +		return 0;
> > +
> > +	if (pos + count >= LCD_CHARS_MAX)
> > +		count = LCD_CHARS_MAX - pos;
> 
> I think if sizeof(pos) == sizeof(count), and `count' is sufficiently
> large (eg: 0xffffffff) then bad things will happen in this function.
> 
> > +	for (len = 0; len < count; len++) {
> > +		retval = lcd_busy_wait(info);
> > +		if (retval < 0)
> > +			break;
> > +
> > +		lcd_write_control(info, LCD_TEXT_POS(pos));
> > +
> > +		retval = lcd_busy_wait(info);
> > +		if (retval < 0)
> > +			break;
> > +
> > +		src[len] = lcd_read_data(info);
> > +		if (pos == 0x0f)
> > +			pos = 0x40;
> > +		else
> > +			pos++;
> > +	}
> > +
> > +	if (copy_to_user(buf, src, len))
> > +		return -EFAULT;
> > +
> > +	*ppos += len;
> > +
> > +	return len;
> > +}
> > +
> > +static ssize_t cobalt_lcdfb_write(struct fb_info *info, const char __user *buf,
> > +				  size_t count, loff_t *ppos)
> > +{
> > +	char dst[LCD_CHARS_MAX];
> > +	unsigned long pos;
> > +	int len, retval;
> > +
> > +	pos = *ppos;
> > +	if (pos >= LCD_CHARS_MAX)
> > +		return 0;
> > +
> > +	if (pos + count >= LCD_CHARS_MAX)
> > +		count = LCD_CHARS_MAX - pos;
> 
> Ditto.
> 
> > +	if (copy_from_user(dst, buf, count))
> > +		return -EFAULT;
> > +
> > +	for (len = 0; len < count; len++) {
> > +		retval = lcd_busy_wait(info);
> > +		if (retval < 0)
> > +			break;
> > +
> > +		lcd_write_control(info, LCD_TEXT_POS(pos));
> > +
> > +		retval = lcd_busy_wait(info);
> > +		if (retval < 0)
> > +			break;
> > +
> > +		lcd_write_data(info, dst[len]);
> > +		if (pos == 0x0f)
> > +			pos = 0x40;
> > +		else
> > +			pos++;
> > +	}
> > +
> > +	*ppos += len;
> > +
> > +	return len;
> > +}
> 
> Is there any real benefit in this handling of signal_pending()?  afaict
> it is done correctly, but why did we bother doing it?
> 

Thank you for your comments.
I'll update it.

Yoichi

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
