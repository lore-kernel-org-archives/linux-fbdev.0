From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 14 Jun 2017 13:29:25 +0000
Subject: Re: [PATCH 3/3] mdacon: replace MDA_ADDR macro by inline function
Message-Id: <2877114.cEPvJS5kDY@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170512080804.2508-1-jslaby@suse.cz>
        <20170512080804.2508-3-jslaby@suse.cz>
        <CGME20170614132927epcas1p311aa2291f0d36ce0691955287c9af3a2@epcas1p3.samsung.com>
In-Reply-To: <20170512080804.2508-3-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiri Slaby <jslaby@suse.cz>
Cc: tomi.valkeinen@ti.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Friday, May 12, 2017 10:08:04 AM Jiri Slaby wrote:
> MDA_ADDR is one of those macros which could be an inline function. So
> convert MDA_ADDR to mda_addr.
> 
> Note that we take x and y as unsigned now. But they are absolute
> coordinates, so this is no problem.
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

