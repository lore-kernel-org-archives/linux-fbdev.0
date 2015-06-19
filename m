From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 19 Jun 2015 14:45:14 +0000
Subject: Re: [PATCH v2 5/9] staging: sm7xxfb: fix alignment
Message-Id: <20150619144514.GS28762@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434540288-8289-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1434540288-8289-6-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1434540288-8289-6-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, Joe Perches <joe@perches.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jun 17, 2015 at 04:54:44PM +0530, Sudip Mukherjee wrote:
> @@ -346,9 +346,8 @@ static ssize_t smtcfb_read(struct fb_info *info, char __user *buf, size_t
>  		dst = buffer;
>  		for (i = c >> 2; i--;) {
>  			*dst = fb_readl(src++);
> -			*dst > -			    (*dst & 0xff00ff00 >> 8) |
> -			    (*dst & 0x00ff00ff << 8);
> +			*dst = (*dst & 0xff00ff00 >> 8) |
> +			       (*dst & 0x00ff00ff << 8);

This is supposed to convert __le16 to __be16?

>  			dst++;
>  		}
>  		if (c & 3) {

regards,
dan carpenter
--
To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
