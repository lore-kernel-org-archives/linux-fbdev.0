From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 04 Sep 2017 13:04:27 +0000
Subject: Re: [PATCH] fbcon: remove restriction on margin color
Message-Id: <1884938.EAvpoJ61mR@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170823191907epcas4p4f5ba212776ffd4d5d5629bc48dc13eb0@epcas4p4.samsung.com>
        <1503515933-8045-1-git-send-email-david@lechnology.com>
In-Reply-To: <1503515933-8045-1-git-send-email-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Lechner <david@lechnology.com>
Cc: linux-fbdev@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org

On Wednesday, August 23, 2017 02:18:53 PM David Lechner wrote:
> This removes the restriction on the value range of the fbcon=margin:
> parameter. The color value really depends on the driver being used.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Patch queued for 4.14, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

