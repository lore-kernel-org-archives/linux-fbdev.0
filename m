From: Greg KH <gregkh@linuxfoundation.org>
Date: Thu, 26 Mar 2015 12:06:03 +0000
Subject: Re: [PATCH 02/13] staging: sm750: add missing spaces after ','
Message-Id: <20150326120603.GA30581@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150322231131.GA17080@x230-arch.club.entropia.de>
In-Reply-To: <20150322231131.GA17080@x230-arch.club.entropia.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Mar 23, 2015 at 12:11:31AM +0100, Michel von Czettritz wrote:
> Fixes checkpatch.pl error:
> "ERROR: space required after that ',' (ctx:VxV)"
> 
> Signed-off-by: Michel von Czettritz <michel.von.czettritz@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 264 ++++++++++++++++++++--------------------
>  1 file changed, 132 insertions(+), 132 deletions(-)

As I didn't take your first patch, the rest of the patches in this
series do not apply.

Please fix them up, rebase on my latest staging-testing branch of
staging.git, and resend so that I can apply them.

thanks,

greg k-h
