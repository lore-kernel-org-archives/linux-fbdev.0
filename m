From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 19 Aug 2019 14:02:23 +0000
Subject: Re: [PATCH] fbdev: sm712fb: Use dev_get_drvdata
Message-Id: <a7de5851-1b7c-bab5-4e3a-4d1fd5f6b65e@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190724131753epcas2p421536b8d2d873766882bea0e3ea4f351@epcas2p4.samsung.com>
        <20190724131744.1709-1-hslester96@gmail.com>
In-Reply-To: <20190724131744.1709-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chuhong Yuan <hslester96@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org


On 7/24/19 3:17 PM, Chuhong Yuan wrote:
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
