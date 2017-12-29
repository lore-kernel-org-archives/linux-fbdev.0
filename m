From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 29 Dec 2017 18:10:00 +0000
Subject: Re: [0/4] video-UDLFB: Adjustments for five function implementations
Message-Id: <ea9813ee-a5a8-7e35-bac5-b2e0652f6602@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171124204825epcas1p41626d598b6e437dfb4c6b648e3730cc1@epcas1p4.samsung.com>
 <6fb11bb4-2c1d-a939-087b-de31c42328b9@users.sourceforge.net>
 <1768474.zA76iyE2Y1@amdc3058>
In-Reply-To: <1768474.zA76iyE2Y1@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, Bernie Thompson <bernie@plugable.com>, LKML <linux-kernel@vger.kernel.org>

>>   Delete an error message for a failed memory allocation in two functions
> 
> This patch removes the information about the device for which the allocation fails.

* Do you find a Linux allocation failure report insufficient in this use case?

* Are you looking for any more clarification?


>>   Improve a size determination in dlfb_alloc_urb_list()
> 
> Patch queued for 4.16, thanks.

Thanks for your acceptance of other change possibilities.

Regards,
Markus
