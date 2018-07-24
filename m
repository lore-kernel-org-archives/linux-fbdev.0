From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 24 Jul 2018 16:58:19 +0000
Subject: Re: [PATCH] omapfb: encoder-tpd12s015: remove redundant pointer 'in'
Message-Id: <7824518.4rCHaMUqme@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180720185219epcas1p2542795dbad64a8343ce7e9eff8dd7cce@epcas1p2.samsung.com>
 <20180720185213.3085-1-colin.king@canonical.com>
In-Reply-To: <20180720185213.3085-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Colin King <colin.king@canonical.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Friday, July 20, 2018 07:52:13 PM Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer 'in' is being assigned but is never used hence it is
> redundant and can be removed.
> 
> Cleans up clang warning:
> warning: variable 'in' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch queued for 4.19, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

