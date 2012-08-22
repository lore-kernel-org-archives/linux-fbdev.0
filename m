From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Wed, 22 Aug 2012 05:40:27 +0000
Subject: RE: [PATCH v5] da8xx-fb: add 24bpp LCD configuration support
Message-Id: <A73F36158E33644199EB82C5EC81C7BC3E9A723C@DBDE01.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344950502-18835-1-git-send-email-prakash.pm@ti.com>
In-Reply-To: <1344950502-18835-1-git-send-email-prakash.pm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Florian Tobias Schandinat,

If you do not have any review comments could you please accept this patch?

Thanks,
Prakash
On Tue, Aug 14, 2012 at 18:51:42, Manjunathappa, Prakash wrote:
> LCD controller on am335x supports 24bpp raster configuration in addition
> to ones on da850. LCDC also supports 24bpp in unpacked format having
> ARGB:8888 32bpp format data in DDR, but it doesn't interpret alpha
> component of the data.
> 
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> Cc: Anatolij Gustschin <agust@denx.de>
> ---
> Applies on top of fbdev-next of Florian Tobias Schandinat's tree.
> Since v4:
> Re-define CNVT_TOHW macro.
> Since v3:
> Minor nit, declare pseudo_palette as u32 type.
> Since v2:
> Fixed additional configurations for 24bpp support.
> Since v1:
> Simplified calculation of pseudopalette for FB_VISUAL_TRUECOLOR type.
> 
>  drivers/video/da8xx-fb.c |  132 +++++++++++++++++++++++++++++++++------------
>  1 files changed, 97 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> index cb696ff..5c6df7b 100644
> --- a/drivers/video/da8xx-fb.c
> +++ b/drivers/video/da8xx-fb.c
> @@ -87,6 +87,8 @@

[...]
