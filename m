From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 31 Oct 2013 19:42:52 +0000
Subject: Re: [PATCH v2 19/19] fbdev: sh-mobile-lcdcfb: Enable the driver on all ARM platforms
Message-Id: <alpine.DEB.2.02.1310312039330.13521@ayla.of.borg>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1383086274-11049-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383086274-11049-20-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383086274-11049-20-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

	Hi Laurent,

On Tue, 29 Oct 2013, Laurent Pinchart wrote:
> Renesas ARM platforms are transitioning from single-platform to
> multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
> driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
> and ARCH_SHMOBILE_MULTI, and increase build testing coverage with
> COMPILE_TEST.

> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 84b685f..32b5c86 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -2482,7 +2482,7 @@ endif
> =20
>  config FB_SH_MOBILE_MERAM
>  	tristate "SuperH Mobile MERAM read ahead support"
> -	depends on (SUPERH || ARCH_SHMOBILE)
> +	depends on (SUPERH || ARM || COMPILE_TEST)
>  	select GENERIC_ALLOCATOR
>  	---help---
>  	  Enable MERAM support for the SuperH controller.

While the below compiler warnings have been seen with sh-randconfig
before, they're more likely to happen with COMPILE_TEST=3Dy.
I now see them with e.g. m68k-allmodconfig, so I created a patch.

From 15eb69172457c675cde177a6f742b6f1dabdeb18 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 31 Oct 2013 20:35:14 +0100
Subject: [PATCH] fbdev: sh_mobile_meram: Fix defined but not used compiler
 warnings
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

If CONFIG_PM_SLEEP resp. CONFIG_PM_RUNTIME are not set:

drivers/video/sh_mobile_meram.c:573: warning: =A1sh_mobile_meram_suspend=A2=
 defined but not used
drivers/video/sh_mobile_meram.c:597: warning: =A1sh_mobile_meram_resume=A2 =
defined but not used

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/sh_mobile_meram.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/sh_mobile_meram.c b/drivers/video/sh_mobile_mera=
m.c
index e0f098562a74..56a8e47ffceb 100644
--- a/drivers/video/sh_mobile_meram.c
+++ b/drivers/video/sh_mobile_meram.c
@@ -569,6 +569,7 @@ EXPORT_SYMBOL_GPL(sh_mobile_meram_cache_update);
  * Power management
  */
=20
+#ifdef CONFIG_PM_SLEEP
 static int sh_mobile_meram_suspend(struct device *dev)
 {
 	struct platform_device *pdev =3D to_platform_device(dev);
@@ -592,7 +593,9 @@ static int sh_mobile_meram_suspend(struct device *dev)
 	}
 	return 0;
 }
+#endif
=20
+#ifdef CONFIG_PM_RUNTIME
 static int sh_mobile_meram_resume(struct device *dev)
 {
 	struct platform_device *pdev =3D to_platform_device(dev);
@@ -611,6 +614,7 @@ static int sh_mobile_meram_resume(struct device *dev)
 		meram_write_reg(priv->base, common_regs[i], priv->regs[i]);
 	return 0;
 }
+#endif
=20
 static UNIVERSAL_DEV_PM_OPS(sh_mobile_meram_dev_pm_ops,
 			    sh_mobile_meram_suspend,
--=20
1.7.9.5

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
							    -- Linus Torvalds
