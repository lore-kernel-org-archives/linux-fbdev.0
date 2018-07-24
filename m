From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 24 Jul 2018 17:00:09 +0000
Subject: Re: [PATCH] fbdev: fix omap2/omapfb/dss/ indentation warning
Message-Id: <7268691.71nTWOfbFt@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180722031614epcas3p180b7f14a540d6913e70c2308651fe4f1@epcas3p1.samsung.com>
 <6a9560cc-1abc-f329-d82e-0a128d29c9fe@infradead.org>
In-Reply-To: <6a9560cc-1abc-f329-d82e-0a128d29c9fe@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org

On Saturday, July 21, 2018 08:16:09 PM Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix indentation warning (from gcc 8.1.0) in omap2/omapfb:
> 
> ../drivers/video/fbdev/omap2/omapfb/dss/dispc.c: In function 'pixinc':
> ../drivers/video/fbdev/omap2/omapfb/dss/dispc.c:1859:2: warning: this 'else' clause does not guard... [-Wmisleading-indentation]
>   else
>   ^~~~
> ../drivers/video/fbdev/omap2/omapfb/dss/dispc.c:1861:3: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'else'
>    return 0;
>    ^~~~~~
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: linux-omap@vger.kernel.org
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org

Patch queued for 4.19, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

