From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 18 Aug 2017 17:51:13 +0000
Subject: Re: [PATCH] video: fbdev: vt8623fb: constify vt8623_timing_regs
Message-Id: <1629225.J5Y5szTP3h@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170803195321epcas2p22165d98ea90602f4b22233f35b36e30e@epcas2p2.samsung.com>
        <1501788459-32425-1-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1501788459-32425-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Bhumika Goyal <bhumirks@gmail.com>

On Thursday, August 03, 2017 09:27:39 PM Julia Lawall wrote:
> vt8623_timing_regs is only passed as the first argument to
> svga_check_timings and as the second argument to svga_set_timings,
> both of which are const.  So make vt8623_timing_regs const also.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Patch queued for 4.14, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

