From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 09 Mar 2015 07:47:40 +0000
Subject: Re: [PATCH v2 3/4] staging: sm750fb: correctly define SM750LE_REVISION_ID
Message-Id: <CA+V-a8sNsxzz38K5KOn7WyDPDR=2bCNpg+53ULQn3qcTPCvcqw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425886506-8643-1-git-send-email-sudipm.mukherjee@gmail.com> <1425886506-8643-3-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1425886506-8643-3-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LFBDEV <linux-fbdev@vger.kernel.org>, OSUOSL Drivers <devel@driverdev.osuosl.org>, LKML <linux-kernel@vger.kernel.org>

On Mon, Mar 9, 2015 at 7:35 AM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> check if it is already defined before defining SM750LE_REVISION_ID
> again and at the same time mention correct data type.
>
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
>
> v2: removed the redundant cast in sm750_hw.c
>
>  drivers/staging/sm750fb/ddk750_chip.h | 4 +++-
>  drivers/staging/sm750fb/sm750_hw.c    | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/sm750fb/ddk750_chip.h b/drivers/staging/sm750fb/ddk750_chip.h
> index 1c78875..d761b72 100644
> --- a/drivers/staging/sm750fb/ddk750_chip.h
> +++ b/drivers/staging/sm750fb/ddk750_chip.h
> @@ -1,7 +1,9 @@
>  #ifndef DDK750_CHIP_H__
>  #define DDK750_CHIP_H__
>  #define DEFAULT_INPUT_CLOCK 14318181 /* Default reference clock */
> -#define SM750LE_REVISION_ID (char)0xfe
> +#ifndef SM750LE_REVISION_ID
> +#define SM750LE_REVISION_ID ((unsigned char)0xfe)

BTW who is defining this somewhere else ?

Cheers,
--Prabhakar Lad
