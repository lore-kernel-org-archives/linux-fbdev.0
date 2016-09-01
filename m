From: Greg KH <gregkh@linuxfoundation.org>
Date: Thu, 01 Sep 2016 16:04:46 +0000
Subject: Re: [PATCH 1/9] staging: sm750fb: fix line length coding style issue in ddk750_chip.c
Message-Id: <20160901160446.GA18620@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <7011104f5ba6d400b550d2f25d16b1183efa0f35.1472583825.git.mgmoshes@gmail.com>
In-Reply-To: <7011104f5ba6d400b550d2f25d16b1183efa0f35.1472583825.git.mgmoshes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Moshe Green <mgmoshes@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Aug 30, 2016 at 10:04:02PM +0300, Moshe Green wrote:
> Fix a line length warning found by the checkpatch.pl tool in
> ddk750_chip.c.
> 
> Signed-off-by: Moshe Green <mgmoshes@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_chip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Lots of the patches in this series have the same exact subject: line,
yet they do different things.  Please fix them up and make them more
obvious, or even better yet, merge them into less patches (one type of
thing per file per patch, not one single change per patch).

thanks,

greg k-h
