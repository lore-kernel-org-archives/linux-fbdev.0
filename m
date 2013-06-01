From: Jingoo Han <jg1.han@samsung.com>
Date: Sat, 01 Jun 2013 04:13:31 +0000
Subject: Re: [PATCH v2] backlight: Convert from Legacy pm ops to dev_pm_ops
Message-Id: <005901ce5e7e$60212c00$20638400$@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <2236505237-3336-1-git-send-email-shuah.kh@samsung.com>
In-Reply-To: <2236505237-3336-1-git-send-email-shuah.kh@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Shuah Khan' <shuah.kh@samsung.com>, rpurdie@rpsys.net, FlorianSchandinat@gmx.de, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, rafael.j.wysocki@intel.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com, Jingoo Han <jg1.han@samsung.com>

On Wednesday, November 14, 2040 8:27 PM, Shuah Khan wrote:
> 
> Convert drivers/video/backlight/class to use dev_pm_ops for power
> management and remove Legacy PM ops hooks. With this change, rtc class

There is still the typo.

Please fix it. 
 rtc class -> backlight class


> registers suspend/resume callbacks via class->pm (dev_pm_ops) instead of
> Legacy class->suspend/resume. When __device_suspend() runs call-backs,
> it will find class->pm ops for the backlight class.
> 
> Signed-off-by: Shuah Khan <shuah.kh@samsung.com>
> Cc: Shuah Khan <shuahkhan@gmail.com>


