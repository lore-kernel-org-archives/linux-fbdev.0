From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 19 Aug 2019 14:02:51 +0000
Subject: Re: [PATCH] video: fbdev: aty: Use dev_get_drvdata
Message-Id: <e9d8fe12-e415-19b3-5c84-2927e26de1ec@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190724131908epcas2p473bd151e9c12b90d6dc9c4a39b522e3a@epcas2p4.samsung.com>
 <20190724131900.2039-1-hslester96@gmail.com>
In-Reply-To: <20190724131900.2039-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chuhong Yuan <hslester96@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


On 7/24/19 3:19 PM, Chuhong Yuan wrote:
> Instead of using to_pci_dev + pci_get_drvdata,
> use dev_get_drvdata to make code simpler.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Patch queued for v5.4, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
