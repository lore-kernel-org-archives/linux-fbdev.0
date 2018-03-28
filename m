From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 28 Mar 2018 14:19:31 +0000
Subject: Re: [PATCH] video/console/sticore: Delete an error message for a failed memory allocation in sti_try
Message-Id: <1899328.6kM0nNg5W5@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171205180033epcas4p3cb5142e079695c72736e1f27489466d3@epcas4p3.samsung.com>
 <6b8dde60-0550-5fb3-c7a5-5f6282259186@users.sourceforge.net>
In-Reply-To: <6b8dde60-0550-5fb3-c7a5-5f6282259186@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>, kernel-janitors@vger.kernel.org, "James E. J.
 Bottomley" <jejb@parisc-linux.org>, dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>

On Tuesday, December 05, 2017 07:00:22 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 5 Dec 2017 18:45:42 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
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

