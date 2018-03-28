From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 28 Mar 2018 14:28:59 +0000
Subject: Re: [PATCH 3/3] video: au1100fb: Delete an unnecessary variable initialisation in au1100fb_drv_probe
Message-Id: <2275639.QNQijrIxQE@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <980dc009-429b-ad88-966b-0e75808cbacc@users.sourceforge.net>
 <CGME20171127180150epcas2p28b2fc98c549029837356af0fc6b1244c@epcas2p2.samsung.com>
 <37b97970-6cd7-5c85-a613-8c558b8d4fa0@users.sourceforge.net>
In-Reply-To: <37b97970-6cd7-5c85-a613-8c558b8d4fa0@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org

On Monday, November 27, 2017 07:01:14 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 27 Nov 2017 18:40:23 +0100
> 
> The local variable "fbdev" will be reassigned by a following statement.
> Thus omit the explicit initialisation at the beginning.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

