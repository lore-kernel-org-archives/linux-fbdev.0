From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 28 Mar 2018 14:31:33 +0000
Subject: Re: [PATCH] video: fbdev: s3c-fb: remove dead platform code for Exynos and S5PV210 platforms
Message-Id: <1635191.86fAONqsAU@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180214120041epcas2p37afd51e693a9cad842e59128a77d45ac@epcas2p3.samsung.com>
 <2621881.tniV7NOQqn@amdc3058> <000001d3a5de$b9d2d080$2d787180$@gmail.com>
In-Reply-To: <000001d3a5de$b9d2d080$2d787180$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jingoohan1@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Wednesday, February 14, 2018 04:56:53 PM Jingoo Han wrote:
> On Wednesday, February 14, 2018 7:01 AM wrote:
> > 
> > Exynos5, Exynos4 and S5PV210 platforms have been converted to
> > use Device Tree and Exynos DRM driver long time ago.  Remove
> > dead platform code for these platforms and update Kconfig
> > s3c-fb entry accordingly.
> > 
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> 
> Acked-by: Jingoo Han <jingoohan1@gmail.com>

Thanks.

Patch queued for 4.17.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

