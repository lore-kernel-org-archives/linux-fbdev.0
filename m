From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 07 Aug 2017 15:11:48 +0000
Subject: Re: [PATCH] fbdev: matrox: hide unused 'hotplug' variable
Message-Id: <3387426.dX5mCNm2tR@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170802093751epcas3p4c7955b185ba3a2e39c230da58de3e9e0@epcas3p4.samsung.com>
        <20170802093722.3666961-1-arnd@arndb.de>
In-Reply-To: <20170802093722.3666961-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Dan Carpenter <dan.carpenter@oracle.com>, Sean Paul <seanpaul@chromium.org>, Arvind Yadav <arvind.yadav.cs@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, August 02, 2017 11:36:47 AM Arnd Bergmann wrote:
> The variable has become unused in modular configurations
> which triggers a harmless warning:
> 
> drivers/video/fbdev/matrox/matroxfb_base.c:1583:12: error: 'hotplug' defined but not used [-Werror=unused-variable]
> 
> This moves it into an #ifdef section of the file, matching
> all its references.
> 
> Fixes: 376b3ff54c9a ("fbdev: Nuke FBINFO_MODULE")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch queued for 4.14, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

