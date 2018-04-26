From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 26 Apr 2018 09:55:21 +0000
Subject: Re: [PATCH] video: sh_mobile_meram: Delete an error message for a failed memory allocation in sh_mob
Message-Id: <5653552.NjqMPzOcdg@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171126121927epcas1p458cb7728927507525b54a47a9dfc6529@epcas1p4.samsung.com>
 <1feb3cf8-77e6-367e-5f5c-23fdd96339ec@users.sourceforge.net>
In-Reply-To: <1feb3cf8-77e6-367e-5f5c-23fdd96339ec@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org

On Sunday, November 26, 2017 01:19:17 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 26 Nov 2017 13:08:43 +0100
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

