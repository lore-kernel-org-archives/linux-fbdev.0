From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 12 Mar 2018 14:13:11 +0000
Subject: Re: [PATCH] video: remove unused kconfig SH_LCD_MIPI_DSI
Message-Id: <3051452.cQdIOQBJIn@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180122123705epcas3p48a62b38bd5358d3335a2a85ff7e5b131@epcas3p4.samsung.com>
 <20180122123500.12359-1-clabbe.montjoie@gmail.com>
In-Reply-To: <20180122123500.12359-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Monday, January 22, 2018 01:35:00 PM Corentin Labbe wrote:
> SH_LCD_MIPI_DSI is unused since commit 18b6562c243f ("fbdev: sh_mipi_dsi: remove driver")
> So no need to keep it.
> Fixes: 18b6562c243f ("fbdev: sh_mipi_dsi: remove driver")
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

