From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 18 Aug 2017 17:24:20 +0000
Subject: Re: [PATCH] fbdev: fix 1bpp logo for unusual width
Message-Id: <3724763.2PmRKLHeP2@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170728203405epcas5p3c58c5c8d751b74f94f73520a8108358b@epcas5p3.samsung.com>
        <1501274033-6978-1-git-send-email-david@lechnology.com>
In-Reply-To: <1501274033-6978-1-git-send-email-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Lechner <david@lechnology.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday, July 28, 2017 03:33:53 PM David Lechner wrote:
> This check is needed in the case where the width of the framebuffer
> is not a multiple of 8 pixels. For example, LEGO MINDSTORMS EV3 has
> a 178x128 1bpp display.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Patch queued for 4.14, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

