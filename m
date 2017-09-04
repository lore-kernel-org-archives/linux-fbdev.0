From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 04 Sep 2017 12:59:46 +0000
Subject: Re: [PATCH] video: ARM CLCD: constify amba_id
Message-Id: <12336489.qVb3ILOcGD@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170823172539epcas2p4bf9c8256b20d614907bc572c0bf60926@epcas2p4.samsung.com>
        <b142bfffbda07fe20b845161aebc0472edf21cbe.1503509038.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <b142bfffbda07fe20b845161aebc0472edf21cbe.1503509038.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: linux@armlinux.org.uk, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Wednesday, August 23, 2017 10:55:26 PM Arvind Yadav wrote:
> amba_id are not supposed to change at runtime. All functions
> working with const amba_id. So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Patch queued for 4.14, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

