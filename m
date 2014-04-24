From: Bryan Wu <cooloney@gmail.com>
Date: Thu, 24 Apr 2014 16:36:12 +0000
Subject: Re: [PATCH] video/backlight: Fix string type mismatch in s6e63m0.c
Message-Id: <CAK5ve-KyoLaJxZWDokKTyKvvXK0w6vVWFS7AWM6G-dzDkbKpDA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398354436-25467-1-git-send-email-standby24x7@gmail.com>
In-Reply-To: <1398354436-25467-1-git-send-email-standby24x7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Masanari Iida <standby24x7@gmail.com>
Cc: Jingoo Han <jg1.han@samsung.com>, Lee Jones <lee.jones@linaro.org>, FBDEV list <linux-fbdev@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

On Thu, Apr 24, 2014 at 8:47 AM, Masanari Iida <standby24x7@gmail.com> wrote:
> Fix string type mismatch in s6e63m0_sysfs_show_gamma_table().
> gamma_table_count is defined as unsigned int.
>

Looks good to me,
Acked-by: Bryan Wu <cooloney@gmail.com>

> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> ---
>  drivers/video/backlight/s6e63m0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/backlight/s6e63m0.c b/drivers/video/backlight/s6e63m0.c
> index 510a1bc..2d6d481 100644
> --- a/drivers/video/backlight/s6e63m0.c
> +++ b/drivers/video/backlight/s6e63m0.c
> @@ -703,7 +703,7 @@ static ssize_t s6e63m0_sysfs_show_gamma_table(struct device *dev,
>         struct s6e63m0 *lcd = dev_get_drvdata(dev);
>         char temp[3];
>
> -       sprintf(temp, "%d\n", lcd->gamma_table_count);
> +       sprintf(temp, "%u\n", lcd->gamma_table_count);
>         strcpy(buf, temp);
>
>         return strlen(buf);
> --
> 2.0.0.rc0.26.g779792a
>
