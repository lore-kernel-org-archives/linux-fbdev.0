From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 08 Feb 2019 17:02:17 +0000
Subject: Re: [PATCH] fbcon: use kvmalloc() for scrollback buffer
Message-Id: <ed53d034-9592-76e2-3122-dc2480890527@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20181126100342epcas3p12a1e6505ff4b73375ac3fcf5d0355d3f@epcas3p1.samsung.com>
 <20181126100253.3299-1-khorenko@virtuozzo.com>
 <a7f6bf30-5094-b669-126d-e4751c17dcbb@samsung.com>
 <4eba60c6-4eb8-5a82-f394-307f835f41e1@virtuozzo.com>
In-Reply-To: <4eba60c6-4eb8-5a82-f394-307f835f41e1@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>


On 12/21/2018 11:58 AM, Konstantin Khorenko wrote:
> Hi Bartlomiej,
> 
> On 12/20/2018 07:21 PM, Bartlomiej Zolnierkiewicz wrote:
>> On 11/26/2018 11:02 AM, Konstantin Khorenko wrote:
>>> Scrollback frame buffer is rather big - 32K,
>>> so it requires 3rd order page, so let's use kvmalloc() instead of
>>> ordinary kmalloc() for it.
>>
>> Is it actually safe to use non-contiguous memory for softback_buf?
> 
> Well, that's why we need a review. :)

:)

> i've asked myself same question while fixing this,
> i've dig sources a bit and did not find places when softback_buf is provided for DMA,
> all other places seems to work with virtual addresses, so there should be no problem.
> 
> Even more i saw a function which mentions that softback might be non-contigious:
> 
> /* As we might be inside of softback, we may work with non-contiguous buffer,
>     that's why we have to use a separate routine. */
> static void fbcon_invert_region(struct vc_data *vc, u16 * p, int cnt)
> 
> So i think it's safe to use kvmalloc() here.

Patch queued for v5.1, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
