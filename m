From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Mon, 23 Mar 2015 12:48:53 +0000
Subject: Re: [PATCH] sm750fb: Fix C99 comment and if-else braces
Message-Id: <20150323124800.GA8151@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150320142455.GA17954@amitoj-Inspiron-3542>
In-Reply-To: <20150320142455.GA17954@amitoj-Inspiron-3542>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Cc: teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Fri, Mar 20, 2015 at 07:54:56PM +0530, Amitoj Kaur Chawla wrote:
> The edits have been made to fix C99 Comment and properly indent
> the if-else statements with the braces.
i think you are doing multiple types of changes in one patch.
better to send it in a series of two, one for the C99 and the other
for the if-else. and there are few more places in that file where C99
is used, any reason why you have chosen only one?

scripts/checkpatch.pl --strict -f drivers/staging/sm750fb/ddk750_chip.c | grep C99 | wc -l
6

and, your patch is not applying, please refresh your patch
against staging-testing.

regards
sudip
> 
