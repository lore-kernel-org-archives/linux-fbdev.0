From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 09 Nov 2017 15:53:42 +0000
Subject: Re: [PATCH] video: fbdev: intelfb: remove redundant variables
Message-Id: <5552409.pVDogND5TS@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171106131737epcas3p2c8da62f9f262825461ca244b597a863f@epcas3p2.samsung.com>
 <20171106131711.6499-1-colin.king@canonical.com>
In-Reply-To: <20171106131711.6499-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Colin King <colin.king@canonical.com>
Cc: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, Maik Broemme <mbroemme@libmpq.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Monday, November 06, 2017 01:17:11 PM Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variables err_max, err_target and f_best are being assigned values but
> these are never read, hence they are redundant variables and can be
> removed. Cleans up clang warnings:
> 
> drivers/video/fbdev/intelfb/intelfbhw.c:946:2: warning: Value stored to
> 'err_max' is never read
> drivers/video/fbdev/intelfb/intelfbhw.c:947:2: warning: Value stored to
> 'err_target' is never read
> drivers/video/fbdev/intelfb/intelfbhw.c:995:6: warning: Value stored to
> 'f_best' is never read
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch queued for 4.15, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

