From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 28 Mar 2018 14:05:30 +0000
Subject: Re: [PATCH 2/2] video: s3c-fb: Improve a size determination in s3c_fb_probe()
Message-Id: <2206589.7tfjgjbFvn@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <2c837da0-6b0f-12e7-4d76-960b660a8911@users.sourceforge.net>
 <CGME20171127180721epcas2p1549ab6d72f7d83ff7eb5276079037b26@epcas2p1.samsung.com>
 <000301d367aa$8efbbc40$acf334c0$@gmail.com>
In-Reply-To: <000301d367aa$8efbbc40$acf334c0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jingoohan1@gmail.com>, 'SF Markus Elfring' <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, 'LKML' <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org

On Monday, November 27, 2017 01:07:15 PM Jingoo Han wrote:
> On Sunday, November 26, 2017 9:18 AM, SF Markus Elfring wrote:
> > 
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Sun, 26 Nov 2017 15:03:03 +0100
> > 
> > Replace the specification of a data structure by a pointer dereference
> > as the parameter for the operator "sizeof" to make the corresponding size
> > determination a bit safer according to the Linux coding style convention.
> > 
> > This issue was detected by using the Coccinelle software.
> > 
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> 
> Acked-by: Jingoo Han <jingoohan1@gmail.com>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

