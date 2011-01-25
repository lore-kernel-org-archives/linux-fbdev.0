From: Heiko Schocher <hs@denx.de>
Date: Tue, 25 Jan 2011 08:02:15 +0000
Subject: Re: [PATCH 3/4 v4] video, sm501: add OF binding to support SM501
Message-Id: <4D3E8387.10501@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1291451028-22532-1-git-send-email-hs@denx.de>
	<1295940031-28268-1-git-send-email-hs@denx.de>
	<20110125074820.GI11673@linux-sh.org>
In-Reply-To: <20110125074820.GI11673-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Vincent Sanders <vince-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org

Hello Paul,

Paul Mundt wrote:
> On Tue, Jan 25, 2011 at 08:20:31AM +0100, Heiko Schocher wrote:
>> @@ -1934,7 +1943,29 @@ static int __devinit sm501fb_probe(struct platform_device *pdev)
>>  	}
>>  
>>  	if (info->pdata = NULL) {
>> -		dev_info(dev, "using default configuration data\n");
>> +		int found = 0;
>> +#if defined(CONFIG_OF)
>> +		struct device_node *np = pdev->dev.parent->of_node;
>> +		const u8 *prop;
>> +		const char *cp;
>> +		int len;
>> +
>> +		info->pdata = &sm501fb_def_pdata;
>> +		if (np) {
>> +			/* Get EDID */
>> +			cp = of_get_property(np, "mode", &len);
>> +			if (cp)
>> +				strcpy(fb_mode, cp);
>> +			prop = of_get_property(np, "edid", &len);
>> +			if (prop && len = EDID_LENGTH) {
>> +				info->edid_data = kmemdup(prop, EDID_LENGTH,
>> +							  GFP_KERNEL);
>> +				found = 1;
>> +			}
>> +		}
>> +#endif
>> +		if (!found)
>> +			dev_info(dev, "using default configuration data\n");
>>  	}
>>  
>>  	/* probe for the presence of each panel */
> 
> Starting to get a bit pedantic.. but kmemdup() tries to do a kmalloc(),

No problem!

> and so can fail. Your other patches handle the info->edid_data = NULL
> case, in addition to the kfree(), but you're probably going to want to
> chomp that found assignment incase of the allocation failing and falling
> back on the default mode.
> 
> You also don't really have any need to keep the EDID block around after
> probe as far as I can tell, so you should be able to rework this in to
> something more like:
> 
> 	info->edid_data = kmemdup(..);
> 	...
> 	if (info->edid_data) {
> 		fb_edid_to_monspecs(..);
> 		kfree(info->edid_data);
> 		fb_videomode_to_modelist(..);
> 	}
> 
> 	...

Ok, rework this part, thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
