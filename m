From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 23 Jul 2019 15:35:04 +0000
Subject: Re: [PATCH] fbmem: remove redundant assignment to err
Message-Id: <72586381-9cf1-a401-b9bd-5705ebbaf937@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190624223730epcas2p4d2b1ad1200c11a472ba327ee39ede08b@epcas2p4.samsung.com>
 <20190624223724.13629-1-colin.king@canonical.com>
In-Reply-To: <20190624223724.13629-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Colin King <colin.king@canonical.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


On 6/25/19 12:37 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable err is initialized to a value that is never read and it
> is re-assigned later.  The initialization is redundant and can
> be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch queued for v5.4, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
