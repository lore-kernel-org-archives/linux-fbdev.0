From: Dzianis Kahanovich <mahatma@bspu.unibel.by>
Date: Tue, 04 Jan 2011 11:16:08 +0000
Subject: Re: [PATCH] viafb: fix viafb_find_i2c_adapt return value
Message-Id: <4D230178.9060406@bspu.unibel.by>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4D0FAB7E.1080704@bspu.unibel.by>
In-Reply-To: <4D0FAB7E.1080704@bspu.unibel.by>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Florian Tobias Schandinat wrote:
> [cc'ed Jon; un-cc'ed Joseph as his email address is no longer valid]
> 
> Dzianis Kahanovich schrieb:
>> viafb_find_i2c_adapt return unverifyed value, "is_active" field still uplevel.
>> Fix it.
> 
> This patch looks useful to me but the viafb camera driver uses this function at
> the moment. It's not a big issue now as 31 will be always I2C but perhaps it
> might be a good idea to patch drivers/media/video/via-camera.c

Oops!

> 
> Jon, do you agree that this patch is useful, at least as long we do not
> dynamically change the configuration?
> 
> 
> Thanks,
> 
> Florian Tobias Schandinat
> 
>>
>> Signed-off-by: Dzianis Kahanovich <mahatma@eu.by>
>> ---
>> --- a/drivers/video/via/via_i2c.c    2010-12-18 06:42:37.000000000 +0200
>> +++ b/drivers/video/via/via_i2c.c    2010-12-20 19:55:17.000000000 +0200
>> @@ -188,7 +188,7 @@ struct i2c_adapter *viafb_find_i2c_adapt
>>  {
>>      struct via_i2c_stuff *stuff = &via_i2c_par[which];
>>
>> -    return &stuff->adapter;
>> +    return stuff->is_active ? &stuff->adapter : NULL;
>>  }
>>  EXPORT_SYMBOL_GPL(viafb_find_i2c_adapter);
>>
>> -- 
>>
>>
> 
> 
> 


-- 
WBR, Dzianis Kahanovich AKA Denis Kaganovich, http://mahatma.bspu.unibel.by/
