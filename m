From: Eric Miao <eric.y.miao@gmail.com>
Date: Wed, 16 Mar 2011 13:15:45 +0000
Subject: Re: [PATCH 3/4] ARM: PXA: PXAFB: Fix typo in ypos assignment
Message-Id: <AANLkTimzgvGTru1-YHB=uT5qhgCvVy2DxW1G6Xsk7hmQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201103060030.59584.anarsoul@gmail.com>
	<1299835250-11095-1-git-send-email-anarsoul@gmail.com>
	<1299835250-11095-3-git-send-email-anarsoul@gmail.com>
In-Reply-To: <1299835250-11095-3-git-send-email-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

Applied.

On Fri, Mar 11, 2011 at 5:20 PM, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> Sascha Hauer <s.hauer@pengutronix.de> pointed that
> ypos takes value of xpos due to typo.
>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/video/pxafb.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
> index e2f643e..a3bdcc1 100644
> --- a/drivers/video/pxafb.c
> +++ b/drivers/video/pxafb.c
> @@ -761,7 +761,7 @@ static int overlayfb_check_var(struct fb_var_screeninfo *var,
>        int xpos, ypos, pfor, bpp;
>
>        xpos = NONSTD_TO_XPOS(var->nonstd);
> -       ypos = NONSTD_TO_XPOS(var->nonstd);
> +       ypos = NONSTD_TO_YPOS(var->nonstd);
>        pfor = NONSTD_TO_PFOR(var->nonstd);
>
>        bpp = pxafb_var_to_bpp(var);
> @@ -842,7 +842,7 @@ static int overlayfb_set_par(struct fb_info *info)
>
>        bpp  = pxafb_var_to_bpp(var);
>        xpos = NONSTD_TO_XPOS(var->nonstd);
> -       ypos = NONSTD_TO_XPOS(var->nonstd);
> +       ypos = NONSTD_TO_YPOS(var->nonstd);
>        pfor = NONSTD_TO_PFOR(var->nonstd);
>
>        ofb->control[0] = OVLxC1_PPL(var->xres) | OVLxC1_LPO(var->yres) |
> --
> 1.7.4.1
>
>
