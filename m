From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 14 Jun 2017 10:04:38 +0000
Subject: Re: [PATCH] fbdev: avoid int-in-bool-context warning
Message-Id: <2548841.IeRW8m8BNP@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170511124723epcas2p15bf0763aae25607197e46d1918f6e4df@epcas2p1.samsung.com>
        <20170511124717.179251-1-arnd@arndb.de>
In-Reply-To: <20170511124717.179251-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday, May 11, 2017 02:47:01 PM Arnd Bergmann wrote:
> gcc-7 suspects this code might be wrong because we use the
> result of a multiplication as a bool:
> 
> drivers/video/fbdev/core/fbmon.c: In function 'fb_edid_add_monspecs':
> drivers/video/fbdev/core/fbmon.c:1051:84: error: '*' in boolean context, suggest '&&' instead [-Werror=int-in-bool-context]
> 
> It's actually fine, so let's add a comparison to zero to make
> that clear to the compiler too.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch queued for 4.12, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

