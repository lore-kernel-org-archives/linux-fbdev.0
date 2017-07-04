From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 04 Jul 2017 15:29:11 +0000
Subject: Re: [PATCH] video: fbdev: matrox: the list iterator can't be NULL
Message-Id: <7422018.lga753Zp0e@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Friday, June 30, 2017 11:00:30 AM Dan Carpenter wrote:
> My static checker is complaining because we check "drv" for NULL and
> then we dereference it to get the next item in the list.  It can't be
> NULL so we can remove this check.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Patch queued for 4.13, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

