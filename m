From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 28 Jun 2019 10:26:43 +0000
Subject: Re: [PATCH 1/3] video: fbdev: s3c-fb: return -ENOMEM on framebuffer_alloc() failure
Message-Id: <4b4b8ce6-5398-9df2-9cd9-8b58ec769ad5@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190614144735eucas1p2f71313b752ae4ea841ddd4ea502fd79f@eucas1p2.samsung.com>
        <bbf32fbc-b4bc-39fc-e8dd-db9f0cd0d83f@samsung.com>
        <PSXP216MB066270BD6566CA5CDCEB1C7AAAEA0@PSXP216MB0662.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PSXP216MB066270BD6566CA5CDCEB1C7AAAEA0@PSXP216MB0662.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jingoohan1@gmail.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


On 6/18/19 8:13 AM, Jingoo Han wrote:
> On 6/14/19, 11:47 PM, Bartlomiej Zolnierkiewicz wrote:
>>
>> Fix error code from -ENOENT to -ENOMEM.
>>
>> Cc: Jingoo Han <jingoohan1@gmail.com>
> Acked-by: Jingoo Han <jingoohan1@gmail.com>

Thanks, I queued the patch for v5.3.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
