From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 17 Nov 2017 16:21:14 +0000
Subject: Re: [PATCH] OMAPFB: prevent buffer underflow in omapfb_parse_vram_param()
Message-Id: <2414894.T1ou5hczcE@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171114061251epcas2p3eea18fd03e87cefd3d7b30750a0f1833@epcas2p3.samsung.com>
 <20171114061228.iv5irewl6ougl4zm@mwanda>
In-Reply-To: <20171114061228.iv5irewl6ougl4zm@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On Tuesday, November 14, 2017 09:12:28 AM Dan Carpenter wrote:
> We cap the upper bound of "fbnum" but we also need to check for
> negatives or make the type unsigned.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Patch queued for 4.15, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

