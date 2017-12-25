From: Yisheng Xie <xieyisheng1@huawei.com>
Date: Mon, 25 Dec 2017 01:43:40 +0000
Subject: Re: [PATCH v3 27/27] devres: kill devm_ioremap_nocache
Message-Id: <4d0991ec-9cd4-0c33-5560-ae9c2c762765@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1514026979-33838-1-git-send-email-xieyisheng1@huawei.com>
 <20171223134532.GA10103@kroah.com>
In-Reply-To: <20171223134532.GA10103@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-mips@linux-mips.org, ulf.hansson@linaro.org, jakub.kicinski@netronome.com, lgirdwood@gmail.com, airlied@linux.ie, linux-pci@vger.kernel.org, linus.walleij@linaro.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, linux-ide@vger.kernel.org, linux-mtd@lists.infradead.org, daniel.vetter@intel.com, tglx@linutronix.de, linux-watchdog@vger.kernel.org, linux-rtc@vger.kernel.org, boris.brezillon@free-electrons.com, andriy.shevchenko@linux.intel.com, vinod.koul@intel.com, richard@nod.at, alexandre.belloni@free-electrons.com, marek.vasut@gmail.com, industrypack-devel@lists.sourceforge.net, jslaby@suse.com, dvhart@infradead.org, linux@roeck-us.net, linux-media@vger.kernel.org, devel@driverdev.osuosl.org, jason@lakedaemon.net, arnd@arndb.de, b.zolnierkie@samsung.com, marc.zyngier@arm.com, linux-mmc@vger.kernel.org, jani.niku



On 2017/12/23 21:45, Greg KH wrote:
> On Sat, Dec 23, 2017 at 07:02:59PM +0800, Yisheng Xie wrote:
>> --- a/lib/devres.c
>> +++ b/lib/devres.c
>> @@ -44,35 +44,6 @@ void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
>>  EXPORT_SYMBOL(devm_ioremap);
>>  
>>  /**
>> - * devm_ioremap_nocache - Managed ioremap_nocache()
>> - * @dev: Generic device to remap IO address for
>> - * @offset: Resource address to map
>> - * @size: Size of map
>> - *
>> - * Managed ioremap_nocache().  Map is automatically unmapped on driver
>> - * detach.
>> - */
>> -void __iomem *devm_ioremap_nocache(struct device *dev, resource_size_t offset,
>> -				   resource_size_t size)
>> -{
>> -	void __iomem **ptr, *addr;
>> -
>> -	ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
>> -	if (!ptr)
>> -		return NULL;
>> -
>> -	addr = ioremap_nocache(offset, size);
> 
> Wait, devm_ioremap() calls ioremap(), not ioremap_nocache(), are you
> _SURE_ that these are all identical?  For all arches?  If so, then
> ioremap_nocache() can also be removed, right?

Yeah, As Christophe pointed out, that 4 archs do not have the same function.
But I do not why they do not want do the same thing. Driver may no know about
this? right?

> 
> In my quick glance, I don't think you can do this series at all :(

Yes, maybe should take Christophe suggestion and use a bool or enum to distinguish them?

Thanks
Yisheng
> 
> greg k-h
> 
> .
> 

