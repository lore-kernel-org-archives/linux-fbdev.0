From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 01 Apr 2014 00:08:33 +0000
Subject: Re: [PATCH] backlight: pwm_bl: Use SIMPLE_DEV_PM_OPS()
Message-Id: <000701cf4d3e$856f2ac0$904d8040$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1396087871-9091-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1396087871-9091-1-git-send-email-shc_work@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On Monday, March 31, 2014 7:37 PM, Lee Jones wrote:
> Mon, 31 Mar 2014 09:50:47 +0100 от Lee Jones <lee.jones@linaro.org>:
> > > > > > > Use the SIMPLE_DEV_PM_OPS() macro to declare the driver's pm_ops.
> > > > > > >
> > > > > > > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > > > > > > ---
> > > > > > >  drivers/video/backlight/pwm_bl.c | 17 ++++-------------
> > > > > > >  1 file changed, 4 insertions(+), 13 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> > > > > > > index b75201f..d5e1f5b 100644
> > > > > > > --- a/drivers/video/backlight/pwm_bl.c
> > > > > > > +++ b/drivers/video/backlight/pwm_bl.c
> > > > > >
> > > > > > [...]
> > > > > >
> > > > > > > -static int pwm_backlight_resume(struct device *dev)
> > > > > > > +static int __maybe_unused pwm_bl_resume(struct device *dev)
> > > > > >
> > > > > > What's the __maybe_unused attribute for?
> > > > > >
> > > > > > In include/linux/compiler-gcc.h it redefines the attribute as 'unused':
> > > > > >
> > > > > >   #define __maybe_unused                  __attribute__((unused))
> > > > > >
> > > > > > ... are you sure this is what you want?
> > > > >
> > > > > Yes. This avoids compiler warnings if CONFIG_PM is unset.
> > > >
> > > > What are the advantages of this over the config option? Besides 2
> > > > lines of code?
> > >
> > > Just an increase compile coverage.
> >
> > What does this mean? I replied to another one of your patches with the
> > same question.
> 
> Code parts for suspend() and resume() will be compiled regardless of
> CONFIG_PM option and will be discarded by linker if CONFIG_PM is not set.

(+cc Joe Perches, Dan Carpenter)

Original patch is 
http://www.spinics.net/lists/linux-fbdev/msg14177.html

I don't think that __maybe_unused is good.
Currently, SIMPLE_DEV_PM_OPS is using "#ifdef CONFIG_PM_SLEEP" as below.
So, suspend_fn, resume_fn should be protected by "#ifdef CONFIG_PM_SLEEP".
Maybe, it is necessary to fix SET_SYSTEM_SLEEP_PM_OPS define,
in order to increase compile coverage.

./include/linux/pm.h
#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
const struct dev_pm_ops name = { \
        SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
}

#ifdef CONFIG_PM_SLEEP
#define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
        .suspend = suspend_fn, \
        .resume = resume_fn, \
        .freeze = suspend_fn, \
        .thaw = resume_fn, \
        .poweroff = suspend_fn, \
        .restore = resume_fn,
#else
#define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
#endif


Please, don’t remove "#ifdef CONFIG_PM_SLEEP".
Your patch can be modified as below:

--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -386,14 +386,7 @@ static int pwm_backlight_resume(struct device *dev)
 }
 #endif

-static const struct dev_pm_ops pwm_backlight_pm_ops = {
-#ifdef CONFIG_PM_SLEEP
-       .suspend = pwm_backlight_suspend,
-       .resume = pwm_backlight_resume,
-       .poweroff = pwm_backlight_suspend,
-       .restore = pwm_backlight_resume,
-#endif
-};
+static SIMPLE_DEV_PM_OPS(pwm_bl_pm_ops, pwm_bl_suspend, pwm_bl_resume);

Best regards,
Jingoo Han

