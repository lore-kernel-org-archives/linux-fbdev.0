From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 02 May 2017 11:29:49 +0000
Subject: Re: [PATCH] m501fb: don't return zero on failure path in sm501fb_start()
Message-Id: <2764518.z4Gir5H5x7@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170429193354epcas1p49764e384389a15121894ef6a032b791f@epcas1p4.samsung.com>
        <1493494419-3917-1-git-send-email-khoroshilov@ispras.ru>
In-Reply-To: <1493494419-3917-1-git-send-email-khoroshilov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org

On Saturday, April 29, 2017 09:33:39 PM Alexey Khoroshilov wrote:
> If fbmem iomemory mapping failed, sm501fb_start() breaks off
> initialization, deallocates resources, but returns zero.
> As a result, double deallocation can happen in sm501fb_stop().
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Patch queued for 4.12, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

