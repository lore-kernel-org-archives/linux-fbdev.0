From: Archit Taneja <a0393947@ti.com>
Date: Wed, 05 Sep 2012 13:55:41 +0000
Subject: Re: [PATCH 13/17] Revert "OMAPDSS: APPLY: add fifo-merge support"
Message-Id: <5047570D.1030601@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com> <1346833555-31258-14-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1346833555-31258-14-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Wednesday 05 September 2012 01:55 PM, Tomi Valkeinen wrote:
> This reverts commit 1d71f42b35ed66d90a9a39bc515bb16cfe2d4a46.
>
> Adding fifo merge feature as an omapdss internal configuration was a
> mistake. We cannot hide from the users of omapdss the complexities of
> fifo merge.
>
> This commit removes the fifo merge support, which luckily is easily done
> as it was handled totally inside apply.c.
>
> The plan is to try fifo merge again later when it is more clear how the
> hardware acts in various situations, and how the omapdrm wants to use
> fifo merge.

Nitpick: This isn't an exact revert right? Maybe we should mention that, 
so that if someone tries to apply the old patch, it doesn't fail.

>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   drivers/video/omap2/dss/apply.c |  154 ++-------------------------------------
>   1 file changed, 8 insertions(+), 146 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
> index 1b49019..02943a5 100644
> --- a/drivers/video/omap2/dss/apply.c
> +++ b/drivers/video/omap2/dss/apply.c
> @@ -993,11 +993,11 @@ static void dss_apply_fifo_merge(bool use_fifo_merge)
>   	dss_data.fifo_merge_dirty = true;
>   }
>
> -static void dss_ovl_setup_fifo(struct omap_overlay *ovl,
> -		bool use_fifo_merge)
> +static void dss_ovl_setup_fifo(struct omap_overlay *ovl)
>   {
>   	struct ovl_priv_data *op = get_ovl_priv(ovl);
>   	u32 fifo_low, fifo_high;
> +	bool use_fifo_merge = false;

This looks like the line which wasn't removed in the original commit.

Archit

