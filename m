From: Rob Clark <robdclark@gmail.com>
Date: Thu, 19 Sep 2013 15:14:58 +0000
Subject: Re: [PATCH] OMAPDSS: DISPC: set irq_safe for runtime PM
Message-Id: <CAF6AEGupG6X4GqwaSm35u4tsW-ZQeCe8hqgbtDwxUcp6xwQ-nA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1379585958-24537-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1379585958-24537-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Sep 19, 2013 at 6:19 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> We have a bug with omapdrm, where omapdrm calls dispc's pm_runtime
> function in atomic context, and dispc's pm_runtime is not marked as
> irq_safe:
>
> BUG: sleeping function called from invalid context at drivers/base/power/runtime.c:952
>
> Dispc's runtime PM callbacks are irq safe, so we can just set the
> irq_safe flag to fix the issue.
>
> However, in the long term, I'd rather have omapdrm manage the runtime PM
> calls in a better way. Calling get/put for every small operation that
> touches the dispc registers is very inefficient. It'd be better and
> cleaner to have clear "in-use" and "not-in-use" states for dispc, so
> that we don't need to do register context restore for small operations,
> only to turn dispc off right afterwards.

hmm, quick mid-conference thought:  in msm, in crtc->prepare and
crtc->dpms(ON) I do clk_prepare_enable(), and inverse in
commit()/dpms(OFF).  (The extra ref held between prepare() and
commit() avoids turning things off mid-modeset.)  The net effect is
that we hold things on when the display is on.  Probably we should do
something similar in omapdrm?

BR,
-R


> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
> index 02a7340..4779750 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -3691,6 +3691,7 @@ static int __init omap_dispchw_probe(struct platform_device *pdev)
>         }
>
>         pm_runtime_enable(&pdev->dev);
> +       pm_runtime_irq_safe(&pdev->dev);
>
>         r = dispc_runtime_get();
>         if (r)
> --
> 1.8.1.2
>
