From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 04 Jan 2018 17:08:11 +0000
Subject: Re: [0/4] video-UDLFB: Adjustments for five function implementations
Message-Id: <3534828.CjlOGYDRrE@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171124204825epcas1p41626d598b6e437dfb4c6b648e3730cc1@epcas1p4.samsung.com>
 <1768474.zA76iyE2Y1@amdc3058>
 <ea9813ee-a5a8-7e35-bac5-b2e0652f6602@users.sourceforge.net>
In-Reply-To: <ea9813ee-a5a8-7e35-bac5-b2e0652f6602@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, Bernie Thompson <bernie@plugable.com>, dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>

On Friday, December 29, 2017 07:10:00 PM SF Markus Elfring wrote:
> >>   Delete an error message for a failed memory allocation in two functions
> > 
> > This patch removes the information about the device for which the allocation fails.
> 
> * Do you find a Linux allocation failure report insufficient in this use case?

Yes, there is more information available currently in the driver and
I see no real improvement in removing it.

> * Are you looking for any more clarification?

I will not apply any of such patches for now. The only exception
being drivers that support hardware that can have only one instance
in the system (but it needs to be explicitly stated in the patch
description and the patch needs to be reviewed by a someone else
than the author).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

