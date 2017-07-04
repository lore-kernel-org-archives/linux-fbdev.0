From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 04 Jul 2017 14:14:40 +0000
Subject: Re: [PATCH] vmlfb: Fix error handling in cr_pll_init()
Message-Id: <1766140.hGBLfEqc96@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170622214347epcas4p12f0d1d6fad27b6b1ee41223329e3d8e2@epcas4p1.samsung.com>
        <1498167814-5178-1-git-send-email-khoroshilov@ispras.ru>
In-Reply-To: <1498167814-5178-1-git-send-email-khoroshilov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Alan Hourihane <alanh@fairlite.demon.co.uk>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org

On Friday, June 23, 2017 12:43:34 AM Alexey Khoroshilov wrote:
> There is an error path, where iomemory is left mapped.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Patch queued for 4.13, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

