From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Sun, 03 Mar 2019 17:56:49 +0000
Subject: Re: [RESEND][PATCH 0/2] staging: sm750fb: trivial style fixes.
Message-Id: <20190303175649.GB16636@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190303165532.23727-1-tomli@tomli.me>
In-Reply-To: <20190303165532.23727-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yifeng Li <tomli@tomli.me>
Cc: Jiri Kosina <trivial@kernel.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>

On Mon, Mar 04, 2019 at 12:55:30AM +0800, Yifeng Li wrote:
> Hello.
> 
> >From January to February, there have been two trivial sm750fb patches
> submitted to linux-fbdev, one by me, one by Jin Chen, but both without
> any response. Further, it seems both maintainers, Sudip Mukherjee and
> Teddy Wang, are currently unavailable, getting an "Ack-by" would be
> unfeasible.
> 
> Since they're extremely trivial. Hereby, I picked them up, reworded
> commit message, and now resubmit them as trivial patches, and send them
> to trivial@kernel.org. I hope it could be directly applied by either a
> fbdev, a staging maintainer or by Jiri Kosina.
> 
> Thanks for your time!
> 
> Yifeng Li (2):
>   staging: sm750fb: trivial comment indention fix.
>   staging: sm750fb: trivial Camel Case removal for setDisplayControl().
> 
>  drivers/staging/sm750fb/ddk750_display.c |  6 ++---
>  drivers/staging/sm750fb/sm750_accel.c    | 32 ++++++++++++------------
>  2 files changed, 19 insertions(+), 19 deletions(-)

Always use scripts/get_maintainer.pl when sending patches in.  It would
have saved you time...

Anyway, my tree is closed right now, but I'll look at these once 5.1-rc1
is out, thanks.

greg k-h
