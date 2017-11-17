From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 17 Nov 2017 16:03:36 +0000
Subject: Re: [PATCH] video: fbdev: sm501fb: fix potential null pointer dereference on fbi
Message-Id: <7500259.pPyNLB3SIs@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171110173236epcas4p2e31777c5a06270f2aed64110fedf0524@epcas4p2.samsung.com>
 <20171110173231.24598-1-colin.king@canonical.com>
In-Reply-To: <20171110173231.24598-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Colin King <colin.king@canonical.com>
Cc: linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

On Friday, November 10, 2017 05:32:31 PM Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The pointer fbi is dereferenced with par = fbi->par before there is a
> null check on fbi, hence there is a potential null pointer dereference
> on a null par.  Fix this by moving the dereference after the null
> pointer check.
> 
> Detected by CoverityScan, CID#1461301 ("Dereference before null check")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch queued for 4.15, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

