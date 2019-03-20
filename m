From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 20 Mar 2019 05:13:53 +0000
Subject: Re: [RESEND][PATCH 0/2] staging: sm750fb: trivial style fixes.
Message-Id: <20190320051353.GB16864@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190303165532.23727-1-tomli@tomli.me>
In-Reply-To: <20190303165532.23727-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yifeng Li <tomli@tomli.me>
Cc: Jiri Kosina <trivial@kernel.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, linux-kernel@vger.kernel.org

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

staging patches need to go to me, as get_maintainers.pl says to send
them.  I'll queue these up in a bit, but no need to bother trivial@ with
staging stuff, otherwise that would be all it did :)

thanks,

greg k-h
