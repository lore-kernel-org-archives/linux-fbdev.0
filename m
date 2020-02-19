From: Paul Burton <paulburton@kernel.org>
Date: Wed, 19 Feb 2020 19:03:52 +0000
Subject: Re: [PATCH v2 0/3] Improve MIPS Magnum support
Message-Id: <5e4d869d.1c69fb81.aa02.151b@mx.google.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1581030073.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1581030073.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Finn Thain <fthain@telegraphics.com.au>
Cc: linux-fbdev@vger.kernel.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Burton <paulburton@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, =?utf-8?q?Philippe_Math?= =?utf-8?q?ieu-Daud=C3=A9?= <f4bug@amsat.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

Hello,

Finn Thain wrote:
> A few minor patches are needed to more easily boot a MIPS Magnum build
> under QEMU. This series fixes a build failure in the g364fb driver and
> modifies jazz_defconfig for use with 'qemu-system-mips64el -M magnum'.
> 
> Note that QEMU's dp8393x implementation has bugs, one of which prevents
> the Linux jazzsonic driver from probing the chip. I have fixed the bugs
> that I know of in a series of patches at,
> https://github.com/fthain/qemu/commits/sonic
> 
> Changed since v1:
>  - Added reviewed-by and tested-by tags from Philippe Mathieu-Daudé.
>  - Rebased.
> 
> 
> Finn Thain (3):
>   fbdev/g364fb: Fix build failure
>   mips/jazz: Remove redundant settings and shrink jazz_defconfig
>   mips/jazz: Update jazz_defconfig for MIPS Magnum

Series applied to mips-next.

> fbdev/g364fb: Fix build failure
>   commit c584f9532115
>   https://git.kernel.org/mips/c/c584f9532115
>   
>   Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>   Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>   Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
>   Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>   Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>   Signed-off-by: Paul Burton <paulburton@kernel.org>
> 
> mips/jazz: Remove redundant settings and shrink jazz_defconfig
>   commit a7047b8dd098
>   https://git.kernel.org/mips/c/a7047b8dd098
>   
>   Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>   Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
>   Signed-off-by: Paul Burton <paulburton@kernel.org>
> 
> mips/jazz: Update jazz_defconfig for MIPS Magnum
>   commit 91f40e896444
>   https://git.kernel.org/mips/c/91f40e896444
>   
>   Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>   Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>   Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
>   Signed-off-by: Paul Burton <paulburton@kernel.org>

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paulburton@kernel.org to report it. ]
