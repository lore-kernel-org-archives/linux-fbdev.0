From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 04 Sep 2017 13:32:32 +0000
Subject: Re: [PATCH] video: fbdev: aty: do not leak uninitialized padding in clk to userspace
Message-Id: <2710268.UQ4S50vCLC@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170829135015epcas3p2c8daeacf3b6b2960cf13f225231b19c2@epcas3p2.samsung.com>
        <20170829135004.5739-1-vdronov@redhat.com>
In-Reply-To: <20170829135004.5739-1-vdronov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vladis Dronov <vdronov@redhat.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, August 29, 2017 03:50:04 PM Vladis Dronov wrote:
> 'clk' is copied to a userland with padding byte(s) after 'vclk_post_div'
> field unitialized, leaking data from the stack. Fix this ensuring all of
> 'clk' is initialized to zero.
> 
> References: https://github.com/torvalds/linux/pull/441
> Reported-by: sohu0106 <sohu0106@126.com>
> Signed-off-by: Vladis Dronov <vdronov@redhat.com>

Patch queued for 4.14, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

