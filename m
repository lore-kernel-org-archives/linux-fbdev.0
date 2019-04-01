From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 01 Apr 2019 13:01:46 +0000
Subject: Re: [PATCH] omapfb: Fix potential NULL pointer dereference in kmalloc
Message-Id: <d9416512-1daf-252d-409c-5826445510b0@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190302204019epcas2p39a9b9bc29383567d5442fcb3a7efaeed@epcas2p3.samsung.com>
 <20190302204006.9953-1-pakki001@umn.edu>
In-Reply-To: <20190302204006.9953-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Aditya Pakki <pakki001@umn.edu>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, kjlu@umn.edu, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


On 03/02/2019 09:40 PM, Aditya Pakki wrote:
> Memory allocated, using kmalloc, for new_compat may fail. This patch
> checks for such an error and prevents potential NULL pointer
> dereference.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Patch queued for v5.2, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
