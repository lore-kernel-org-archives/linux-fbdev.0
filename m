From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 07 Jun 2013 10:22:19 +0000
Subject: Re: [PATCH] backlight: add CONFIG_PM_SLEEP to suspend/resume functions
Message-Id: <2386569.59VQ9D5dv5@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
References: <000201ce631f$d4ad0d50$7e0727f0$@samsung.com>
In-Reply-To: <000201ce631f$d4ad0d50$7e0727f0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>, 'Shuah Khan' <shuah.kh@samsung.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com, rpurdie@rpsys.net, FlorianSchandinat@gmx.de, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, rafael.j.wysocki@intel.com

On Friday 07 June 2013 10:39:20 Jingoo Han wrote:
> Add CONFIG_PM_SLEEP to suspend/resume functions to fix the following
> build warning when CONFIG_PM_SLEEP is not selected. This is because
> sleep PM callbacks defined by SIMPLE_DEV_PM_OPS are only used when
> the CONFIG_PM_SLEEP is enabled.
> 
> drivers/video/backlight/backlight.c:211:12: warning: 'backlight_suspend' defined but not used [-Wunused-function]
> drivers/video/backlight/backlight.c:225:12: warning: 'backlight_resume' defined but not used [-Wunused-function]
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

I forgot:

Acked-by: Arnd Bergmann <arnd@arndb.de>
