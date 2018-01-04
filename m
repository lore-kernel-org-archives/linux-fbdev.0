From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 04 Jan 2018 12:45:09 +0000
Subject: Re: [PATCH 2/2] fbdev: radeon: stop use ktime_get() for HZ calibration
Message-Id: <2015687.0PYlFYgkdq@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171107141319.3390036-1-arnd@arndb.de>
 <CGME20171107141345epcas5p1d0caad149b3a67ef130149544ca18396@epcas5p1.samsung.com>
 <20171107141319.3390036-2-arnd@arndb.de>
In-Reply-To: <20171107141319.3390036-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Colin Ian King <colin.king@canonical.com>

On Tuesday, November 07, 2017 03:13:06 PM Arnd Bergmann wrote:
> do_gettimeofday() is deprecated and a bit clumsy. This changes
> radeon_probe_pll_params() over to using ktime_get() with monotonic
> times. There is no need to check for negative values any more
> since the monotonic clocksource cannot go backwards, but I'm
> adding a check for zero-division in case of a bad clocksource.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch queued for 4.16, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

