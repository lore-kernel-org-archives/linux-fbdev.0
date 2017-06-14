From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 14 Jun 2017 13:28:57 +0000
Subject: Re: [PATCH 2/3] mdacon: make mda_vram_base u16 *
Message-Id: <1519838.mppWii43AC@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170512080804.2508-1-jslaby@suse.cz>
        <20170512080804.2508-2-jslaby@suse.cz>
        <CGME20170614132859epcas1p3f3db84642709f6ae79e4ca495a4c8ebe@epcas1p3.samsung.com>
In-Reply-To: <20170512080804.2508-2-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiri Slaby <jslaby@suse.cz>
Cc: dri-devel@lists.freedesktop.org, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday, May 12, 2017 10:08:03 AM Jiri Slaby wrote:
> Given every user of mda_vram_base expects a pointer, let
> mda_vram_base be a pointer to u16.
> 
> The offset calculation in mda_detect had to be adjusted by / 2 (due to
> different pointer arithmetic now).
> 
> We introduce a cast to a value returned from VGA_MAP_MEM. But I will
> change VGA_MAP_MEM to return a pointer later too. But vgacon needs a
> similar change first.
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

