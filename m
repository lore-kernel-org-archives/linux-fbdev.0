From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 12 Mar 2018 14:41:28 +0000
Subject: Re: [PATCH 1/2] video: udlfb: Fix unaligned access
Message-Id: <49063812.jVSPE6ElVW@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180206200846epcas1p489416383baf34280bb1e7981496db76e@epcas1p4.samsung.com>
 <20180206200838.GA10897@lenoch>
In-Reply-To: <20180206200838.GA10897@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-fbdev@vger.kernel.org, Bernie Thompson <bernie@plugable.com>, dri-devel@lists.freedesktop.org

On Tuesday, February 06, 2018 09:08:38 PM Ladislav Michl wrote:
> Driver generates lots of alignment trap exceptions on ARM.
> Fix that by replacing typecasting of odd addresses with
> byte shifting and remove uneccessary typecasting.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

