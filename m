From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 20 Dec 2018 17:37:56 +0000
Subject: Re: [PATCH 1/2] fbdev: fbmem: make fb_show_logo_line return the end instead of the height
Message-Id: <a4130c72-a9db-18d4-aea4-ccebed91b85d@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181126215725.2548-1-peda@axentia.se>
        <CGME20181126215801epcas4p3216f5eb0dda773f3a0ea16ee581a318e@epcas4p3.samsung.com>
        <20181126215725.2548-2-peda@axentia.se>
In-Reply-To: <20181126215725.2548-2-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Rosin <peda@axentia.se>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>


On 11/26/2018 10:57 PM, Peter Rosin wrote:
> In preparation for allowing centering of the bootup logo, make
> fb_show_logo_line return where the next free framebuffer line is,
> instead of returning the height of the shown logo.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

Patch queued for 4.21, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
