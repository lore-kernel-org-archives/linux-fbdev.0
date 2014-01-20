From: Shuah Khan <shuah.kh@samsung.com>
Date: Mon, 20 Jan 2014 15:27:01 +0000
Subject: Re: [PATCH v2] backlight: Convert from Legacy pm ops to dev_pm_ops
Message-Id: <52DD4045.4050902@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <2236505237-3336-1-git-send-email-shuah.kh@samsung.com>
 <15798389.lgk83XnI1i@vostro.rjw.lan>
 <001f01cf157f$ca2e8530$5e8b8f90$%han@samsung.com>
In-Reply-To: <001f01cf157f$ca2e8530$5e8b8f90$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jg1.han@samsung.com>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Richard Purdie' <rpurdie@rpsys.net>, 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>, 'Jean-Christophe PLAGNIOL-VILLARD' <plagnioj@jcrosoft.com>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 'Shuah Khan' <shuahkhan@gmail.com>, Shuah Khan <shuah.kh@samsung.com>

On 01/19/2014 06:34 PM, Jingoo Han wrote:
> On Monday, January 20, 2014 12:37 AM, Rafael J. Wysocki wrote:
>> On Wednesday, November 14, 2040 04:27:17 AM Shuah Khan wrote:
>>> Convert drivers/video/backlight/class to use dev_pm_ops for power
>>> management and remove Legacy PM ops hooks. With this change, rtc class
>>> registers suspend/resume callbacks via class->pm (dev_pm_ops) instead of
>>> Legacy class->suspend/resume. When __device_suspend() runs call-backs,
>>> it will find class->pm ops for the backlight class.
>>>
>>> Signed-off-by: Shuah Khan <shuah.kh@samsung.com>
>>> Cc: Shuah Khan <shuahkhan@gmail.com>
>>
>> Can you please resend the patches that nobody took with CCs to
>> linux-pm@vger.kernel.org?  If the original maintainers don't care, I'll be
>> able to pick those patches up then (if they look good).
>
> I already gave the comment, and am waiting v3 patch.
> However, Shuah Khan did not send the v3 patch yet.
>
> Currently, backlight subsystem patches go through mm-tree
> With my acked-by.
>
> Shuah Khan,
> Will you send the v3 patch? As I said, there is the typo in
> commit message. Please fix it.
>     s/rtc class/backlight class
>

Rafael/Jingoo Han,

I did send the v3 patch with the typo fixed. Here is the link:

http://lkml.indiana.edu/hypermail/linux/kernel/1306.0/00219.html

This is a while back. I will rebase and res-test and send it.

thanks,
-- Shuah

-- 
Shuah Khan
Senior Linux Kernel Developer - Open Source Group
Samsung Research America(Silicon Valley)
shuah.kh@samsung.com | (970) 672-0658
