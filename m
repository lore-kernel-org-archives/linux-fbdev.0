From: Lars-Peter Clausen <lars@metafoo.de>
Date: Sun, 02 Sep 2012 15:19:56 +0000
Subject: Re: [PATCH 3/5] drivers/video/jz4740_fb.c: use devm_ functions
Message-Id: <5043791C.4050202@metafoo.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344008414-2894-1-git-send-email-damien.cassou@lifl.fr> <1344008414-2894-3-git-send-email-damien.cassou@lifl.fr> <5036955F.6000806@gmx.de>
In-Reply-To: <5036955F.6000806@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Damien Cassou <damien.cassou@lifl.fr>, kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 08/23/2012 10:41 PM, Florian Tobias Schandinat wrote:
> On 08/03/2012 03:40 PM, Damien Cassou wrote:
>> From: Damien Cassou <damien.cassou@lifl.fr>
>>
>> The various devm_ functions allocate memory that is released when a driver
>> detaches. This patch uses these functions for data that is allocated in the
>> probe function of a platform device and is only freed in the remove function.
>>
>> Signed-off-by: Damien Cassou <damien.cassou@lifl.fr>
> 
> Applied.
> 
> 
> Thanks,
> 
> Florian Tobias Schandinat
> 
>>
>> ---
>>  drivers/video/jz4740_fb.c |   22 ++++++----------------
>>  1 file changed, 6 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/video/jz4740_fb.c b/drivers/video/jz4740_fb.c
>> index de36693..7669770 100644
>> --- a/drivers/video/jz4740_fb.c
>> +++ b/drivers/video/jz4740_fb.c
>> @@ -659,25 +659,25 @@ static int __devinit jzfb_probe(struct platform_device *pdev)
>>  	jzfb->pdata = pdata;
>>  	jzfb->mem = mem;
>>
>> -	jzfb->ldclk = clk_get(&pdev->dev, "lcd");
>> +	jzfb->ldclk = devm_clk_get(&pdev->dev, "lcd");

I guess I'm a bit late, but we do not have devm_clk_get on jz4740 (yet), so
this patch breaks linking for this driver in next. I'll to to have this added
for the next release, but if I do not succeed we'll have to revert part of this
patch.

Also the driver does not include #include <linux/io.h>, since it is required
for devm_ioremap compilation is also broken. This one is easy to fix though,
will send a follow-up patch.

- Lars
