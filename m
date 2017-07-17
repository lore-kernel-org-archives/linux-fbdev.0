From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Date: Mon, 17 Jul 2017 04:06:42 +0000
Subject: Re: [PATCH] video: xilinxfb: constify fb_fix_screeninfo and fb_var_screeninfo structures
Message-Id: <f9952748-5663-19ae-5417-aaf3c3f01d7e@embeddedor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170708012416.GA1843@embeddedgus>
 <c55390b8-c64b-e7ee-8099-5147970d5311@xilinx.com>
In-Reply-To: <c55390b8-c64b-e7ee-8099-5147970d5311@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org



On 07/10/2017 02:29 AM, Michal Simek wrote:
> On 8.7.2017 03:24, Gustavo A. R. Silva wrote:
>> These structures are only used to copy into other structures,
>> so declare them as const.
>>
>> This issue was detected using Coccinelle and the following semantic patch:
>>
>> @r disable optional_qualifier@
>> identifier i;
>> position p;
>> @@
>> static struct fb_fix_screeninfo i@p = { ... };
>>
>> @ok@
>> identifier r.i;
>> expression e;
>> position p;
>> @@
>> e = i@p
>>
>> @bad@
>> position p != {r.p,ok.p};
>> identifier r.i;
>> struct fb_fix_screeninfo e;
>> @@
>> e@i@p
>>
>> @depends on !bad disable optional_qualifier@
>> identifier r.i;
>> @@
>> static
>> +const
>>   struct fb_fix_screeninfo i = { ... };
>>
>> The semantic patch for fb_var_screeninfo is analogous.
>>
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>> ---
>>   drivers/video/fbdev/xilinxfb.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/xilinxfb.c b/drivers/video/fbdev/xilinxfb.c
>> index 17dc119..0bda18e 100644
>> --- a/drivers/video/fbdev/xilinxfb.c
>> +++ b/drivers/video/fbdev/xilinxfb.c
>> @@ -110,14 +110,14 @@ static struct xilinxfb_platform_data xilinx_fb_default_pdata = {
>>   /*
>>    * Here are the default fb_fix_screeninfo and fb_var_screeninfo structures
>>    */
>> -static struct fb_fix_screeninfo xilinx_fb_fix = {
>> +static const struct fb_fix_screeninfo xilinx_fb_fix = {
>>   	.id =		"Xilinx",
>>   	.type =		FB_TYPE_PACKED_PIXELS,
>>   	.visual =	FB_VISUAL_TRUECOLOR,
>>   	.accel =	FB_ACCEL_NONE
>>   };
>>   
>> -static struct fb_var_screeninfo xilinx_fb_var = {
>> +static const struct fb_var_screeninfo xilinx_fb_var = {
>>   	.bits_per_pixel =	BITS_PER_PIXEL,
>>   
>>   	.red =		{ RED_SHIFT, 8, 0 },
>>
> Acked-by: Michal Simek <michal.simek@xilinx.com>

Thank you, Michal.

-- 
Gustavo A. R. Silva

