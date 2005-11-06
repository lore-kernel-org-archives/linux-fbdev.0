From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [2.6 patch] drivers/video/: possible cleanups
Date: Sun, 06 Nov 2005 13:56:03 +0800
Message-ID: <436D9AF3.8040008@pol.net>
References: <20051106005026.GE3668@stusta.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EYdVp-0002Pe-Jb
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 05 Nov 2005 21:56:17 -0800
Received: from xproxy.gmail.com ([66.249.82.199])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EYdVo-0005RQ-9Q
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 05 Nov 2005 21:56:17 -0800
Received: by xproxy.gmail.com with SMTP id h29so167779wxd
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 05 Nov 2005 21:56:14 -0800 (PST)
In-Reply-To: <20051106005026.GE3668@stusta.de>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch contains the possible cleanups including the following:
> - every file should #include the headers containing the prototypes for
>   it's global functions
> - make needlessly global functions static
> - kyro/STG4000Interface.h: #include video/kyro.h and linux/pci.h
>   instead of a manual "struct pci_dev"
> - i810_main.{c,h}: prototypes for static functions belong to the
>                    C file
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  drivers/video/arcfb.c                     |    8 +--
>  drivers/video/console/softcursor.c        |    2 
>  drivers/video/i810/i810-i2c.c             |    1 
>  drivers/video/i810/i810_accel.c           |    1 
>  drivers/video/i810/i810_gtf.c             |    1 
>  drivers/video/i810/i810_main.c            |   51 ++++++++++++++++++--
>  drivers/video/i810/i810_main.h            |   56 +---------------------
>  drivers/video/kyro/STG4000InitDevice.c    |    1 
>  drivers/video/kyro/STG4000Interface.h     |    3 -
>  drivers/video/kyro/STG4000OverlayDevice.c |    1 
>  drivers/video/matrox/matroxfb_g450.c      |    2 
>  drivers/video/nvidia/nv_hw.c              |    1 
>  drivers/video/tdfxfb.c                    |    2 
>  13 files changed, 68 insertions(+), 62 deletions(-)
> 
> --- linux-2.6.14-rc5-mm1-full/drivers/video/console/softcursor.c.old	2005-11-06 00:31:15.000000000 +0100
> +++ linux-2.6.14-rc5-mm1-full/drivers/video/console/softcursor.c	2005-11-06 00:31:30.000000000 +0100
> @@ -17,6 +17,8 @@
>  #include <asm/uaccess.h>
>  #include <asm/io.h>
>  
> +#include "fbcon.h"

I don't think softcursor needs anything in fbcon.h. The rest looks okay.

Tony



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
