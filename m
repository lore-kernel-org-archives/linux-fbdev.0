From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 19 Jun 2015 14:48:49 +0000
Subject: Re: [PATCH v2 7/9] staging: sm7xxfb: move mode table
Message-Id: <20150619144849.GT28762@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434540288-8289-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1434540288-8289-8-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1434540288-8289-8-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, Joe Perches <joe@perches.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jun 17, 2015 at 04:54:46PM +0530, Sudip Mukherjee wrote:
> +static const struct ModeInit vgamode[] = {
> +	{
> +	 /*  mode#0: 640 x 480  16Bpp  60Hz */
> +	 640, 480, 16, 60,
> +	 /*  Init_MISC */
> +	 0xE3,
> +	 {			/*  Init_SR0_SR4 */
> +	  0x03, 0x01, 0x0F, 0x00, 0x0E,
> +	  },

All this indenting is kind of whacky.

regards,
dan carpenter

--
To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
