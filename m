From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 12 Mar 2018 14:26:32 +0000
Subject: Re: [PATCH] video: fbdev: sis: avoid mismatched prototypes
Message-Id: <80049144.V4PLGzs4dk@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180202150152epcas1p2f5bae6daf58da50e78af5ea7f5525e63@epcas1p2.samsung.com>
        <20180202150114.299409-1-arnd@arndb.de>
In-Reply-To: <20180202150114.299409-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Winischhofer <thomas@winischhofer.net>, Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday, February 02, 2018 04:00:48 PM Arnd Bergmann wrote:
> Building with LTO enabled reveals some functions whose prototypes
> in the header are different from the definition:
> 
> drivers/video/fbdev/sis/sis_main.h:765:0: error: type of 'SiS_SetCH70xxANDOR' does not match original declaration [-Werror=lto-type-mismatch]
>  extern void  SiS_SetCH70xxANDOR(struct SiS_Private *SiS_Pr, unsigned short reg,
> 
> drivers/video/fbdev/sis/init301.c:8937:0: note: type mismatch in parameter 4
>  SiS_SetCH70xxANDOR(struct SiS_Private *SiS_Pr, unsigned short reg,
> 
> drivers/video/fbdev/sis/init301.c:8937:0: note: type 'short unsigned int' should match type 'unsigned char'
> drivers/video/fbdev/sis/init301.c:8937:0: note: 'SiS_SetCH70xxANDOR' was previously declared here
> 
> The root cause appears to be the way that header files are used in this
> driver, where they contain both static variable and declarations for
> symbols in other files.
> 
> To clean that up, I'm changing all mixed headers to only contain
> declarations the way we normally do in C, or contain only static
> variables, and move the rest to a more appropriate place.  Once that
> is done, the headers can be included in the other files as well, and
> guarantee that the prototypes match.
> 
> There are a few headers that now only contain static variables, and
> I'm leaving those alone here as the patch is already too big. These
> could be trivially moved into the respective .c files.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

