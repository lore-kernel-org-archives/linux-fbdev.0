From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 13 May 2013 00:49:45 +0000
Subject: Re: [PATCH 12/15] video: sh7760fb: remove unnecessary platform_set_drvdata()
Message-Id: <87k3n3n1p4.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <000c01ce4e47$03d37f80$0b7a7e80$@samsung.com>
In-Reply-To: <000c01ce4e47$03d37f80$0b7a7e80$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Hi

> The driver core clears the driver data to NULL after device_release
> or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
> (device-core: Ensure drvdata = NULL when no driver is bound).
> Thus, it is not needed to manually clear the device driver data to NULL.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
