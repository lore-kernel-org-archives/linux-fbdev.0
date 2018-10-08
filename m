From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 08 Oct 2018 10:18:02 +0000
Subject: Re: [PATCH] video: fbdev: add the dependency of broadsheetfb in Kconfig
Message-Id: <20181008101803eucas1p1a349978a3ea9637a7901c465bc5bff9a~bmsh9q_lm1440414404eucas1p1y@eucas1p1.samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180727081315epcas2p42a5d377bdbf3e8e6d2e18c2d1189d9d0@epcas2p4.samsung.com>
        <20180727081257.3571-1-baijiaju1990@gmail.com>
In-Reply-To: <20180727081257.3571-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


On 07/27/2018 10:12 AM, Jia-Ju Bai wrote:
> broadsheetfb is a platform driver and it should not be used on x86.
> It should be used only by single ARM PXA board, so adding the 
> dependency in Kconfig.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Patch queued for 4.20, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
