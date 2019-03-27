From: Greg Kroah-Hartman <greg@kroah.com>
Date: Wed, 27 Mar 2019 17:23:55 +0000
Subject: Re: [PATCH] staging: sm750fb: Fix whitespace to conform to coding style
Message-Id: <20190327172355.GA4346@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sun, Mar 10, 2019 at 12:13:27AM -0500, Joe Turpin wrote:
> Replace spaces with tabs for indentation and add where missing.
> Reflow comments to remain within 80 chars line limit.
> 
> Signed-off-by: Joe Turpin <joe.turpin@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750_accel.c | 160 ++++++++++++++------------
>  1 file changed, 88 insertions(+), 72 deletions(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
