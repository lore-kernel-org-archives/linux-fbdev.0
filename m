From: Tabi Timur-B04825 <B04825@freescale.com>
Date: Wed, 05 Oct 2011 03:26:21 +0000
Subject: Re: [PATCH 9/9] drivers/video: fsl-diu-fb: merge diu_pool into
Message-Id: <4E8BCE5D.2010007@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1317244795-24671-9-git-send-email-timur@freescale.com>
In-Reply-To: <1317244795-24671-9-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Florian Tobias Schandinat wrote:

>> @@ -348,6 +341,11 @@ struct fsl_diu_data {
>>   	enum fsl_diu_monitor_port monitor_port;
>>   	struct diu __iomem *diu_reg;
>>   	spinlock_t reg_lock;
>> +	unsigned int mode;		/* DIU operation mode */
>
> And here you are introducing mode again....

I have no idea how that happened.  I never touched patch #9 during my 
rebase, and I removed that line from patch #8, so I can't explain how it 
got added back.

I spent hours verifying the patches to make sure that git-bisect still 
works and that each patch is clean.  It just never occurred to me to 
double-check a commit that I didn't modify.

> I think that you did not want to do
> this, so I only took the v2 of this series and combined them with the other
> patches of your old series (with the addition to the commit message in 4/9 as
> you wanted). Please verify that the result in
> git://github.com/schandinat/linux-2.6.git fbdev-next
> is what you want to have there.

Yes, it looks good.  Thanks for taking care of this for me.  These are the 
last patches for 3.2.

-- 
Timur Tabi
Linux kernel developer at Freescale
