From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 21 Aug 2017 14:32:21 +0000
Subject: Re: [PATCH 2/2] fbdev: i810: make fb_ops const
Message-Id: <1777066.i5Q9u2EM1I@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1502356605-20801-1-git-send-email-bhumirks@gmail.com>
        <CGME20170810091734epcas5p13a98b2d414302ef959819cf9da4e8fcd@epcas5p1.samsung.com>
        <1502356605-20801-3-git-send-email-bhumirks@gmail.com>
In-Reply-To: <1502356605-20801-3-git-send-email-bhumirks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, adaplas@gmail.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday, August 10, 2017 02:46:45 PM Bhumika Goyal wrote:
> Make the structure const as it is only used during a copy operation.
> Done using Coccinelle.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Patch queued for 4.14, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

