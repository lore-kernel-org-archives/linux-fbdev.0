From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 08 Nov 2017 16:27:19 +0000
Subject: Re: [PATCH 1/2] fbdev: pxa3xx: use ktime_get_ts64 for time stamps
Message-Id: <CAK8P3a1w-dpJnqqS8BOPuQFJPdY-62wjoDrWkifMK6MVSbPTKw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171107141319.3390036-1-arnd@arndb.de>
In-Reply-To: <20171107141319.3390036-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Himanshu Jha <himanshujha199640@gmail.com>

On Tue, Nov 7, 2017 at 3:13 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> do_gettimeofday() is deprecated because it is not y2038 safe, so I'm
> changing the calculation for the diagnostic output over to using
> 'timespec64'.
>
> We really only print time deltas here, so changing it to monotonic
> time makes this more robust, the correct accessor for this is
> ktime_get_ts64().
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Please ignore this patch, my randconfig builder found a typo that
I had not noticed before.

         Arnd
