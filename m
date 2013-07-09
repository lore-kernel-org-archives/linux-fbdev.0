From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Tue, 09 Jul 2013 08:50:26 +0000
Subject: Re: [PATCH V6 0/4] Generic PHY driver for the Exynos SoC DP PHY
Message-Id: <51DBCED2.7010102@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <003d01ce7c7a$d04043d0$70c0cb70$@samsung.com>
In-Reply-To: <003d01ce7c7a$d04043d0$70c0cb70$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 07/09/2013 10:03 AM, Jingoo Han wrote:
> This patch series adds a simple driver for the Samsung Exynos SoC
> series DP transmitter PHY, using the generic PHY framework [1].
> Previously the DP PHY used an internal DT node to control the PHY
> power enable bit.
> 
> These patches was tested on Exynos5250.
> 
> This PATCH v6 follows:
>  * PATCH v5, sent on July, 8th 2013
>  * PATCH v4, sent on July, 2nd 2013
>  * PATCH v3, sent on July, 1st 2013
>  * PATCH v2, sent on June, 28th 2013
>  * PATCH v1, sent on June, 28th 2013
> 
> Changes between v5 and v6:
>   * Re-based on git://gitorious.org/linuxphy/linuxphy.git

I'm not sure if we really need to keep the documentation of the
original binding. Anyway, for the whole series, please feel free
to ad my

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

--
Thanks,
Sylwester

