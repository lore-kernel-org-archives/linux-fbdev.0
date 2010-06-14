From: Jaya Kumar <jayakumar.lkml@gmail.com>
Date: Mon, 14 Jun 2010 23:59:54 +0000
Subject: Re: [PATCH v3 10/11] [ARM] tegra: Add framebuffer driver
Message-Id: <AANLkTikqOrciEnESCC1yGm0UvcxdK942ddrZF4K49TVb@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1271198563-10424-1-git-send-email-konkers@android.com>
	<1276549827-2688-1-git-send-email-konkers@android.com>
	<1276549827-2688-2-git-send-email-konkers@android.com>
	<1276549827-2688-3-git-send-email-konkers@android.com>
	<1276549827-2688-4-git-send-email-konkers@android.com>
	<1276549827-2688-5-git-send-email-konkers@android.com>
	<1276549827-2688-6-git-send-email-konkers@android.com>
	<1276549827-2688-7-git-send-email-konkers@android.com>
	<1276549827-2688-8-git-send-email-konkers@android.com>
	<1276549827-2688-9-git-send-email-konkers@android.com>
	<1276549827-2688-10-git-send-email-konkers@android.com>
	<1276549827-2688-11-git-send-email-konkers@android.com>
In-Reply-To: <1276549827-2688-11-git-send-email-konkers@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Tue, Jun 15, 2010 at 5:10 AM, Erik Gilling <konkers@android.com> wrote:
> diff --git a/drivers/video/tegrafb.c b/drivers/video/tegrafb.c
> new file mode 100644
> index 0000000..47b2d42
> --- /dev/null
> +++ b/drivers/video/tegrafb.c

> +/* palette attary used by the fbcon */
> +u32 pseudo_palette[16];

attary

> +
> +irqreturn_t tegra_fb_irq(int irq, void *ptr)
> +{
> + =A0 =A0 =A0 struct fb_info *info =3D ptr;
> + =A0 =A0 =A0 struct tegra_fb_info *tegra_fb =3D info->par;
> +
> + =A0 =A0 =A0 u32 reg =3D tegra_fb_readl(tegra_fb, DC_CMD_INT_STATUS);
> + =A0 =A0 =A0 tegra_fb_writel(tegra_fb, reg, DC_CMD_INT_STATUS);
> +
> + =A0 =A0 =A0 tegra_fb->wait_condition =3D 1;
> + =A0 =A0 =A0 wake_up(&tegra_fb->event_wq);
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> +static int tegra_fb_wait_for_event(struct tegra_fb_info *tegra_fb,
> + =A0 =A0 =A0 unsigned long timeout, u32 irq_mask)
> +{
> + =A0 =A0 =A0 u32 reg;
> +
> + =A0 =A0 =A0 tegra_fb->wait_condition =3D 0;
> +
> + =A0 =A0 =A0 reg =3D tegra_fb_readl(tegra_fb, DC_CMD_INT_MASK);
> + =A0 =A0 =A0 reg |=3D irq_mask;
> + =A0 =A0 =A0 tegra_fb_writel(tegra_fb, reg, DC_CMD_INT_MASK);
> +
> + =A0 =A0 =A0 /* Clear any pending interrupt */
> + =A0 =A0 =A0 tegra_fb_writel(tegra_fb, irq_mask, DC_CMD_INT_STATUS);
> +
> + =A0 =A0 =A0 tegra_fb_writel(tegra_fb, irq_mask, DC_CMD_INT_ENABLE);
> +
> + =A0 =A0 =A0 /* Wait for the irq to fire */
> + =A0 =A0 =A0 wait_event_interruptible_timeout(tegra_fb->event_wq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_fb->wait_condition, timeout);
> +
> + =A0 =A0 =A0 tegra_fb_writel(tegra_fb, 0, DC_CMD_INT_ENABLE);
> +
> + =A0 =A0 =A0 if (!tegra_fb->wait_condition) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: wait for vsync timed out\n"=
, __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +}

Apologies for the incremental review. The wait_condition code above
looks odd to me. Typically, we just test the return value of
wait_event_interruptible_timeout to see whether it timed out (returns
0 if so). But I guess the above approach works as well.

> +               if (tegra_fb_wait_for_event(tegra_fb, HZ/10, DC_INT_FRAME=
_END))

I still didn't follow how tegra_fb_activate is using the -ETIMEDOUT
return value from the wait, it seems like it is just ignored. You are
also doing stuff like HZ/10 and you might prefer to use
msecs_to_jiffies.

Thanks,
jaya
