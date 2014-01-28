From: Kees Cook <keescook@chromium.org>
Date: Tue, 28 Jan 2014 21:28:06 +0000
Subject: Re: some divide by zero bugs in >fb_check_var() functions
Message-Id: <CAGXu5jJ31ZiTuG0u1F1X_00W7bRBrY_4y81gACyx6u8-kYqM3Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140124223503.GA4251@elgon.mountain>
In-Reply-To: <20140124223503.GA4251@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, Jan 24, 2014 at 2:35 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> My static checker find a number of divide by zero bugs in
> ->fb_check_var() functions.  The call tree looks like this:
>
>   do_fb_ioctl() <- get var from the user.
>   -> fb_set_var()
>      -> info->fbops->fb_check_var(var, info); <- divide by zero bugs
>
> I wonder if we could add some checking in fb_set_var() to prevent this.
>
> drivers/video/asiliantfb.c:230 asiliantfb_check_var() error: potential divide by zero bug '/ var->pixclock'.
> drivers/video/asiliantfb.c:231 asiliantfb_check_var() error: potential divide by zero bug '/ var->pixclock'.
> drivers/video/asiliantfb.c:232 asiliantfb_check_var() error: potential divide by zero bug '/ var->pixclock'.
> drivers/video/cirrusfb.c:535 cirrusfb_check_var() error: potential divide by zero bug '/ var->bits_per_pixel'.
> drivers/video/cirrusfb.c:581 cirrusfb_check_var() error: potential divide by zero bug '/ var->xres_virtual'.
> drivers/video/cyber2000fb.c:843 cyber2000fb_check_var() error: potential divide by zero bug '/ (var->bits_per_pixel * var->xres_virtual)'.
> drivers/video/imsttfb.c:843 imsttfb_check_var() error: potential divide by zero bug '/ var->xres_virtual'.
> drivers/video/neofb.c:594 neofb_check_var() error: potential divide by zero bug '/ (var->pixclock)'.
> drivers/video/neofb.c:702 neofb_check_var() error: potential divide by zero bug '/ (var->xres_virtual * var->bits_per_pixel)'.
> drivers/video/pm2fb.c:624 pm2fb_check_var() error: potential divide by zero bug '/ (var->pixclock)'.
> drivers/video/pm3fb.c:1007 pm3fb_check_var() error: potential divide by zero bug '/ (var->pixclock)'.
> drivers/video/s3fb.c:601 s3fb_check_var() error: potential divide by zero bug '/ (var->pixclock)'.
> drivers/video/savage/savagefb_driver.c:952 savagefb_check_var() error: potential divide by zero bug '/ (var->xres_virtual * var->bits_per_pixel)'.
> drivers/video/sstfb.c:359 sstfb_check_var() error: potential divide by zero bug '/ (var->pixclock)'.
> drivers/video/sstfb.c:361 sstfb_check_var() error: potential divide by zero bug '/ (var->pixclock)'.
> drivers/video/tdfxfb.c:518 tdfxfb_check_var() error: potential divide by zero bug '/ (var->pixclock)'.
> drivers/video/tdfxfb.c:519 tdfxfb_check_var() error: potential divide by zero bug '/ (var->pixclock)'.
> drivers/video/tridentfb.c:918 tridentfb_check_var() error: potential divide by zero bug '/ line_length'.
> drivers/video/tridentfb.c:973 tridentfb_check_var() error: potential divide by zero bug '/ (var->pixclock)'.

Is it ever valid to have pixclock, xres_virtual, or bits_per_pixel be
zero? Seems like it'd be trivial to check for those in fb_set_var()?

-Kees

-- 
Kees Cook
Chrome OS Security
