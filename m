From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 28 Mar 2018 14:00:08 +0000
Subject: Re: [PATCH] video: fsl-diu-fb: Delete an error message for a failed memory allocation in fsl_diu_ini
Message-Id: <4073804.qevdOuysOu@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <39d05a48-e649-fb88-0e86-4f7528fd67f8@users.sourceforge.net>
 <CGME20171127173815epcas4p35a349f9b327e25953d5eb67563f288eb@epcas4p3.samsung.com>
 <f1760f28-84f4-24d9-9cf4-ca94b0537338@tabi.org>
In-Reply-To: <f1760f28-84f4-24d9-9cf4-ca94b0537338@tabi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Timur Tabi <timur@tabi.org>, SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org

On Monday, November 27, 2017 11:31:10 AM Timur Tabi wrote:
> On 11/27/17 3:00 AM, SF Markus Elfring wrote:
> > From: Markus Elfring<elfring@users.sourceforge.net>
> > Date: Mon, 27 Nov 2017 09:56:09 +0100
> > 
> > Omit an extra message for a memory allocation failure in this function.
> > 
> > This issue was detected by using the Coccinelle software.
> > 
> > Signed-off-by: Markus Elfring<elfring@users.sourceforge.net>
> 
> Acked-by: Timur Tabi <timur@tabi.org>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

