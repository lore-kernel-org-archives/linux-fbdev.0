From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 02 Mar 2020 15:41:52 +0000
Subject: Re: [PATCH 1/2] video: fbdev: w100fb: fix sparse warnings
Message-Id: <41d71487-4479-2d7d-7fad-e25f01c939ec@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200116145320eucas1p188ed7bed08623bc2c2ba6b863ff223d8@eucas1p1.samsung.com>
 <d438108a-e569-a14a-a9b1-3fefd88fcadc@samsung.com>
 <20200117185737.GB24508@ravnborg.org>
In-Reply-To: <20200117185737.GB24508@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


On 1/17/20 7:57 PM, Sam Ravnborg wrote:
> On Thu, Jan 16, 2020 at 03:53:20PM +0100, Bartlomiej Zolnierkiewicz wrote:
>> * Add missing __iomem annotations where needed.
>> * Make w100fb_probe() static.
>> * Return NULL pointer (instead of using plain integer) in
>>   w100_get_xtal_tabl().
>>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
Thanks, patch queued for v5.7.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
