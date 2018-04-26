From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 26 Apr 2018 09:55:43 +0000
Subject: Re: [PATCH] video: sh_mobile_lcdcfb: Delete an error message for a failed memory allocation in two f
Message-Id: <4464673.qDa0qndI0l@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171126130035epcas1p3facfaae6b81c00dc4c9d255e5b8b8bc0@epcas1p3.samsung.com>
 <478c51ab-b4ef-47e1-0b53-8b4e1f3b931a@users.sourceforge.net>
In-Reply-To: <478c51ab-b4ef-47e1-0b53-8b4e1f3b931a@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, Kees Cook <keescook@chromium.org>, Geert Uytterhoeven <geert+renesas@glider.be>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, Wei Yongjun <weiyongjun1@huawei.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>

On Sunday, November 26, 2017 02:00:16 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 26 Nov 2017 13:48:55 +0100
> 
> Omit an extra message for a memory allocation failure in these functions.
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

