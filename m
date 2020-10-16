From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 16 Oct 2020 21:44:20 +0000
Subject: Re: [PATCH -next] fbdev: nvidia: use for_each_child_of_node() macro
Message-Id: <20201016214420.GC1962741@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200916062123.190636-1-miaoqinglang@huawei.com>
In-Reply-To: <20200916062123.190636-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Qinglang Miao <miaoqinglang@huawei.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi Qinglang Miao

On Wed, Sep 16, 2020 at 02:21:23PM +0800, Qinglang Miao wrote:
> Use for_each_child_of_node() macro instead of open coding it.
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>

Applied to drm-misc-next.

	Sam

> ---
>  drivers/video/fbdev/nvidia/nv_of.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/nvidia/nv_of.c b/drivers/video/fbdev/nvidia/nv_of.c
> index 5f3e5179c..d20b8779b 100644
> --- a/drivers/video/fbdev/nvidia/nv_of.c
> +++ b/drivers/video/fbdev/nvidia/nv_of.c
> @@ -42,8 +42,7 @@ int nvidia_probe_of_connector(struct fb_info *info, int conn, u8 **out_edid)
>  		const char *pname;
>  		int len;
>  
> -		for (dp = NULL;
> -		     (dp = of_get_next_child(parent, dp)) != NULL;) {
> +		for_each_child_of_node(parent, dp) {
>  			pname = of_get_property(dp, "name", NULL);
>  			if (!pname)
>  				continue;
> -- 
> 2.23.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
