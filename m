From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 04 Jan 2018 14:40:38 +0000
Subject: Re: [PATCH] fbdev: arm64 use __raw I/O memory api
Message-Id: <8828134.HyumoOyT0m@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171130081731epcas1p1bdd2f9a3e55307bf732ba4c7cbbd8f01@epcas1p1.samsung.com>
 <1512029842-10939-1-git-send-email-ji.zhang@mediatek.com>
In-Reply-To: <1512029842-10939-1-git-send-email-ji.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ji Zhang <ji.zhang@mediatek.com>
Cc: linux-fbdev@vger.kernel.org, wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, shadanji@163.com, linux-arm-kernel@lists.infradead.org

On Thursday, November 30, 2017 04:17:22 PM Ji Zhang wrote:
> Since arm64 also has __raw I/O accessors, add __aarch64__ in fb.h.
> This is a supplement for commmit
> 981409b25e2a99409b26daa67293ca1cfd5ea0a0
> 
> Signed-off-by: Ji Zhang <ji.zhang@mediatek.com>

Patch queued for 4.16, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

