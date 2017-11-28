From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 28 Nov 2017 13:13:31 +0000
Subject: Re: [PATCH v2] staging: sm750b: Fix coding style issues in sm750_accel.c
Message-Id: <20171128131331.GA12924@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1511649387.20482.5.camel@perches.com>
 <20171125224812.23914-1-j.lacomis@gmail.com>
In-Reply-To: <20171125224812.23914-1-j.lacomis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeremy Lacomis <j.lacomis@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Sat, Nov 25, 2017 at 05:48:11PM -0500, Jeremy Lacomis wrote:
> This is a patch to sm750_accel.c that fixes 80-character line length
> warnings found by checkpatch.pl. It also fixes some grammatical errors
> in comments and moves parameter-specific comments from inline to before
> the function.
> 
> Signed-off-by: Jeremy Lacomis <j.lacomis@gmail.com>
> ---
> Changes in v2:
> - Change function comments to the kernel-doc format
> 
>  drivers/staging/sm750fb/sm750_accel.c | 189 ++++++++++++++++++----------------
>  1 file changed, 103 insertions(+), 86 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
> index 1035e91e7cd3..42cd920111bf 100644
> --- a/drivers/staging/sm750fb/sm750_accel.c
> +++ b/drivers/staging/sm750fb/sm750_accel.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +/* SPDX-License-Identifier: GPL-2.0 */

Why did you change this line?  That is not correct.

Only ever do one "logical" thing per patch.  If you have to say "also"
in a changelog text, that's a huge hint you are doing something wrong.

thanks,

greg k-h
