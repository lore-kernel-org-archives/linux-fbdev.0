From: Andrzej Hajda <a.hajda@samsung.com>
Date: Thu, 27 Jun 2013 07:47:47 +0000
Subject: Re: [PATCH v2 1/5] phy: Add driver for Exynos MIPI CSIS/DSIM DPHYs
Message-Id: <51CBEE23.4010402@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1372170110-12993-1-git-send-email-s.nawrocki@samsung.com>
 <20130625150649.GA21334@arwen.pp.htv.fi> <51CB0212.3050103@samsung.com>
 <20130627061713.GF15455@arwen.pp.htv.fi>
In-Reply-To: <20130627061713.GF15455@arwen.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Felipe,

On 06/27/2013 08:17 AM, Felipe Balbi wrote:
> On Wed, Jun 26, 2013 at 05:00:34PM +0200, Sylwester Nawrocki wrote:
>> Hi,
>>
>> On 06/25/2013 05:06 PM, Felipe Balbi wrote:
>>>> +static struct platform_driver exynos_video_phy_driver = {
>>>>> +	.probe	= exynos_video_phy_probe,
>>>
>>> you *must* provide a remove method. drivers with NULL remove are
>>> non-removable :-)
>>
>> Actually the remove() callback can be NULL, it's just missing module_exit
>> function that makes a module not unloadable.
> 
> look at the implementation of platform_drv_remove():
> 
>  499 static int platform_drv_remove(struct device *_dev)
>  500 {
>  501         struct platform_driver *drv = to_platform_driver(_dev->driver);
>  502         struct platform_device *dev = to_platform_device(_dev);
>  503         int ret;
>  504 
>  505         ret = drv->remove(dev);
>  506         if (ACPI_HANDLE(_dev))
>  507                 acpi_dev_pm_detach(_dev, true);
>  508 
>  509         return ret;
>  510 }
> 
> that's not a conditional call right :-)

It is conditional, just condition check is in different place:

int platform_driver_register(struct platform_driver *drv)
{
	(...)
	if (drv->remove)
		drv->driver.remove = platform_drv_remove;
	(...)
}


Regards
Andrzej

> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

