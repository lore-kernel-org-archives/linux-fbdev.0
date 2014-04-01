From: Jon Ringle <jon@ringle.org>
Date: Tue, 01 Apr 2014 12:36:03 +0000
Subject: Re: [PATCH v2 1/2] video: da8xx-fb: Add support for Densitron 84-0023-001T
Message-Id: <CAMwGMjwmkeET-K7w1tEESS8Ram278aELs0_x+Gt6+Y3j4kLV0Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1396355585-458-1-git-send-email-jon@ringle.org>
In-Reply-To: <1396355585-458-1-git-send-email-jon@ringle.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org
Cc: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, Jon Ringle <jringle@gridpoint.com>

On Tue, Apr 1, 2014 at 8:33 AM,  <jon@ringle.org> wrote:
> From: Jon Ringle <jringle@gridpoint.com>
>
> Signed-off-by: Jon Ringle <jringle@gridpoint.com>
> ---
>  drivers/video/da8xx-fb.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> index e030e17..d042624 100644
> --- a/drivers/video/da8xx-fb.c
> +++ b/drivers/video/da8xx-fb.c
> @@ -243,6 +243,20 @@ static struct fb_videomode known_lcd_panels[] = {
>                 .sync           = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
>                 .flag           = 0,
>         },
> +       [3] = {
> +               /* Densitron 84-0023-001T */
> +               .name           = "Densitron_LCD",

Crap. I'm sorry. I will resend again. with the correct patch with the
name Tomi suggested

Jon
