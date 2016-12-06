From: Ley Foon Tan <ley.foon.tan@intel.com>
Date: Tue, 06 Dec 2016 03:29:12 +0000
Subject: Re: [PATCH] video: vgacon: disable vgacon on nios2
Message-Id: <1480994952.18996.5.camel@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161128124850.14383-1-tklauser@distanz.ch>
In-Reply-To: <20161128124850.14383-1-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On Isn, 2016-11-28 at 13:48 +0100, Tobias Klauser wrote:
> The allyesconfig/allmodconfig build currently fails on nios2 with the
> following linker error:
> 
> drivers/built-in.o: In function `vgacon_switch':
> vgacon.c:(.text+0x34750): undefined reference to `screen_info'
> vgacon.c:(.text+0x34758): undefined reference to `screen_info'
> drivers/built-in.o: In function `vgacon_resize':
> vgacon.c:(.text+0x349b4): undefined reference to `screen_info'
> vgacon.c:(.text+0x349b8): undefined reference to `screen_info'
> drivers/built-in.o: In function `vgacon_save_screen':
> vgacon.c:(.text+0x34ae8): undefined reference to `screen_info'
> drivers/built-in.o:vgacon.c:(.text+0x34aec): more undefined
> references to `screen_info' follow
> 
> Since the nios2 architecture doesn't define the screen_info symbol.
> 
> Fix it by disabling VGA console for nios2.
> 
> Cc: Ley Foon Tan <lftan@altera.com>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
Hi Tobias

Sudip sent this patch in early November before to add screen_info in
nios2. However, I don't have hardware to test the settings used in this
patch is working or not. We only need either one of these 2 patches. Do
you have any comment?
https://patchwork.kernel.org/patch/9420315/

Regards
Ley Foon

> ---
>  drivers/video/console/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/console/Kconfig
> b/drivers/video/console/Kconfig
> index 38da6e299149..f63a022689b5 100644
> --- a/drivers/video/console/Kconfig
> +++ b/drivers/video/console/Kconfig
> @@ -9,7 +9,7 @@ config VGA_CONSOLE
>         depends on !4xx && !8xx && !SPARC && !M68K && !PARISC && !FRV
> && \
>                 !SUPERH && !BLACKFIN && !AVR32 && !MN10300 && !CRIS
> && \
>                 (!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR ||
> ARCH_NETWINDER) && \
> -               !ARM64 && !ARC && !MICROBLAZE
> +               !ARM64 && !ARC && !MICROBLAZE && !NIOS2
>         default y
>         help
>           Saying Y here will allow you to use Linux in text mode
> through a
> --
> 2.11.0.rc0.7.gbe5a750
> 
> 
> 
> ________________________________
> 
> Confidentiality Notice.
> This message may contain information that is confidential or
> otherwise protected from disclosure. If you are not the intended
> recipient, you are hereby notified that any use, disclosure,
> dissemination, distribution, or copying of this message, or any
> attachments, is strictly prohibited. If you have received this
> message in error, please advise the sender by reply e-mail, and
> delete the message and any attachments. Thank you.
