From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 24 Jul 2018 15:53:09 +0000
Subject: Re: [PATCH] fbdev/via: fix defined but not used warning
Message-Id: <3875705.fRTUPnFDWq@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180707152941epcas3p4becbdaddbff49c7f77803a5b50f864c2@epcas3p4.samsung.com>
 <16ceee68-cead-0bfa-755c-d3e78ba0cfe3@infradead.org>
In-Reply-To: <16ceee68-cead-0bfa-755c-d3e78ba0cfe3@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

On Saturday, July 07, 2018 08:29:36 AM Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix a build warning in viafbdev.c when CONFIG_PROC_FS is not enabled
> by marking the unused function as __maybe_unused.
> 
> ../drivers/video/fbdev/via/viafbdev.c:1471:12: warning: 'viafb_sup_odev_proc_show' defined but not used [-Wunused-function]
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: dri-devel@lists.freedesktop.org

Patch queued for 4.19, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

