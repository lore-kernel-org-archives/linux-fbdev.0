From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 11 Mar 2015 07:57:43 +0000
Subject: Re: [PATCH 6/6] staging: sm750fb: correct integer comparison
Message-Id: <20150311075743.GS10964@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426007817-1884-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1426007817-1884-7-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1426007817-1884-7-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Mar 10, 2015 at 10:46:57PM +0530, Sudip Mukherjee wrote:
> fixed the build warning about comparison of pointer and integer.
> end of string was being compared to NULL.
> 
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
>  drivers/staging/sm750fb/sm750.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 021b863..5532a28 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -1000,7 +1000,7 @@ static void sm750fb_setup(struct lynx_share * share,char * src)
>              goto NO_PARAM;
>          }
>  
> -        while((opt = strsep(&src,":")) != NULL && *opt != NULL){
> +        while((opt = strsep(&src,":")) != NULL && *opt != 0){

Use '\0' for the NUL char.

regards,
dan carpenter
