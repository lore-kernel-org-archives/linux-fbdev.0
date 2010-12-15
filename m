From: Jan Engelhardt <jengelh@medozas.de>
Date: Wed, 15 Dec 2010 13:39:14 +0000
Subject: Re: Force FB off
Message-Id: <alpine.LNX.2.01.1012151430220.2052@obet.zrqbmnf.qr>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LNX.2.01.1012141840130.18577@obet.zrqbmnf.qr>
	<AANLkTimEh+2rEFuq7q+wLcfHw_UKKHVipC0t7mFwSzx8@mail.gmail.com>
In-Reply-To: <AANLkTimEh+2rEFuq7q+wLcfHw_UKKHVipC0t7mFwSzx8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On Tuesday 2010-12-14 21:18, Dave Airlie wrote:
>On Wed, Dec 15, 2010 at 3:41 AM, Jan Engelhardt <jengelh@medozas.de> wrote:
>
>>
>>booting with video=off nor video=i915:off has any effect on skipping 
>>FB. What is the correct option to stop FB from taking over my boot 
>>consoles?
>
>For KMS its not fb taking over its the drm i915 driver, nomodeset will 
>stop it however X will no longer work since it relies on the kernel 
>driver.

That would make sense. Furthermore I discovered that video=vesafb:off 
also has no effect, but here it is clear because the source code ignores 
the return value of fb_get_options, and so ignores any off command.

The real strange thing is that video=offb:off on an Apple Xserve G5 
PPC64, while probably skipping OFFB initialization, still ends up in a 
640x480 mode with a 8x16 font instead of retaining the PROM 
console/font.
