From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sat, 12 Nov 2011 00:20:23 +0000
Subject: Re: [PATCH 1/4] zorro: Rename Picasso IV Z2 "MEM" to "RAM" for consistency
Message-Id: <4EBDBBC7.1010207@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1319110945-25684-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1319110945-25684-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev@vger.kernel.org, linux-m68k@vger.kernel.org, "Christian T. Steigies" <cts@debian.org>, linux-kernel@vger.kernel.org, =?ISO-8859-1?Q?Ingo_J=FCrgensmann?= <ij@2011.bluespice.org>

Applied all four patches.


Thanks,

Florian Tobias Schandinat

On 10/20/2011 11:42 AM, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  include/linux/zorro_ids.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/zorro_ids.h b/include/linux/zorro_ids.h
> index 7e74908..74bc53b 100644
> --- a/include/linux/zorro_ids.h
> +++ b/include/linux/zorro_ids.h
> @@ -360,8 +360,8 @@
>  #define  ZORRO_PROD_VILLAGE_TRONIC_PICASSO_II_II_PLUS_RAM	ZORRO_ID(VILLAGE_TRONIC, 0x0B, 0)
>  #define  ZORRO_PROD_VILLAGE_TRONIC_PICASSO_II_II_PLUS_REG	ZORRO_ID(VILLAGE_TRONIC, 0x0C, 0)
>  #define  ZORRO_PROD_VILLAGE_TRONIC_PICASSO_II_II_PLUS_SEGMENTED_MODE	ZORRO_ID(VILLAGE_TRONIC, 0x0D, 0)
> -#define  ZORRO_PROD_VILLAGE_TRONIC_PICASSO_IV_Z2_MEM1		ZORRO_ID(VILLAGE_TRONIC, 0x15, 0)
> -#define  ZORRO_PROD_VILLAGE_TRONIC_PICASSO_IV_Z2_MEM2		ZORRO_ID(VILLAGE_TRONIC, 0x16, 0)
> +#define  ZORRO_PROD_VILLAGE_TRONIC_PICASSO_IV_Z2_RAM1		ZORRO_ID(VILLAGE_TRONIC, 0x15, 0)
> +#define  ZORRO_PROD_VILLAGE_TRONIC_PICASSO_IV_Z2_RAM2		ZORRO_ID(VILLAGE_TRONIC, 0x16, 0)
>  #define  ZORRO_PROD_VILLAGE_TRONIC_PICASSO_IV_Z2_REG		ZORRO_ID(VILLAGE_TRONIC, 0x17, 0)
>  #define  ZORRO_PROD_VILLAGE_TRONIC_PICASSO_IV_Z3		ZORRO_ID(VILLAGE_TRONIC, 0x18, 0)
>  #define  ZORRO_PROD_VILLAGE_TRONIC_ARIADNE			ZORRO_ID(VILLAGE_TRONIC, 0xC9, 0)

