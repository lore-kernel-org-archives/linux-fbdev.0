From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 28 Jun 2019 10:37:14 +0000
Subject: Re: [PATCH] video: fbdev: s3c-fb: fix sparse warnings about using incorrect types
Message-Id: <0c1c0ba0-a37b-2018-ab0a-ea89b99587d1@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190627125803eucas1p1eb6a37f5fa96fd732e41ab1501367de5@eucas1p1.samsung.com>
        <908fc26e-3bfa-c204-6c32-7d814fdcb37b@samsung.com>
        <PSXP216MB0662D369EFFABF260394F179AAFC0@PSXP216MB0662.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PSXP216MB0662D369EFFABF260394F179AAFC0@PSXP216MB0662.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jingoohan1@gmail.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


On 6/28/19 7:50 AM, Jingoo Han wrote:
> On 6/27/19, 9:58 PM, Bartlomiej Zolnierkiewicz wrote:
>>
>> Use ->screen_buffer instead of ->screen_base to fix sparse warnings.
>>
>> [ Please see commit 17a7b0b4d974 ("fb.h: Provide alternate screen_base
>>   pointer") for details. ]
>>
>> Reported-by: kbuild test robot <lkp@intel.com>
>> Cc: Jingoo Han <jingoohan1@gmail.com>
> 
> Acked-by: Jingoo Han <jingoohan1@gmail.com>

Thanks, I queued the patch for v5.3.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
