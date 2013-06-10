From: Shuah Khan <shuah.kh@samsung.com>
Date: Mon, 10 Jun 2013 15:34:25 +0000
Subject: Re: [PATCH] backlight: add CONFIG_PM_SLEEP to suspend/resume functions
Message-Id: <B8EFE96D1287C24090BAD9D858E15E61566A61@sisaex02sj>
List-Id: <linux-fbdev.vger.kernel.org>
References: <000201ce631f$d4ad0d50$7e0727f0$@samsung.com>
 <2386569.59VQ9D5dv5@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jingoo Han <jg1.han@samsung.com>, 'Andrew Morton' <akpm@linux-foundation.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "shuahkhan@gmail.com" <shuahkhan@gmail.com>, "rpurdie@rpsys.net" <rpurdie@rpsys.net>, "FlorianSchandinat@gmx.de" <FlorianSchandinat@gmx.de>, "plagnioj@jcrosoft.com" <plagnioj@jcrosoft.com>, "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>

On 06/07/2013 04:25 AM, Arnd Bergmann wrote:
> On Friday 07 June 2013 10:39:20 Jingoo Han wrote:
>> Add CONFIG_PM_SLEEP to suspend/resume functions to fix the following
>> build warning when CONFIG_PM_SLEEP is not selected. This is because
>> sleep PM callbacks defined by SIMPLE_DEV_PM_OPS are only used when
>> the CONFIG_PM_SLEEP is enabled.
>>
>> drivers/video/backlight/backlight.c:211:12: warning: 'backlight_suspend' defined but not used [-Wunused-function]
>> drivers/video/backlight/backlight.c:225:12: warning: 'backlight_resume' defined but not used [-Wunused-function]
>>
>> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
>
> I forgot:
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>

Jingoo Han, and Arnd,

Sorry I was on vacation all of last week. Thanks for fixing the problem. 
My apologies for introducing the warnings. I had CONFIG_PM and 
CONFIG_PM_SLEEP both enabled and didn't see this warning. I will be 
careful with subsequent patches in this area.

-- Shuah

Shuah Khan, Linux Kernel Developer - Open Source Group Samsung Research 
America (Silicon Valley) shuah.kh@samsung.com | (970) 672-0658
