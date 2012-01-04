From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 04 Jan 2012 22:34:22 +0000
Subject: Re: [PATCH 2/2] backlight: Convert pwm_bl to dev_pm_ops
Message-Id: <20120104143422.ca9896b0.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1325182838-25729-2-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <1325182838-25729-2-git-send-email-broonie@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, 29 Dec 2011 18:20:38 +0000
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> Should be no functional changes, mainly a reorganisation to support
> future work.
> 
> ...
>
> -#define pwm_backlight_suspend	NULL
> -#define pwm_backlight_resume	NULL
> +#define pwm_backlight_pm_ops	NULL
>  #endif
>  
>  static struct platform_driver pwm_backlight_driver = {
>  	.driver		= {
>  		.name	= "pwm-backlight",
>  		.owner	= THIS_MODULE,
> +		.pm	= &pwm_backlight_pm_ops,

This:

	.pm = &NULL,

will not compile.

Please review and test:

From: Andrew Morton <akpm@linux-foundation.org>
Subject: backlight-convert-pwm_bl-to-dev_pm_ops-fix

Fix CONFIG_PM=n build

Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Richard Purdie <rpurdie@rpsys.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/video/backlight/pwm_bl.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/video/backlight/pwm_bl.c~backlight-convert-pwm_bl-to-dev_pm_ops-fix drivers/video/backlight/pwm_bl.c
--- a/drivers/video/backlight/pwm_bl.c~backlight-convert-pwm_bl-to-dev_pm_ops-fix
+++ a/drivers/video/backlight/pwm_bl.c
@@ -194,15 +194,15 @@ static int pwm_backlight_resume(struct d
 static SIMPLE_DEV_PM_OPS(pwm_backlight_pm_ops, pwm_backlight_suspend,
 			 pwm_backlight_resume);
 
-#else
-#define pwm_backlight_pm_ops	NULL
 #endif
 
 static struct platform_driver pwm_backlight_driver = {
 	.driver		= {
 		.name	= "pwm-backlight",
 		.owner	= THIS_MODULE,
+#ifdef CONFIG_PM
 		.pm	= &pwm_backlight_pm_ops,
+#endif
 	},
 	.probe		= pwm_backlight_probe,
 	.remove		= pwm_backlight_remove,
_

