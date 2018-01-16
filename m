From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 16 Jan 2018 15:34:24 +0000
Subject: Re: [PATCH 1/2] video: udlfb: Constify read only data
Message-Id: <1604557.stkYAxyOku@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180115165946.GA20134@lenoch>
In-Reply-To: <20180115165946.GA20134@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Monday, January 15, 2018 05:59:46 PM Ladislav Michl wrote:
> Both dlfb_fix and fb_device_attrs are never written to, so
> it is safe to make them const.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

Patch queued for 4.16, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

