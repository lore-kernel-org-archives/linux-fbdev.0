From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [PATCH 01/05] video: deferred io sys helpers - core V2
Date: Fri, 26 Dec 2008 03:03:30 +0800
Message-ID: <45a44e480812251103m5129d575lfffda361b11dd4d6@mail.gmail.com>
References: <20081224082946.1848.46644.sendpatchset@rx1.opensource.se>
	 <20081224082954.1848.42892.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20081224082954.1848.42892.sendpatchset@rx1.opensource.se>
Content-Disposition: inline
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, aliguori@us.ibm.com, adaplas@gmail.com, linux-sh@vger.kernel.org, armbru@redhat.com, lethal@linux-sh.org

On Wed, Dec 24, 2008 at 3:29 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm@igel.co.jp>
>
> Add shared sys helpers to the deferred io code. Instead of duplicating
> the code in each driver we can keep it in one place. This saves a
> few lines. The new helper functions make use of the deferred io delay.
> While at it, keep track of the dirty area to allow partial screen update.

Hi Magnus,

Ok, while the overall patchset looks good, I still had trouble with
the dx, dy, w, h stuff. It had me a bit confused. The above comment
about keeping track of the dirty area made me realize why I think that
portion can be improved. The reason is that we already have a pagelist
to track touched pages and the dx, dy, w, h stuff duplicates that. I
have an idea of how we can avoid this duplication which I'll sketch
below.

> +ssize_t fb_deferred_io_write(struct fb_info *info, const char __user *buf,
> +                            size_t count, loff_t *ppos)
> +{
> +       int ret = fb_sys_write(info, buf, count, ppos);
> +
> +       if (ret > 0)
> +               fb_deferred_io_touch(info, 0, 0, INT_MAX, INT_MAX);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(fb_deferred_io_write);

As you have noticed, doing it using x, y, w, h results in needing to
do things like INT_MAX above and side effects like dx != -1 in the
client drivers. I think that we can avoid this. Instead, I would
prepare the pagelist directly in write, imageblit, etc since we know
exactly which pages have been touched.

I guess this would be better explained if I posted some sample code
rather than just talking about it so I'll do a quick and dirty
implementation for write only in metronomefb so that we can discuss
this further.

Thanks,
jaya
