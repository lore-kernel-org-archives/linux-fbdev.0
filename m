From: Randy Dunlap <rdunlap@infradead.org>
Date: Mon, 08 Oct 2018 15:54:10 +0000
Subject: Re: [PATCH] video: fbdev: remove redundant 'default n' from Kconfig-s
Message-Id: <84e7faee-234e-5640-1c25-83f152bc19a9@infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20181008154002eucas1p1a15786f9178c9949d99c72cfa81f5449@eucas1p1.samsung.com>
 <20181008154002eucas1p1a15786f9178c9949d99c72cfa81f5449~brFqL1l6v1788017880eucas1p1O@eucas1p1.samsung.com>
In-Reply-To: <20181008154002eucas1p1a15786f9178c9949d99c72cfa81f5449~brFqL1l6v1788017880eucas1p1O@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

On 10/8/18 8:40 AM, Bartlomiej Zolnierkiewicz wrote:
> 'default n' is the default value for any bool or tristate Kconfig
> setting so there is no need to write it explicitly.
> 
> Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
> is not set' for visible symbols") the Kconfig behavior is the same
> regardless of 'default n' being present or not:
> 
>     ...
>     One side effect of (and the main motivation for) this change is making
>     the following two definitions behave exactly the same:
>     
>         config FOO
>                 bool
>     
>         config FOO
>                 bool
>                 default n

	config FOO
		def_bool n

is a good substitute, especially for non-prompt symbols. (IMHO)

>     With this change, neither of these will generate a
>     '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
>     That might make it clearer to people that a bare 'default n' is
>     redundant.
>     ...
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  drivers/video/fbdev/Kconfig                  |   28 ---------------------------
>  drivers/video/fbdev/mmp/hw/Kconfig           |    1 
>  drivers/video/fbdev/mmp/panel/Kconfig        |    1 
>  drivers/video/fbdev/omap2/omapfb/dss/Kconfig |    7 ------
>  4 files changed, 37 deletions(-)

thanks.
-- 
~Randy
