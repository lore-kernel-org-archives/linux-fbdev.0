From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 26 Jul 2020 08:57:00 +0000
Subject: Re: [PATCH] [video/fbdev] mbxfb_remove: fix null pointer dereference
Message-Id: <CAHp75VcL9sT-Ff6FND1v5pWUF=Ey7MXE61uB5Ae3HMpJaOYaUg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200726052047.9856-1-gaurav1086@gmail.com>
In-Reply-To: <20200726052047.9856-1-gaurav1086@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gaurav Singh <gaurav1086@gmail.com>
Cc: "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jani Nikula <jani.nikula@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, open list <linux-kernel@vger.kernel.org>, "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>

On Sun, Jul 26, 2020 at 8:26 AM Gaurav Singh <gaurav1086@gmail.com> wrote:
>
> Function mbxfb_debugfs_remove() accesses fbi->par without NULL check,
> hence do the NULL check in the caller mbxfb_remove().

...

> @@ -1012,11 +1012,10 @@ static int mbxfb_remove(struct platform_device *dev)
>
>         write_reg_dly(SYSRST_RST, SYSRST);
>
> -       mbxfb_debugfs_remove(fbi);
> -

>         if (fbi) {

Can you explain how this is NULL on ->remove()?

I bet this check is simply redundant. But you have to check and update
commit message accordingly.

>                 struct mbxfb_info *mfbi = fbi->par;
>
> +               mbxfb_debugfs_remove(fbi);
>                 unregister_framebuffer(fbi);
>                 if (mfbi) {
>                         if (mfbi->platform_remove)


-- 
With Best Regards,
Andy Shevchenko
