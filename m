From: Shuah Khan <shuah.kh@samsung.com>
Date: Fri, 09 Aug 2013 21:33:32 +0000
Subject: Re: [PATCH v2] backlight: Convert from Legacy pm ops to dev_pm_ops
Message-Id: <B8EFE96D1287C24090BAD9D858E15E617624BE@sisaex02sj>
List-Id: <linux-fbdev.vger.kernel.org>
References: <2236505237-3336-1-git-send-email-shuah.kh@samsung.com>
 <20130809212805.GA4987@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Brown <davidb@codeaurora.org>
Cc: "rpurdie@rpsys.net" <rpurdie@rpsys.net>, "FlorianSchandinat@gmx.de" <FlorianSchandinat@gmx.de>, "plagnioj@jcrosoft.com" <plagnioj@jcrosoft.com>, "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "shuahkhan@gmail.com" <shuahkhan@gmail.com>, Shuah Khan <shuah.kh@samsung.com>

On 08/09/2013 03:28 PM, David Brown wrote:
> On Wed, Nov 14, 2040 at 04:27:17AM -0700, Shuah Khan wrote:
>> ...
>
> The clock on your computer might be running just a wee bit ahead.
>
> Either that, or we're getting patches from the future.
>
> David
>

David,

I know what happened. I was testing suspend to disk with pm_trace 
enabled and forgot to set the correct time after the running the test. 
Generated the patch without realizing the time is incorrect. Would like 
me to re-generate it.

-- Shuah

Shuah Khan, Linux Kernel Developer - Open Source Group Samsung Research 
America (Silicon Valley) shuah.kh@samsung.com | (970) 672-0658
