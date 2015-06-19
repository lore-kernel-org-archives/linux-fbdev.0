From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 19 Jun 2015 14:51:32 +0000
Subject: Re: [PATCH v2 9/9] staging: sm7xxfb: fix camelcase
Message-Id: <20150619145132.GV28762@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434540288-8289-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1434540288-8289-10-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1434540288-8289-10-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, Joe Perches <joe@perches.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jun 17, 2015 at 04:54:48PM +0530, Sudip Mukherjee wrote:
> Fix the checkpatch warning about CamelCase.
> 
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
>  drivers/staging/sm7xxfb/sm7xx.h   | 2 +-
>  drivers/staging/sm7xxfb/sm7xxfb.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/sm7xxfb/sm7xx.h b/drivers/staging/sm7xxfb/sm7xx.h
> index fc28429..4bed094 100644
> --- a/drivers/staging/sm7xxfb/sm7xx.h
> +++ b/drivers/staging/sm7xxfb/sm7xx.h
> @@ -98,7 +98,7 @@ static inline unsigned int smtc_seqr(int reg)
>  /* The next structure holds all information relevant for a specific video mode.
>   */
>  
> -struct ModeInit {
> +struct modeinit {

struct mode_init is easier to read.

regards,
dan carpenter

--
To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
