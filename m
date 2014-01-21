From: Shuah Khan <shuah.kh@samsung.com>
Date: Tue, 21 Jan 2014 15:29:56 +0000
Subject: Re: [PATCH v2] backlight: Convert from Legacy pm ops to dev_pm_ops
Message-Id: <52DE9274.1080806@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <2236505237-3336-1-git-send-email-shuah.kh@samsung.com>
 <15798389.lgk83XnI1i@vostro.rjw.lan>
In-Reply-To: <15798389.lgk83XnI1i@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: rpurdie@rpsys.net, FlorianSchandinat@gmx.de, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, rafael.j.wysocki@intel.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com, Shuah Khan <shuah.kh@samsung.com>

On 01/19/2014 08:37 AM, Rafael J. Wysocki wrote:
> On Wednesday, November 14, 2040 04:27:17 AM Shuah Khan wrote:
>> Convert drivers/video/backlight/class to use dev_pm_ops for power
>> management and remove Legacy PM ops hooks. With this change, rtc class
>> registers suspend/resume callbacks via class->pm (dev_pm_ops) instead of
>> Legacy class->suspend/resume. When __device_suspend() runs call-backs,
>> it will find class->pm ops for the backlight class.
>>
>> Signed-off-by: Shuah Khan <shuah.kh@samsung.com>
>> Cc: Shuah Khan <shuahkhan@gmail.com>
>
> Can you please resend the patches that nobody took with CCs to
> linux-pm@vger.kernel.org?  If the original maintainers don't care, I'll be
> able to pick those patches up then (if they look good).
>

Rafael,

Thanks. I have a few legacy pm patches that didn't get pulled into 
trees. I will rebase to the latest and resend.

-- Shuah


-- 
Shuah Khan
Senior Linux Kernel Developer - Open Source Group
Samsung Research America(Silicon Valley)
shuah.kh@samsung.com | (970) 672-0658
