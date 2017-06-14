From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 14 Jun 2017 13:48:19 +0000
Subject: Re: [PATCH] video: fbdev: omap2: omapfb: displays: panel-dsi-cm: Use time comparison kernel macro.
Message-Id: <3422682.9ua2BuFz3Q@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170515191442epcas5p32579d3f083abfeb3a329a25de53e6acc@epcas5p3.samsung.com>
        <1494875666-4109-1-git-send-email-karim.eshapa@gmail.com>
In-Reply-To: <1494875666-4109-1-git-send-email-karim.eshapa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Karim Eshapa <karim.eshapa@gmail.com>
Cc: tomi.valkeinen@ti.com, peter.ujfalusi@ti.com, tj@kernel.org, mingo@kernel.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, May 15, 2017 09:14:26 PM Karim Eshapa wrote:
> Use time_before_eq() kernel macro for
> time comparison more safe.
> 
> Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>

Patch queued for 4.13, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

