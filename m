From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 26 Apr 2018 09:58:13 +0000
Subject: Re: [PATCH] video: auo_k190x: Delete an error message for a failed memory allocation in auok190x_com
Message-Id: <12927877.qfyOtgPPrp@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171127170150epcas3p2bd5a7ba3a64c7a4f03ab823cf3707ebe@epcas3p2.samsung.com>
 <757f0d7c-e356-2e69-46e6-0bf5067877e1@users.sourceforge.net>
In-Reply-To: <757f0d7c-e356-2e69-46e6-0bf5067877e1@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>

On Monday, November 27, 2017 06:01:41 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 27 Nov 2017 17:53:05 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

I've done requested audit regarding multiple fb devices support
myself now and it is okay to apply this patch.

Patch queued for 4.18, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

