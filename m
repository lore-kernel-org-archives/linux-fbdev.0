From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Sun, 25 Jun 2017 12:54:51 +0000
Subject: Re: [PATCH 1/2] staging: sm750fb: avoid conflicting vesafb
Message-Id: <20170625125451.GB2728@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1497904378-4808-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20170625124334.GA6942@sudip-laptop>
In-Reply-To: <20170625124334.GA6942@sudip-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, Teddy Wang <teddy.wang@siliconmotion.com>

On Sun, Jun 25, 2017 at 01:43:34PM +0100, Sudip Mukherjee wrote:
> On Mon, Jun 19, 2017 at 09:32:57PM +0100, Sudip Mukherjee wrote:
> > From: Teddy Wang <teddy.wang@siliconmotion.com>
> > 
> > If vesafb is enabled in the config then /dev/fb0 is created by vesa
> > and this sm750 driver gets fb1, fb2. But we need to be fb0 and fb1 to
> > effectively work with xorg.
> > So if it has been alloted fb1, then try to remove the other fb0.
> > 
> > Signed-off-by: Teddy Wang <teddy.wang@siliconmotion.com>
> > Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> > ---
> 
> Hi Greg,
> You applied the second patch but not this one. Did I miss any review
> comments from you about this one?

All of the other complaints about this patch were not sufficient for me
to justify ignoring it?  Why would I not listen to them?

Please fix and resend if you want it applied.

thanks,

greg k-h
