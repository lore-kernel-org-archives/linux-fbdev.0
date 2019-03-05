From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 05 Mar 2019 11:36:06 +0000
Subject: Re: [PATCH] fbdev: mbx: fix a misspelled variable name
Message-Id: <3568c648-2ef2-bd25-7918-3599b140f035@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190304195258epcas2p40c27a5bdcea32c4f03dfea58abc4cde8@epcas2p4.samsung.com>
        <20190304195249.971696-1-arnd@arndb.de>
In-Reply-To: <20190304195249.971696-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


On 03/04/2019 08:52 PM, Arnd Bergmann wrote:
> A recent cleanup introduced a build failure when a variable
> was spelled incorrectly:
> 
> In file included from drivers/video/fbdev/mbx/mbxfb.c:881:
> drivers/video/fbdev/mbx/mbxdebugfs.c: In function 'mbxfb_debugfs_init':
> drivers/video/fbdev/mbx/mbxdebugfs.c:217:2: error: 'mbfi' undeclared (first use in this function); did you mean 'mfbi'?
>   mbfi->debugfs_dir = dir;
>   ^~~~
>   mfbi
> drivers/video/fbdev/mbx/mbxdebugfs.c:217:2: note: each undeclared identifier is reported only once for each function it appears in
> drivers/video/fbdev/mbx/mbxdebugfs.c:213:21: error: unused variable 'mfbi' [-Werror=unused-variable]
>   struct mbxfb_info *mfbi = fbi->par;
>                      ^~~~
> 
> Fixes: 72aed9e31344 ("fbdev: mbx: fix up debugfs file creation")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch queued for v5.1, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
