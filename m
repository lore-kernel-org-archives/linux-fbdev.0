From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 24 Jul 2018 15:29:48 +0000
Subject: Re: [PATCH] video: fbdev: metronomefb: fix some off by one bugs
Message-Id: <2465673.hg9hjHzv6E@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180703122830epcas5p19c5ec248b138aafdb0c6f156ef3d8aca@epcas5p1.samsung.com>
 <20180703122813.hb75xlkxybogqpoq@kili.mountain>
In-Reply-To: <20180703122813.hb75xlkxybogqpoq@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org

On Tuesday, July 03, 2018 03:28:13 PM Dan Carpenter wrote:
> The "mem" buffer has "size" bytes.  The ">" should be ">=" to prevent
> reading one character beyond the end of the array.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Patch queued for 4.19, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

