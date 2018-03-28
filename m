From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 28 Mar 2018 14:27:01 +0000
Subject: Re: [PATCH 2/3] video: au1100fb: Improve a size determination in au1100fb_drv_probe()
Message-Id: <2447043.1duYbrvBpc@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <980dc009-429b-ad88-966b-0e75808cbacc@users.sourceforge.net>
 <CGME20171127180003epcas3p1a6c7cbe1be9bee79555a0e7f05b28024@epcas3p1.samsung.com>
 <231de972-f0bf-18ce-e681-a29767c086ea@users.sourceforge.net>
In-Reply-To: <231de972-f0bf-18ce-e681-a29767c086ea@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org

On Monday, November 27, 2017 06:59:57 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 27 Nov 2017 18:18:34 +0100
> 
> Replace the specification of a data structure by a pointer dereference
> as the parameter for the operator "sizeof" to make the corresponding size
> determination a bit safer according to the Linux coding style convention.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

