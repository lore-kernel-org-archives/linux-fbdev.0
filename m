From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Fri, 15 Mar 2013 10:16:17 +0000
Subject: Re: [PATCH 0/5] at91: atmel_lcdfb: regression fixes and cpu_is removal
Message-Id: <5142F4F1.60006@atmel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1360340791.git.nicolas.ferre@atmel.com>
 <5139B169.7050807@atmel.com> <51405126.3090009@atmel.com>
 <201303142303.42283.arnd@arndb.de>
In-Reply-To: <201303142303.42283.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 03/15/2013 12:03 AM, Arnd Bergmann :
> On Wednesday 13 March 2013, Nicolas Ferre wrote:
>> In case we end-up with an agreement on the path those fixes should
>> follow, here is the location of my updated material rebased on top of 3.9-rc2:
>>
>> The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:
>>
>>   Linux 3.9-rc2 (2013-03-10 16:54:19 -0700)
>>
>> are available in the git repository at:
>>
>>   git://github.com/at91linux/linux-at91.git at91-3.9-fixesLCD
>>
>> for you to fetch changes up to bbd44f6bd9d1aa735b180b29b5719d63a8e87b55:
>>
>>   ARM: at91/avr32/atmel_lcdfb: add platform device-id table (2013-03-13 11:05:12 +0100)
>>
>> ----------------------------------------------------------------
>> Johan Hovold (5):
>>       atmel_lcdfb: fix 16-bpp modes on older SOCs
>>       ARM: at91: fix LCD-wiring mode
>>       ARM: at91/avr32/atmel_lcdfb: add bus-clock entry
>>       atmel_lcdfb: move lcdcon2 register access to compute_hozval
>>       ARM: at91/avr32/atmel_lcdfb: add platform device-id table
>>
> 
> I have merged the first two patches into the fixes branch now, from up to commit
> 67cf9c0a. Please resubmit the remaining ones on top of this commit for 3.10, either
> through arm-soc or through the framebuffer tree.

Thanks a lot.
I have just sent the pull-request for remaining material. Tell me if it
is what you've expected.

Best regards,
-- 
Nicolas Ferre
