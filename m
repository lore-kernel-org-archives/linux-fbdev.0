From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 21 Aug 2017 14:30:32 +0000
Subject: Re: [PATCH 1/2] fbdev: matrox: make fb_ops const
Message-Id: <5531209.O4ATZQobuh@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1502356605-20801-1-git-send-email-bhumirks@gmail.com>
        <CGME20170810091708epcas2p49fd58c5e0825e73dc648a54b4eed0df3@epcas2p4.samsung.com>
        <1502356605-20801-2-git-send-email-bhumirks@gmail.com>
In-Reply-To: <1502356605-20801-2-git-send-email-bhumirks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, adaplas@gmail.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday, August 10, 2017 02:46:44 PM Bhumika Goyal wrote:
> Make fb_ops const as it is only used during a copy operation.
> Done using Coccinelle.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Patch queued for 4.14, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

