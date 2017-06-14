From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 14 Jun 2017 10:23:22 +0000
Subject: Re: [PATCH v2] video: fbdev: udlfb: drop log level for blanking
Message-Id: <1812727.iHiPExx227@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170607214255.GA37736@google.com>
In-Reply-To: <20170607214255.GA37736@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wednesday, June 07, 2017 05:42:55 PM Mike Gerow wrote:
> Drop log level for blanking from info to debug. Xorg likes to habitually
> unblank when already unblanked and this can fill up logs over a long period
> of time.
> 
> Signed-off-by: Mike Gerow <gerow@google.com>

Patch queued for 4.12, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

