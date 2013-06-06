From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 06 Jun 2013 21:27:47 +0000
Subject: Re: [PATCH v3] backlight: Convert from Legacy pm ops to dev_pm_ops
Message-Id: <5441622.ypFXsKluBt@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1370128047-2444-1-git-send-email-shuah.kh@samsung.com> <001a01ce6010$3daaf3c0$b900db40$@samsung.com>
In-Reply-To: <001a01ce6010$3daaf3c0$b900db40$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jg1.han@samsung.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 'Shuah Khan' <shuah.kh@samsung.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com, rpurdie@rpsys.net, FlorianSchandinat@gmx.de, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, rafael.j.wysocki@intel.com

On Monday 03 June 2013 13:10:10 Jingoo Han wrote:
> On Sunday, June 02, 2013 8:07 AM, Shuah Khan wrote:
> > 
> > Convert drivers/video/backlight/class to use dev_pm_ops for power
> > management and remove Legacy PM ops hooks. With this change, backlight
> > class registers suspend/resume callbacks via class->pm (dev_pm_ops)
> > instead of Legacy class->suspend/resume. When __device_suspend() runs
> > call-backs, it will find class->pm ops for the backlight class.
> > 
> > Signed-off-by: Shuah Khan <shuah.kh@samsung.com>
> > Cc: Shuah Khan <shuahkhan@gmail.com>
> 
> CC'ed Andrew Morton,
> 
> It looks good.
> 
> Acked-by: Jingoo Han <jg1.han@samsung.com>
> 

I'm getting this build warning now:

arnd@wuerfel:/git/arm-soc$ cat build/omap1_defconfig/faillog 
/git/arm-soc/drivers/video/backlight/backlight.c:212:12: warning: 'backlight_suspend' defined but not used [-Wunused-function]
 static int backlight_suspend(struct device *dev)
            ^
/git/arm-soc/drivers/video/backlight/backlight.c:226:12: warning: 'backlight_resume' defined but not used [-Wunused-function]
 static int backlight_resume(struct device *dev)

	Arnd
