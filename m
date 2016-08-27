From: Oleg Drokin <green@linuxhacker.ru>
Date: Sat, 27 Aug 2016 03:28:35 +0000
Subject: Re: [PATCH] mx3fb: Fix print format string
Message-Id: <19CCD264-3BFB-4F06-8360-2A05AE628013@linuxhacker.ru>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1472267137-810445-1-git-send-email-green@linuxhacker.ru> <1472267886.26978.3.camel@perches.com>
In-Reply-To: <1472267886.26978.3.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "Luis R. Rodriguez" <mcgrof@suse.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


On Aug 26, 2016, at 11:18 PM, Joe Perches wrote:

> On Fri, 2016-08-26 at 23:05 -0400, Oleg Drokin wrote:
>> %ul was probably meant as %lu since the former would print
>> an unsigned value and a letter l.
>> 
>> But in fact the whole value we are printing in u32 anyway, so
>> we don't need the format to be long. Therefore just drop the l
>> altogether.
> []
>> Also do we really need 1000UL specification if we
>> cast to u32 anyway? Or should we drop away the cast instead?
>> Are pixelclocks over 4GHz possible here?
> 
> It's a debugging printk, it doesn't matter much.
> Why not use "%u kHz" and drop the "* 1000UL"?

I have no strong opinion on this since it's not my debugging code.

But XXX000l Hz makes zero sense either way.

>> diff --git a/drivers/video/fbdev/mx3fb.c b/drivers/video/fbdev/mx3fb.c
> []
>> @@ -845,7 +845,7 @@ static int __set_par(struct fb_info *fbi, bool lock)
>>  		if (fbi->var.sync & FB_SYNC_SHARP_MODE)
>>  			mode = IPU_PANEL_SHARP_TFT;
>>  
>> -		dev_dbg(fbi->device, "pixclock = %ul Hz\n",
>> +		dev_dbg(fbi->device, "pixclock = %u Hz\n",
>>  			(u32) (PICOS2KHZ(fbi->var.pixclock) * 1000UL));
>>  
>>  		if (sdc_init_panel(mx3fb, mode,
>>                                    (PICOS2KHZ(fbi->var.pixclock)) * 1000UL,

I guess it's printed like that to match sdc_init_panel argument exactly?

