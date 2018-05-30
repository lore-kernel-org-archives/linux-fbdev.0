From: Nick Desaulniers <nick.desaulniers@gmail.com>
Date: Wed, 30 May 2018 01:58:38 +0000
Subject: Re: [PATCH] video/hdmi: prefer strlcpy to strncpy
Message-Id: <CAH7mPvioLyWRYz1+yORXbJVaMV+pTLgPKgPZ1OTFLak6tjdZSQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1527577145-7750-1-git-send-email-nick.desaulniers@gmail.com>
In-Reply-To: <1527577145-7750-1-git-send-email-nick.desaulniers@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com
Cc: Nick Desaulniers <nick.desaulniers@gmail.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ebiggers@google.com

On Mon, May 28, 2018 at 11:59 PM, Nick Desaulniers
<nick.desaulniers@gmail.com> wrote:
> Fixes a stringop-truncation warning from gcc-8.
>
> Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
> ---
>  drivers/video/hdmi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
> index 111a0ab..46c184c 100644
> --- a/drivers/video/hdmi.c
> +++ b/drivers/video/hdmi.c
> @@ -168,8 +168,8 @@ int hdmi_spd_infoframe_init(struct hdmi_spd_infoframe *frame,
>         frame->version = 1;
>         frame->length = HDMI_SPD_INFOFRAME_SIZE;
>
> -       strncpy(frame->vendor, vendor, sizeof(frame->vendor));
> -       strncpy(frame->product, product, sizeof(frame->product));
> +       strlcpy(frame->vendor, vendor, sizeof(frame->vendor));
> +       strlcpy(frame->product, product, sizeof(frame->product));
>
>         return 0;
>  }
> --
> 2.7.4
>

Eric points out this can leak kernel memory if size is less than length of src.
