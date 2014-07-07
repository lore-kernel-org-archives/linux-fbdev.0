From: Noralf Tronnes <notro@tronnes.org>
Date: Mon, 07 Jul 2014 09:23:02 +0000
Subject: Re: [PATCH] video: fbdev: sis: init.c:  Cleaning up redundant condition is always true
Message-Id: <53BA66F6.9020605@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404422121-11298-1-git-send-email-rickard_strandqvist@spectrumdigital.se> <20140707075709.GI25934@mwanda>
In-Reply-To: <20140707075709.GI25934@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>, Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Mauro Carvalho Chehab <m.chehab@samsung.com>, "Chen, Gong" <gong.chen@linux.intel.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Den 07.07.2014 09:57, skrev Dan Carpenter:
> On Thu, Jul 03, 2014 at 11:15:21PM +0200, Rickard Strandqvist wrote:
>> diff --git a/drivers/video/fbdev/sis/init.c b/drivers/video/fbdev/sis/init.c
>> index bd40f5e..9e2dd96 100644
>> --- a/drivers/video/fbdev/sis/init.c
>> +++ b/drivers/video/fbdev/sis/init.c
>> @@ -355,12 +355,12 @@ SiS_GetModeID(int VGAEngine, unsigned int VBFlags, int HDisplay, int VDisplay,
>>   		}
>>   		break;
>>   	case 400:
>> -		if((!(VBFlags & CRT1_LCDA)) || ((LCDwidth >= 800) && (LCDwidth >= 600))) {
>> +		if ((!(VBFlags & CRT1_LCDA)) || (LCDwidth >= 600)) {
>
> It might be that this was supposed to be:
>
> 		if((!(VBFlags & CRT1_LCDA)) || ((LCDwidth <= 800) && (LCDwidth >= 600))) {
>
> But why would people write a range from high to low?  That's crazy
> people who write backwards code...
The numbers 800x600 (1024x768) indicate that LCDheight is meant to be used:
                  if((!(VBFlags & CRT1_LCDA)) || ((LCDwidth >= 800) && 
(LCDheight >= 600))) {

regards,
Noralf Tronnes

