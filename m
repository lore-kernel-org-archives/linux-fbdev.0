From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 14 Jun 2017 10:19:38 +0000
Subject: Re: [PATCH] fbdev: via: remove possibly unused variables
Message-Id: <2570388.yn7rRtV55D@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170516112912epcas1p39fe29bd07d9f8ac978b3908992dc7cbf@epcas1p3.samsung.com>
        <20170516112906.4144714-1-arnd@arndb.de>
In-Reply-To: <20170516112906.4144714-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, May 16, 2017 01:28:57 PM Arnd Bergmann wrote:
> When CONFIG_PROC_FS is disabled, we get warnings about unused variables
> as remove_proc_entry() evaluates to an empty macro.
> 
> drivers/video/fbdev/via/viafbdev.c: In function 'viafb_remove_proc':
> drivers/video/fbdev/via/viafbdev.c:1635:4: error: unused variable 'iga2_entry' [-Werror=unused-variable]
> drivers/video/fbdev/via/viafbdev.c:1634:4: error: unused variable 'iga1_entry' [-Werror=unused-variable]
> 
> These are easy to avoid by using the pointer from the structure.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch queued for 4.12, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

