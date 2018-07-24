From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 24 Jul 2018 15:01:34 +0000
Subject: Re: [PATCH 1/4] video: fbdev: pxafb: clear allocated memory for video modes
Message-Id: <1996075.k5CAVnid5i@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180624153827epcas3p37952be3cd47f8a63e7083fc88e83fe1e@epcas3p3.samsung.com>
 <20180624153817.24387-1-daniel@zonque.org>
In-Reply-To: <20180624153817.24387-1-daniel@zonque.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Mack <daniel@zonque.org>
Cc: linux-fbdev@vger.kernel.org, tomi.valkeinen@ti.com, robert.jarzmik@free.fr, dri-devel@lists.freedesktop.org

On Sunday, June 24, 2018 05:38:14 PM Daniel Mack wrote:
> When parsing the video modes from DT properties, make sure to zero out
> memory before using it. This is important because not all fields in the mode
> struct are explicitly initialized, even though they are used later on.
> 
> Fixes: 420a488278e86 (video: fbdev: pxafb: initial devicetree conversion)
> Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Signed-off-by: Daniel Mack <daniel@zonque.org>

Patch queued for 4.19, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

