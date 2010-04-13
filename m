From: Jaya Kumar <jayakumar.lkml@gmail.com>
Date: Tue, 13 Apr 2010 23:26:00 +0000
Subject: Re: [PATCH v2 08/10] [ARM] tegra: Add framebuffer driver
Message-Id: <q2l45a44e481004131626j7f5afbfcsfcf861aa70dab651@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1268721431-24434-1-git-send-email-konkers@google.com>
	<1271198563-10424-1-git-send-email-konkers@android.com>
	<1271198563-10424-2-git-send-email-konkers@android.com>
	<1271198563-10424-3-git-send-email-konkers@android.com>
	<1271198563-10424-4-git-send-email-konkers@android.com>
	<1271198563-10424-5-git-send-email-konkers@android.com>
	<1271198563-10424-6-git-send-email-konkers@android.com>
	<1271198563-10424-7-git-send-email-konkers@android.com>
	<1271198563-10424-8-git-send-email-konkers@android.com>
	<1271198563-10424-9-git-send-email-konkers@android.com>
In-Reply-To: <1271198563-10424-9-git-send-email-konkers@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Please CC fbdev as well. Thanks.

On Wed, Apr 14, 2010 at 6:42 AM,  <konkers@android.com> wrote:
> +/* palette attary used by the fbcon */
> +u32 pseudo_palette[16];

attary?

> +static int tegra_plat_probe(struct platform_device *pdev)
> +{

> + =A0 =A0 =A0 info =3D framebuffer_alloc(sizeof(struct tegra_fb_info), &p=
dev->dev);
> + =A0 =A0 =A0 if (!info) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 irq =3D platform_get_irq(pdev, 0);
> + =A0 =A0 =A0 if (irq <=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: no irq\n", pdev->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOENT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free;
> + =A0 =A0 =A0 }

I see the irq get and the request_irq.

> +
> + =A0 =A0 =A0 if (request_irq(irq, tegra_fb_irq, IRQF_DISABLED,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_name(&pdev->dev), info)=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: request_irq %d failed\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev->name, irq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_clk_disable;
> + =A0 =A0 =A0 }
> +

but when I look at the failout cleanup, I didn't see the irq being
cleaned up. Maybe I missed something, just wanted to check that.

> +err_clk_disable:
> + =A0 =A0 =A0 clk_disable(clk);
> +err_iounmap_fb:
> + =A0 =A0 =A0 iounmap(fb_base);
> +err_release_resource_fb:
> + =A0 =A0 =A0 release_resource(fb_mem);
> +err_iounmap_reg:
> + =A0 =A0 =A0 iounmap(reg_base);
> +err_release_resource_reg:
> + =A0 =A0 =A0 release_resource(reg_mem);
> +err_free:
> + =A0 =A0 =A0 framebuffer_release(info);
> +err:
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int tegra_plat_remove(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct fb_info *info =3D platform_get_drvdata(pdev);
> + =A0 =A0 =A0 struct tegra_fb_info *tegra_fb =3D info->par;
> + =A0 =A0 =A0 unregister_framebuffer(info);
> + =A0 =A0 =A0 clk_disable(tegra_fb->clk);
> + =A0 =A0 =A0 iounmap(info->screen_base);
> + =A0 =A0 =A0 release_resource(tegra_fb->fb_mem);
> + =A0 =A0 =A0 iounmap(tegra_fb->reg_base);
> + =A0 =A0 =A0 release_resource(tegra_fb->reg_mem);
> + =A0 =A0 =A0 framebuffer_release(info);
> + =A0 =A0 =A0 return 0;
> +}
> +

Thanks,
jaya
