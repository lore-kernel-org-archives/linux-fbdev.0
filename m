From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 19 Aug 2019 14:10:35 +0000
Subject: Re: [PATCH] udlfb: Make dlfb_ops constant
Message-Id: <7def8a0f-b634-ba89-0f01-476c37e9a27d@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190819075250epcas3p207fe8748142f91b3d2d7df7c0803ed2e@epcas3p2.samsung.com>
 <20190819075236.1051-1-nishkadg.linux@gmail.com>
In-Reply-To: <20190819075236.1051-1-nishkadg.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc: linux-fbdev@vger.kernel.org, bernie@plugable.com, dri-devel@lists.freedesktop.org


On 8/19/19 9:52 AM, Nishka Dasgupta wrote:
> Static structure dlfb_ops, of type fb_ops, is not used except to be
> copied into another variable. Hence make dlfb_ops constant to protect it
> from unintended modification.
> Issue found with Coccinelle.
> 
> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
Patch queued for v5.4, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
