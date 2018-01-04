From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 04 Jan 2018 13:31:58 +0000
Subject: Re: [PATCH v2] fbdev: pxa3xx: use ktime_get_ts64 for time stamps
Message-Id: <3904349.nl3lDnz3Dp@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171127164821epcas2p4a0a1849ceaa7a4f58a14bddc4419d4ec@epcas2p4.samsung.com>
 <20171127164755.525720-1-arnd@arndb.de>
In-Reply-To: <20171127164755.525720-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Himanshu Jha <himanshujha199640@gmail.com>, dri-devel@lists.freedesktop.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>

On Monday, November 27, 2017 05:46:14 PM Arnd Bergmann wrote:
> do_gettimeofday() is deprecated because it is not y2038 safe, so I'm
> changing the calculation for the diagnostic output over to using
> 'timespec64'.
> 
> We really only print time deltas here, so changing it to monotonic
> time makes this more robust, the correct accessor for this is
> ktime_get_ts64().
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch queued for 4.16, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

