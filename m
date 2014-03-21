From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Fri, 21 Mar 2014 13:53:58 +0000
Subject: Re: [PATCH] drivers/video: fix mb862xx_i2c depends issue build failure
Message-Id: <532C4476.2030706@windriver.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1395328560-48497-1-git-send-email-paul.gortmaker@windriver.com> <532C3F64.2020601@ti.com>
In-Reply-To: <532C3F64.2020601@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jim Davis <jim.epost@gmail.com>, Fengguang Wu <fengguang.wu@intel.com>

On 14-03-21 09:32 AM, Tomi Valkeinen wrote:
> Hi,
> 
> On 20/03/14 17:16, Paul Gortmaker wrote:
>> Any randconfig that sets I2C=m and FB_MB862XX_I2C=y will
>> encounter a final link failure that looks like this:
> 
> It compiles fine with I2C=m, FB_MB862XX=m and FB_MB862XX_I2C=y.
> 
>> drivers/built-in.o: In function `mb862xx_i2c_init':
>> drivers/video/mb862xx/mb862xx-i2c.c:165: undefined reference to `i2c_add_adapter'
>> drivers/built-in.o: In function `mb862xx_i2c_exit':
>> drivers/video/mb862xx/mb862xx-i2c.c:176: undefined reference to `i2c_del_adapter'
>>
>> Since FB_MB862XX_I2C is a bool and not tristate, simply
>> don't offer it at all if core I2C support is not built in.
> 
> FB_MB862XX_I2C is not a driver, it just adds the i2c support to
> FB_MB862XX. The relevant thing is whether FB_MB862XX is m or y, so
> compiling with:
> 
> I2C=m, FB_MB862XX=y and FB_MB862XX_I2C=y
> 
> will fail.

How would you suggest we fix it then?  Perhaps we could simplify the
Kconfig space and just get rid of FB_MB862XX_I2C entirely?  Is there
ever a reason why someone would want it turned off when I2C is present?

Paul.
--

> 
>> Reported-by: Jim Davis <jim.epost@gmail.com>
>> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>>
>> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
>> index dade5b7699bc..aefd1b9a3cbd 100644
>> --- a/drivers/video/Kconfig
>> +++ b/drivers/video/Kconfig
>> @@ -2338,7 +2338,7 @@ endchoice
>>  
>>  config FB_MB862XX_I2C
>>  	bool "Support I2C bus on MB862XX GDC"
>> -	depends on FB_MB862XX && I2C
>> +	depends on FB_MB862XX && I2C=y
>>  	default y
>>  	help
>>  	  Selecting this option adds Coral-P(A)/Lime GDC I2C bus adapter
> 
> This fix is not correct, as it prevents the following, valid, config:
> 
> I2C=m, FB_MB862XX=m and FB_MB862XX_I2C=y
> 
>  Tomi
> 
> 
