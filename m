From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 18 Jun 2018 06:42:20 +0000
Subject: Re: [PATCH 1/2] efi/bgrt: Drop __initdata from bgrt_image_size
Message-Id: <CAKv+Gu-DVXti+02CZh9ZxW3wZeR2Kgw=6gAsvL_W7V0TO0vLDQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180617153235.16219-1-hdegoede@redhat.com>
 <20180617153235.16219-2-hdegoede@redhat.com>
In-Reply-To: <20180617153235.16219-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>, linux-efi <linux-efi@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On 17 June 2018 at 17:32, Hans de Goede <hdegoede@redhat.com> wrote:
> bgrt_image_size is necessary to (optionally) show the boot graphics from
> the efifb code. The efifb driver is a platform driver, using a normal
> driver probe() driver callback. So even though it is always builtin it
> cannot reference __initdata.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  drivers/firmware/efi/efi-bgrt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/efi-bgrt.c b/drivers/firmware/efi/efi-bgrt.c
> index 50793fda7819..b22ccfb0c991 100644
> --- a/drivers/firmware/efi/efi-bgrt.c
> +++ b/drivers/firmware/efi/efi-bgrt.c
> @@ -20,7 +20,7 @@
>  #include <linux/efi-bgrt.h>
>
>  struct acpi_table_bgrt bgrt_tab;
> -size_t __initdata bgrt_image_size;
> +size_t bgrt_image_size;
>
>  struct bmp_header {
>         u16 id;
> --
> 2.17.1
>
