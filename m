From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 11 May 2018 09:43:47 +0000
Subject: Re: [PATCH] staging: sm750fb: add SPDX license identifier
Message-Id: <20180511094347.GA18687@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180508185102.GA21793@ubuntu>
In-Reply-To: <20180508185102.GA21793@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, May 09, 2018 at 12:21:02AM +0530, Sumit Kumar wrote:
> SPDX licencse identifier is missing in header file. Add a SPDX license
> identifier with correct format. Issue found by checkpatch.
> 
> Signed-off-by: Sumit Kumar <sumit686215@example.com>
> ---
>  drivers/staging/sm750fb/ddk750.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/sm750fb/ddk750.h b/drivers/staging/sm750fb/ddk750.h
> index 7340103..482c1c6 100644
> --- a/drivers/staging/sm750fb/ddk750.h
> +++ b/drivers/staging/sm750fb/ddk750.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

How do you know that is what this license is?

thanks,

greg k-h
