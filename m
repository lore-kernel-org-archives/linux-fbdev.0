From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 19 Mar 2015 20:21:24 +0000
Subject: Re: [PATCH] staging: sm750fb: fixing multiple checkpatch errors and warnings
Message-Id: <20150319202124.GW10964@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150319192603.GA26974@x230-arch.club.entropia.de>
In-Reply-To: <20150319192603.GA26974@x230-arch.club.entropia.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michel von Czettritz <michel.von.czettritz@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thu, Mar 19, 2015 at 08:26:03PM +0100, Michel von Czettritz wrote:
> This patch formats sm750.c to
> - correct intendations
> - no leading or trailing whitespaces
> - no C99 Style comments
> - correct braces and spacings for if, for and functions
> - no initalisation of static variables to 0 or NULL
> - no assignments in if conditions
> - correct spacings arround pointers and function arguments
> 
> and some other warnings

This patch does too many things at once.  Split it up into one type of
warning per patch.

regards,
dan carpenter

