From: Belisko Marek <marek.belisko@gmail.com>
Date: Fri, 12 Nov 2010 11:58:19 +0000
Subject: Re: [PATCH] OMAP: DSS2: OMAPFB: Fix null pointer check
Message-Id: <AANLkTik2WToLpQCK7zM+4xwwnbxY_PbRnZF-H40iYhuW@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1289562435-8056-1-git-send-email-samreen@ti.com>
In-Reply-To: <1289562435-8056-1-git-send-email-samreen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Samreen <samreen@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Fri, Nov 12, 2010 at 12:47 PM, Samreen <samreen@ti.com> wrote:
> A null pointer check added.
>
> Signed-off-by: Samreen <samreen@ti.com>
> ---
>  drivers/video/omap2/omapfb/omapfb-main.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
> index 6a704f1..55bed89 100644
> --- a/drivers/video/omap2/omapfb/omapfb-main.c
> +++ b/drivers/video/omap2/omapfb/omapfb-main.c
> @@ -2133,6 +2133,8 @@ static int omapfb_parse_def_modes(struct omapfb2_device *fbdev)
>        int r = 0;
>
>        str = kmalloc(strlen(def_mode) + 1, GFP_KERNEL);
> +       if (str = NULL)
> +               return -EINVAL;
Shouldn't be rerutn _ENNOMEM; instead to get correct error code?
>        strcpy(str, def_mode);
>        options = str;
>
> --
> 1.5.6.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
thank,

marek


-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
icq: 290551086
web: http://open-nandra.com
