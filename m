From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 24 Jul 2018 15:41:17 +0000
Subject: Re: [PATCH] video: goldfishfb: fix memory leak on driver remove
Message-Id: <2385463.SiM69ykDI2@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180706120501epcas5p3a2db5a74c3b4b0d2c8e102fbe3943de6@epcas5p3.samsung.com>
        <20180706120422.14628-1-vasilyev@ispras.ru>
In-Reply-To: <20180706120422.14628-1-vasilyev@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anton Vasilyev <vasilyev@ispras.ru>
Cc: Aleksandar Markovic <aleksandar.markovic@mips.com>, Miodrag Dinic <miodrag.dinic@mips.com>, Goran Ferenc <goran.ferenc@mips.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org

On Friday, July 06, 2018 03:04:22 PM Anton Vasilyev wrote:
> goldfish_fb_probe() allocates memory for fb, but goldfish_fb_remove() does
> not have deallocation of fb, which leads to memory leak on probe/remove.
> 
> The patch adds deallocation into goldfish_fb_remove().
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>

Patch queued for 4.19, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

