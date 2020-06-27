From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Sat, 27 Jun 2020 05:12:19 +0000
Subject: Re: [PATCH] fbtft-bus.c:
Message-Id: <20200627051219.GA233327@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200627045004.a46jbqtbiintu2nt@pesu-pes-edu>
In-Reply-To: <20200627045004.a46jbqtbiintu2nt@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: B K Karthik <bkkarthik@pesu.pes.edu>
Cc: Jan Sebastian =?iso-8859-1?Q?G=F6tte?= <linux@jaseg.net>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

On Sat, Jun 27, 2020 at 12:50:04AM -0400, B K Karthik wrote:
> fbtft-bus.c:
> 
> fixing ERROR: space prohibited before that close parenthesis ')' by removing that space and ',' in line 65 and 67.
> 
> Signed-off-by: B K Karthik <karthik.bk2000@live.com>
> ---
>  drivers/staging/fbtft/fbtft-bus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)


Your subject line is really odd :(

Please read the following text from my patch-bot:

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

And fix up both the subject lines, and the changelog body text so that
it looks correct.  Look at the other patches for this code that have
been accepted as examples of what to do.

thanks,

greg k-h
