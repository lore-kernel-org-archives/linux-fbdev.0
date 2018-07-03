From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 03 Jul 2018 14:32:44 +0000
Subject: Re: [PATCH] omapfb: encoder-tpd12s015: fix error return code
Message-Id: <2458818.0lnoAlLxQ2@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180610145623epcas2p38562cc47b619add45620b677fb036479@epcas2p3.samsung.com>
 <1528640655-18948-1-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1528640655-18948-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org

On Sunday, June 10, 2018 04:24:13 PM Julia Lawall wrote:
> Return an error code on failure.
> 
> Problem found using Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Patch queued for 4.19, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

