From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 02 Jun 2015 06:27:30 +0000
Subject: Re: [PATCH 02/12] Staging: sm750fb: sm750_help.h: Insert spaces after commas.
Message-Id: <20150602061530.GC6382@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1433134873-9869-1-git-send-email-isaac.a.travers@gmail.com>
 <1433134873-9869-3-git-send-email-isaac.a.travers@gmail.com>
In-Reply-To: <1433134873-9869-3-git-send-email-isaac.a.travers@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Isaac Assegai <isaac.a.travers@gmail.com>
Cc: gregkh@linuxfoundation.org, teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Sun, May 31, 2015 at 10:01:03PM -0700, Isaac Assegai wrote:
> Insert Spaces after commas to rectify the
> following checkpatch errors in sm750_help.h:
> ERROR: space required after that ','
> 
> Signed-off-by: Isaac Assegai <isaac.a.travers@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750_help.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750_help.h b/drivers/staging/sm750fb/sm750_help.h
> index e0128d2..3940359 100644
> --- a/drivers/staging/sm750fb/sm750_help.h
> +++ b/drivers/staging/sm750fb/sm750_help.h
> @@ -10,11 +10,11 @@
>  
>  #define RAW_MASK(f)         (0xFFFFFFFF >> (32 - _COUNT(f)))
>  #define GET_MASK(f)         (RAW_MASK(f) << _LSB(f))
> -#define GET_FIELD(d,f)      (((d) >> _LSB(f)) & RAW_MASK(f))
> -#define TEST_FIELD(d,f,v)   (GET_FIELD(d,f) = f ## _ ## v)
> -#define SET_FIELD(d,f,v)    (((d) & ~GET_MASK(f)) | \
> +#define GET_FIELD(d, f)     (((d) >> _LSB(f)) & RAW_MASK(f))
> +#define TEST_FIELD(d, f, v) (GET_FIELD(d,f) = f ## _ ## v)
					  ^^^
i guess you missed this one.

regards
sudip

