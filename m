From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 29 Dec 2017 17:36:53 +0000
Subject: Re: [PATCH] video: fbdev: remove redundant self assignment of 'height'
Message-Id: <1976355.NVJMmshGZV@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171123105559epcas5p2098447b1667bcb96fa6162fdd939dce0@epcas5p2.samsung.com>
 <20171123105553.18969-1-colin.king@canonical.com>
In-Reply-To: <20171123105553.18969-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Colin King <colin.king@canonical.com>
Cc: linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Thursday, November 23, 2017 10:55:53 AM Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The assignment of height to itself is redundant and can be removed.
> Detected with Coccinelle.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch queued for 4.16, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

