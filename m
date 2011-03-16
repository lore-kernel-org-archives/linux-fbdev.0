From: Eric Miao <eric.y.miao@gmail.com>
Date: Wed, 16 Mar 2011 13:16:42 +0000
Subject: Re: [PATCH 4/4] ARM: PXA: PXAFB: don't disable controller on cpufreq
Message-Id: <AANLkTi=g+Qtm=n+M0c0FxBrqgNy2gt=x46QzeJyDCG9L@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201103060030.59584.anarsoul@gmail.com>
	<1299835250-11095-1-git-send-email-anarsoul@gmail.com>
	<1299835250-11095-4-git-send-email-anarsoul@gmail.com>
In-Reply-To: <1299835250-11095-4-git-send-email-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

Applied.

On Fri, Mar 11, 2011 at 5:20 PM, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> It's not safe to disable controller if overlay(s) is enabled (results in
> system hang). So we avoid to disable controller in this case. Userspace
> should choose proper governor to avoid freq changing when overlay is in
> use, otherwise LCD may blink.
>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/video/pxafb.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
> index a3bdcc1..a2e5b51 100644
> --- a/drivers/video/pxafb.c
> +++ b/drivers/video/pxafb.c
> @@ -1648,7 +1648,8 @@ pxafb_freq_transition(struct notifier_block *nb, unsigned long val, void *data)
>
>        switch (val) {
>        case CPUFREQ_PRECHANGE:
> -               set_ctrlr_state(fbi, C_DISABLE_CLKCHANGE);
> +               if (!fbi->overlay[0].usage && !fbi->overlay[1].usage)
> +                       set_ctrlr_state(fbi, C_DISABLE_CLKCHANGE);
>                break;
>
>        case CPUFREQ_POSTCHANGE:
> --
> 1.7.4.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
