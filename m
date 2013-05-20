From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 20 May 2013 19:42:06 +0000
Subject: Re: [PATCH] video/matrox/matroxfb_maven: Use module_i2c_driver to register driver
Message-Id: <20130520214206.078bc580@endymion.delvare>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369078578-3138-1-git-send-email-peterhuewe@gmx.de>
In-Reply-To: <1369078578-3138-1-git-send-email-peterhuewe@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Huewe <peterhuewe@gmx.de>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Wolfram Sang <w.sang@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 20 May 2013 21:36:18 +0200, Peter Huewe wrote:
> Removing some boilerplate by using module_i2c_driver instead of calling
> register and unregister in the otherwise empty init/exit functions
> 
> Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
> ---
>  drivers/video/matrox/matroxfb_maven.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/video/matrox/matroxfb_maven.c b/drivers/video/matrox/matroxfb_maven.c
> index 217678e..fd4b64e 100644
> --- a/drivers/video/matrox/matroxfb_maven.c
> +++ b/drivers/video/matrox/matroxfb_maven.c
> @@ -1283,19 +1283,8 @@ static struct i2c_driver maven_driver={
>  	.id_table	= maven_id,
>  };
>  
> -static int __init matroxfb_maven_init(void)
> -{
> -	return i2c_add_driver(&maven_driver);
> -}
> -
> -static void __exit matroxfb_maven_exit(void)
> -{
> -	i2c_del_driver(&maven_driver);
> -}
> -
> +module_i2c_driver(maven_driver);
>  MODULE_AUTHOR("(c) 1999-2002 Petr Vandrovec <vandrove@vc.cvut.cz>");
>  MODULE_DESCRIPTION("Matrox G200/G400 Matrox MGA-TVO driver");
>  MODULE_LICENSE("GPL");
> -module_init(matroxfb_maven_init);
> -module_exit(matroxfb_maven_exit);
>  /* we do not have __setup() yet */

This last comment could certainly go away as well, AFAICT it's a now
meaningless relic.

Other than this:

Reviewed-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare
