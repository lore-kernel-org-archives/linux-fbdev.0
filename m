From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 21 Aug 2017 13:56:41 +0000
Subject: Re: [PATCH 1/2] video: fbdev: smscufx: constify usb_device_id.
Message-Id: <1946554.UFesz4xRPs@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1502003368-12355-1-git-send-email-arvind.yadav.cs@gmail.com>
        <CGME20170806070944epcas4p123a7c8faf0d1cf97a5b3870ffd420778@epcas4p1.samsung.com>
        <1502003368-12355-2-git-send-email-arvind.yadav.cs@gmail.com>
In-Reply-To: <1502003368-12355-2-git-send-email-arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: steve.glendinning@shawell.net, bernie@plugable.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday, August 06, 2017 12:39:27 PM Arvind Yadav wrote:
> usb_device_id are not supposed to change at runtime. All functions
> working with usb_device_id provided by <linux/usb.h> work with
> const usb_device_id. So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Patch queued for 4.14, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

