From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 14 Jun 2017 13:28:18 +0000
Subject: Re: [PATCH 1/3] mdacon: align code in mda_detect properly
Message-Id: <1768744.2ZqNpAST7L@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170512080804.2508-1-jslaby@suse.cz>
        <CGME20170614132820epcas1p32f19f6899a8ec80379799506133005f0@epcas1p3.samsung.com>
In-Reply-To: <20170512080804.2508-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiri Slaby <jslaby@suse.cz>
Cc: dri-devel@lists.freedesktop.org, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday, May 12, 2017 10:08:02 AM Jiri Slaby wrote:
> This is just a whitespace cleanup. The code was a mess having multiple
> commands on one line like:
> scr_writew(0xAA55, p); if (scr_readw(p) = 0xAA55) count++;
> 
> Indent that properly and make it nicer for reading.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: <linux-fbdev@vger.kernel.org>

Patch queued for 4.13, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

