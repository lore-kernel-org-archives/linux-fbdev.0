From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 31 Jul 2017 16:34:51 +0000
Subject: Re: [PATCH v2] video: fbdev: imxfb: use after free in imxfb_remove()
Message-Id: <4863560.yoqePqXAJE@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170713075314.qeywcgswbrrvzjza@mwanda>
In-Reply-To: <20170713075314.qeywcgswbrrvzjza@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thursday, July 13, 2017 10:53:14 AM Dan Carpenter wrote:
> We free "info" then dereference it on the next line.  Really this whole
> function would be better if we wrote it to unwind in the mirror of how
> things are allocated in the probe.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Patch queued for 4.13, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

