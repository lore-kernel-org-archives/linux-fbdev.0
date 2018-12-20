From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 20 Dec 2018 17:58:49 +0000
Subject: Re: [PATCH] fbdev: fsl-diu: remove redundant null check on cmap
Message-Id: <ad9f6b25-b495-720d-8c36-b3bc76e9a173@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181203064317.57054-1-wen.yang99@zte.com.cn>
        <CGME20181203145425epcas5p31989c68b52994dd2e85f4372082a7ebe@epcas5p3.samsung.com>
        <bda8bdc3-46cb-883d-1ddc-8fda0cf241be@kernel.org>
In-Reply-To: <bda8bdc3-46cb-883d-1ddc-8fda0cf241be@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Timur Tabi <timur@kernel.org>, Wen Yang <wen.yang99@zte.com.cn>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn


On 12/03/2018 03:53 PM, Timur Tabi wrote:
> On 12/3/18 12:43 AM, Wen Yang wrote:
>> The null check on &info->cmap is redundant since cmap is a struct
>> inside fb_info and can never be null, so the check is always true.
>> we may remove it.
>>
>> Signed-off-by: Wen Yang<wen.yang99@zte.com.cn>
> 
> Acked-by: Timur Tabi <timur@kernel.org>

Patch queued for 4.21, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
