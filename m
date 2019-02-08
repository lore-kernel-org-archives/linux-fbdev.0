From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 08 Feb 2019 17:06:43 +0000
Subject: Re: [PATCH] video: offb: annotate implicit fall throughs
Message-Id: <efc378bc-a779-7fa3-209c-a331b1055ae6@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190114204044.20528-1-malat@debian.org>
        <CGME20190114215109epcas3p2eb2c3b3f91cc036b9604b88520410056@epcas3p2.samsung.com>
        <15854ad8-7bd5-ede7-6ce4-00122d6ba279@embeddedor.com>
In-Reply-To: <15854ad8-7bd5-ede7-6ce4-00122d6ba279@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Mathieu Malaterre <malat@debian.org>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


On 01/14/2019 10:50 PM, Gustavo A. R. Silva wrote:
> 
> 
> On 1/14/19 2:40 PM, Mathieu Malaterre wrote:
>> There is a plan to build the kernel with -Wimplicit-fallthrough and
>> these places in the code produced warnings (W=1). Fix them up.
>>
>> This commit remove the following warnings:
>>
>>    drivers/video/fbdev/offb.c:211:5: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>    drivers/video/fbdev/offb.c:142:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>
>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> 
> Acked-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch queued for v5.1, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
