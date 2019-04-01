From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 01 Apr 2019 11:59:32 +0000
Subject: Re: [PATCH 0/4] fbdev: atafb: Fix after kexec, misc. cleanups
Message-Id: <819fd7b8-20d0-1adf-ce8c-8104994901ff@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190215085951epcas3p184e61f75bec825fb68681a36867da7f1@epcas3p1.samsung.com>
 <20190215085901.21479-1-geert@linux-m68k.org>
In-Reply-To: <20190215085901.21479-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-fbdev@vger.kernel.org, linux-m68k@vger.kernel.org, dri-devel@lists.freedesktop.org


On 02/15/2019 09:58 AM, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This patch series fixes the frame buffer on Atari Falcon when using
> kexec while blanked, and does some miscellaneous cleanups.
> 
> This has been tested on ARAnyM.
> 
> Thanks!
> 
> Geert Uytterhoeven (4):
>   fbdev: atafb: Stop printing virtual screen_base
>   fbdev: atafb: Remove obsolete module support
>   fbdev: atafb: Fix broken frame buffer after kexec
>   fbdev: atafb: Modernize printing of kernel messages
> 
>  drivers/video/fbdev/atafb.c          | 67 +++++++++++++++++-----------
>  drivers/video/fbdev/atafb_iplan2p2.c | 23 ----------
>  drivers/video/fbdev/atafb_iplan2p4.c | 23 ----------
>  drivers/video/fbdev/atafb_iplan2p8.c | 23 ----------
>  drivers/video/fbdev/atafb_mfb.c      | 23 ----------
>  5 files changed, 40 insertions(+), 119 deletions(-)

Patches #1-4 queued for v5.2, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
