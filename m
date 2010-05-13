From: Nishanth Menon <nm@ti.com>
Date: Thu, 13 May 2010 16:15:09 +0000
Subject: Re: [PATCH v2 1/2] DSS2: Allow FB_OMAP2 to build without VRFB
Message-Id: <4BEC258D.7030104@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1273764028-25822-1-git-send-email-svadivu@ti.com> <1273764028-25822-2-git-send-email-svadivu@ti.com> <EBB422FB-C763-4EBE-AAD3-02AE86D4FF05@student.utwente.nl>
In-Reply-To: <EBB422FB-C763-4EBE-AAD3-02AE86D4FF05@student.utwente.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: "Guruswamy, Senthilvadivu" <svadivu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

Koen Kooi had written, on 05/13/2010 11:00 AM, the following:
> Op 13 mei 2010, om 17:20 heeft Senthilvadivu Guruswamy het volgende geschreven:
> 
>> FB_OMAP2 can work without VRFB, but currently does not build. Fix this.
>>
>> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
>> ---
>> arch/arm/plat-omap/include/plat/vrfb.h |   16 ++++++++++++++++
>> 1 file changed, 16 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/include/plat/vrfb.h b/arch/arm/plat-omap/include/plat/vrfb.h
>> index d8a03ce..3792bde 100644
>> --- a/arch/arm/plat-omap/include/plat/vrfb.h
>> +++ b/arch/arm/plat-omap/include/plat/vrfb.h
>> @@ -35,6 +35,7 @@ struct vrfb {
>> 	bool yuv_mode;
>> };
>>
>> +#ifdef CONFIG_OMAP2_VRFB
> 
> That is still a compiletime option, not a runtime check. You need something like if(is_omap3()), not #ifdef 
> 
having VRFB or tiler is a SOC feature - ideal detection should be in 
id.c using the FEATURES framework.

and the actual rotation handling should be handled with function 
pointers to use VRFB apis OR use tiler APIs (once it is available) to 
runtime use the right rotation/other features functions runtime..

-- 
Regards,
Nishanth Menon
