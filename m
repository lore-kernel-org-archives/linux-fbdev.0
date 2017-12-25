From: Yisheng Xie <xieyisheng1@huawei.com>
Date: Mon, 25 Dec 2017 01:09:10 +0000
Subject: Re: [PATCH v3 00/27] kill devm_ioremap_nocache
Message-Id: <6c0ade63-f4d3-d44d-c622-b091eb2ba902@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1514026525-32538-1-git-send-email-xieyisheng1@huawei.com>
 <20171223134831.GB10103@kroah.com>
 <f7632cf5-2bcc-4d74-b912-3999937a1269@roeck-us.net>
 <c28ac0bc-8bd2-3dce-3167-8c0f80ec601e@c-s.fr>
In-Reply-To: <c28ac0bc-8bd2-3dce-3167-8c0f80ec601e@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: christophe leroy <christophe.leroy@c-s.fr>, Guenter Roeck <linux@roeck-us.net>, Greg KH <gregkh@linuxfoundation.org>
Cc: linux-mips@linux-mips.org, ulf.hansson@linaro.org, jakub.kicinski@netronome.com, platform-driver-x86@vger.kernel.org, airlied@linux.ie, linux-wireless@vger.kernel.org, linus.walleij@linaro.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-mtd@lists.infradead.org, daniel.vetter@intel.com, dan.j.williams@intel.com, jason@lakedaemon.net, linux-rtc@vger.kernel.org, boris.brezillon@free-electrons.com, mchehab@kernel.org, dmaengine@vger.kernel.org, vinod.koul@intel.com, richard@nod.at, marek.vasut@gmail.com, industrypack-devel@lists.sourceforge.net, linux-pci@vger.kernel.org, dvhart@infradead.org, wg@grandegger.com, linux-media@vger.kernel.org, seanpaul@chromium.org, devel@driverdev.osuosl.org, linux-watchdog@vger.kernel.org, arnd@arndb.de, b.zolnierkie@samsung.com, marc.zyngier@arm.com, jslaby@sus

hi Christophe and Greg,

On 2017/12/24 16:55, christophe leroy wrote:
> 
> 
> Le 23/12/2017 à 16:57, Guenter Roeck a écrit :
>> On 12/23/2017 05:48 AM, Greg KH wrote:
>>> On Sat, Dec 23, 2017 at 06:55:25PM +0800, Yisheng Xie wrote:
>>>> Hi all,
>>>>
>>>> When I tried to use devm_ioremap function and review related code, I found
>>>> devm_ioremap and devm_ioremap_nocache is almost the same with each other,
>>>> except one use ioremap while the other use ioremap_nocache.
>>>
>>> For all arches?  Really?  Look at MIPS, and x86, they have different
>>> functions.
>>>
>>
>> Both mips and x86 end up mapping the same function, but other arches don't.
>> mn10300 is one where ioremap and ioremap_nocache are definitely different.
> 
> alpha: identical
> arc: identical
> arm: identical
> arm64: identical
> cris: different        <=
> frv: identical
> hexagone: identical
> ia64: different        <=
> m32r: identical
> m68k: identical
> metag: identical
> microblaze: identical
> mips: identical
> mn10300: different     <=
> nios: identical
> openrisc: different    <=
> parisc: identical
> riscv: identical
> s390: identical
> sh: identical
> sparc: identical
> tile: identical
> um: rely on asm/generic
> unicore32: identical
> x86: identical
> asm/generic (no mmu): identical

Wow, that's correct, sorry for I have just checked the main archs, I means
x86,arm, arm64, mips.

However, I stall have no idea about why these 4 archs want different ioremap
function with others. Drivers seems cannot aware this? If driver call ioremap
want he really want for there 4 archs, cache or nocache?

> 
> So 4 among all arches seems to have ioremap() and ioremap_nocache() being different.
> 
> Could we have a define set by the 4 arches on which ioremap() and ioremap_nocache() are different, something like HAVE_DIFFERENT_IOREMAP_NOCACHE ?

Then, what the HAVE_DIFFERENT_IOREMAP_NOCACHE is uesed for ?

Thanks
Yisheng
> 
> Christophe
> 
>>
>> Guenter
>>
>>>> While ioremap's
>>>> default function is ioremap_nocache, so devm_ioremap_nocache also have the
>>>> same function with devm_ioremap, which can just be killed to reduce the size
>>>> of devres.o(from 20304 bytes to 18992 bytes in my compile environment).
>>>>
>>>> I have posted two versions, which use macro instead of function for
>>>> devm_ioremap_nocache[1] or devm_ioremap[2]. And Greg suggest me to kill
>>>> devm_ioremap_nocache for no need to keep a macro around for the duplicate
>>>> thing. So here comes v3 and please help to review.
>>>
>>> I don't think this can be done, what am I missing?  These functions are
>>> not identical, sorry for missing that before.

Never mind, I should checked all the arches, sorry about that.

>>>
>>> thanks,
>>>
>>> greg k-h
>>>
>>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> ---
> L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
> https://www.avast.com/antivirus
> 
> 
> .
> 

