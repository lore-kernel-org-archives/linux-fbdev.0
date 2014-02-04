From: Shuah Khan <shuah.kh@samsung.com>
Date: Tue, 04 Feb 2014 17:55:27 +0000
Subject: Re: [PATCH v2] backlight: Convert from Legacy pm ops to dev_pm_ops
Message-Id: <52F1298F.1040903@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <2236505237-3336-1-git-send-email-shuah.kh@samsung.com>
 <15798389.lgk83XnI1i@vostro.rjw.lan>
 <001f01cf157f$ca2e8530$5e8b8f90$%han@samsung.com>
 <52DD4045.4050902@samsung.com>
In-Reply-To: <52DD4045.4050902@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jg1.han@samsung.com>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Richard Purdie' <rpurdie@rpsys.net>, 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>, 'Jean-Christophe PLAGNIOL-VILLARD' <plagnioj@jcrosoft.com>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 'Shuah Khan' <shuahkhan@gmail.com>, Shuah Khan <shuah.kh@samsung.com>

On 01/20/2014 08:27 AM, Shuah Khan wrote:
> On 01/19/2014 06:34 PM, Jingoo Han wrote:
>> On Monday, January 20, 2014 12:37 AM, Rafael J. Wysocki wrote:

> Rafael/Jingoo Han,
>
> I did send the v3 patch with the typo fixed. Here is the link:
>
> http://lkml.indiana.edu/hypermail/linux/kernel/1306.0/00219.html
>
> This is a while back. I will rebase and res-test and send it.
>

Checked 3.14-rc1 and patch v3 is in there.

commit 3601792e7b68150420ea8dc129e26e167c0484d8

-- Shuah

-- 
Shuah Khan
Senior Linux Kernel Developer - Open Source Group
Samsung Research America(Silicon Valley)
shuah.kh@samsung.com | (970) 672-0658
