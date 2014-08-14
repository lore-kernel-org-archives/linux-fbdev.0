From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 14 Aug 2014 11:18:29 +0000
Subject: Re: [linux-sunxi] [PATCH 4/4] simplefb: add clock handling code
Message-Id: <53EC9B05.3010702@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <1407914239-12054-5-git-send-email-libv@skynet.be>
 <53EB9471.3090204@wwwdotorg.org> <20140813170106.GT15297@lukather>
 <53EC834F.6020307@redhat.com>
 <9B9D62CA-8037-4653-BCF0-C79BFFEB4279@dominion.thruhere.net>
 <20140814105711.GC1000@skynet.be>
In-Reply-To: <20140814105711.GC1000@skynet.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 08/14/2014 12:57 PM, Luc Verhaegen wrote:
> On Thu, Aug 14, 2014 at 12:31:50PM +0200, Koen Kooi wrote:
>>
>> How many DRM drivers are there on ARM and what's the size impact of building them all into the kernel? I know from experience that it's not possible on x86 especially with efifb in the mix, but I wonder what the situation on ARM is. I only have TI, sunxi and exynos boards to test on and building in both TI drm drivers and the exynos one seems to work. 
>> Note that I'm not talking about the non-DRM abortions that maskerade as graphics drivers for ARM SoCs, only proper DRM ones.
>>
>> regards,
>>
>> Koen
> 
> A quick check tells me that my current sunxi-3.4 sunxi_drm.ko measures 
> 1.7MB

That likely is with debug-info, try running "strip --strip-debug" on the .ko
file. Note don't use plain "strip" that ruins kernel modules.

Regards,

Hans

p.s.

I'm leaving home (and the internet) for vacation tomorrow. I'll be back
on Mon Aug 25.
