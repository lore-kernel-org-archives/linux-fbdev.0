From: christophe leroy <christophe.leroy@c-s.fr>
Date: Sun, 24 Dec 2017 09:05:08 +0000
Subject: Re: [PATCH v3 00/27] kill devm_ioremap_nocache
Message-Id: <b8ff7f17-7f2c-f220-9833-7ae5bd7343d5@c-s.fr>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1514026525-32538-1-git-send-email-xieyisheng1@huawei.com>
 <20171223134831.GB10103@kroah.com>
In-Reply-To: <20171223134831.GB10103@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Greg KH <gregkh@linuxfoundation.org>, Yisheng Xie <xieyisheng1@huawei.com>
Cc: linux-mips@linux-mips.org, ulf.hansson@linaro.org, jakub.kicinski@netronome.com, platform-driver-x86@vger.kernel.org, airlied@linux.ie, linux-wireless@vger.kernel.org, linus.walleij@linaro.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-mtd@lists.infradead.org, daniel.vetter@intel.com, dan.j.williams@intel.com, jason@lakedaemon.net, linux-rtc@vger.kernel.org, boris.brezillon@free-electrons.com, mchehab@kernel.org, dmaengine@vger.kernel.org, vinod.koul@intel.com, richard@nod.at, marek.vasut@gmail.com, industrypack-devel@lists.sourceforge.net, linux-pci@vger.kernel.org, dvhart@infradead.org, linux@roeck-us.net, linux-media@vger.kernel.org, seanpaul@chromium.org, devel@driverdev.osuosl.org, linux-watchdog@vger.kernel.org, arnd@arndb.de, b.zolnierkie@samsung.com, marc.zyngier@arm.com, jslaby@su



Le 23/12/2017 à 14:48, Greg KH a écrit :
> On Sat, Dec 23, 2017 at 06:55:25PM +0800, Yisheng Xie wrote:
>> Hi all,
>>
>> When I tried to use devm_ioremap function and review related code, I found
>> devm_ioremap and devm_ioremap_nocache is almost the same with each other,
>> except one use ioremap while the other use ioremap_nocache.
> 
> For all arches?  Really?  Look at MIPS, and x86, they have different
> functions.
> 
>> While ioremap's
>> default function is ioremap_nocache, so devm_ioremap_nocache also have the
>> same function with devm_ioremap, which can just be killed to reduce the size
>> of devres.o(from 20304 bytes to 18992 bytes in my compile environment).
>>
>> I have posted two versions, which use macro instead of function for
>> devm_ioremap_nocache[1] or devm_ioremap[2]. And Greg suggest me to kill
>> devm_ioremap_nocache for no need to keep a macro around for the duplicate
>> thing. So here comes v3 and please help to review.
> 
> I don't think this can be done, what am I missing?  These functions are
> not identical, sorry for missing that before.

devm_ioremap() and devm_ioremap_nocache() are quite similar, both use 
devm_ioremap_release() for the release, why not just defining:

static void __iomem *__devm_ioremap(struct device *dev, resource_size_t 
offset,
			   resource_size_t size, bool nocache)
{
[...]
	if (nocache)
		addr = ioremap_nocache(offset, size);
	else
		addr = ioremap(offset, size);
[...]
}

then in include/linux/io.h

static inline void __iomem *devm_ioremap(struct device *dev, 
resource_size_t offset,
			   resource_size_t size)
{return __devm_ioremap(dev, offset, size, false);}

static inline void __iomem *devm_ioremap_nocache(struct device *dev, 
resource_size_t offset,
				   resource_size_t size);
{return __devm_ioremap(dev, offset, size, true);}

Christophe

> 
> thanks,
> 
> greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus

