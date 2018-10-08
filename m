From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 08 Oct 2018 10:42:14 +0000
Subject: Re: [PATCH 1/2] fbdev: sbuslib: use checked version of put_user()
Message-Id: <20181008104215eucas1p24aa2afe494cfc35129b50bea1ac29ac8~bnBqSQr8g1047310473eucas1p2X@eucas1p2.samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180831080941epcas5p3135e290b0ce17e7a4117556715361d84@epcas5p3.samsung.com>
 <20180831080921.jstbxdkga3w2rnnf@kili.mountain>
In-Reply-To: <20180831080921.jstbxdkga3w2rnnf@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-fbdev@vger.kernel.org, Mathieu Malaterre <malat@debian.org>, kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org, Philippe Ombredanne <pombredanne@nexb.com>, Peter Malone <peter.malone@gmail.com>


On 08/31/2018 10:09 AM, Dan Carpenter wrote:
> I'm not sure why the code assumes that only the first put_user() needs
> an access_ok() check.  I have made all the put_user() and get_user()
> calls checked.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Patch queued for 4.20, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
