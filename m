From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 04 Sep 2017 12:47:15 +0000
Subject: Re: [PATCH] video: fm2fb: constify zorro_device_id
Message-Id: <11489231.Ik3V9PHcY1@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170822181806epcas1p402a52d6fa3b22d5609d2b1ffe9d1f080@epcas1p4.samsung.com>
        <e530300dd132c9567ea6f7e8c6b923ed4dfb35a0.1503425803.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <e530300dd132c9567ea6f7e8c6b923ed4dfb35a0.1503425803.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Tuesday, August 22, 2017 11:47:48 PM Arvind Yadav wrote:
> zorro_device_id are not supposed to change at runtime. All functions
> working with zorro_device_id provided by <linux/zorro.h> work with
> const zorro_device_id. So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Patch queued for 4.14, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

