From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH][1/2] add new Cobalt LCD framebuffer driver
Date: Tue, 24 Jun 2008 14:15:15 -0700
Message-ID: <20080624141515.f710969a.akpm@linux-foundation.org>
References: <20080624224654.1ef3d665.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20080624224654.1ef3d665.yoichi_yuasa@tripeaks.co.jp>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Cc: linux-fbdev-devel@lists.sourceforge.net, yoichi_yuasa@tripeaks.co.jp, ralf@linux-mips.org, linux-mips@linux-mips.org

On Tue, 24 Jun 2008 22:46:54 +0900
Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:

> Add new Cobalt LCD framebuffer driver.
> 
> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> 
>
> ...
>
> +static ssize_t cobalt_lcdfb_read(struct fb_info *info, char __user *buf,
> +				 size_t count, loff_t *ppos)
> +{
> +	char src[LCD_CHARS_MAX];
> +	unsigned long pos;
> +	int len, retval;
> +
> +	pos = *ppos;
> +	if (pos >= LCD_CHARS_MAX)
> +		return 0;
> +
> +	if (pos + count >= LCD_CHARS_MAX)
> +		count = LCD_CHARS_MAX - pos;

I think if sizeof(pos) == sizeof(count), and `count' is sufficiently
large (eg: 0xffffffff) then bad things will happen in this function.

> +	for (len = 0; len < count; len++) {
> +		retval = lcd_busy_wait(info);
> +		if (retval < 0)
> +			break;
> +
> +		lcd_write_control(info, LCD_TEXT_POS(pos));
> +
> +		retval = lcd_busy_wait(info);
> +		if (retval < 0)
> +			break;
> +
> +		src[len] = lcd_read_data(info);
> +		if (pos == 0x0f)
> +			pos = 0x40;
> +		else
> +			pos++;
> +	}
> +
> +	if (copy_to_user(buf, src, len))
> +		return -EFAULT;
> +
> +	*ppos += len;
> +
> +	return len;
> +}
> +
> +static ssize_t cobalt_lcdfb_write(struct fb_info *info, const char __user *buf,
> +				  size_t count, loff_t *ppos)
> +{
> +	char dst[LCD_CHARS_MAX];
> +	unsigned long pos;
> +	int len, retval;
> +
> +	pos = *ppos;
> +	if (pos >= LCD_CHARS_MAX)
> +		return 0;
> +
> +	if (pos + count >= LCD_CHARS_MAX)
> +		count = LCD_CHARS_MAX - pos;

Ditto.

> +	if (copy_from_user(dst, buf, count))
> +		return -EFAULT;
> +
> +	for (len = 0; len < count; len++) {
> +		retval = lcd_busy_wait(info);
> +		if (retval < 0)
> +			break;
> +
> +		lcd_write_control(info, LCD_TEXT_POS(pos));
> +
> +		retval = lcd_busy_wait(info);
> +		if (retval < 0)
> +			break;
> +
> +		lcd_write_data(info, dst[len]);
> +		if (pos == 0x0f)
> +			pos = 0x40;
> +		else
> +			pos++;
> +	}
> +
> +	*ppos += len;
> +
> +	return len;
> +}

Is there any real benefit in this handling of signal_pending()?  afaict
it is done correctly, but why did we bother doing it?
