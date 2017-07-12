From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 12 Jul 2017 06:06:24 +0000
Subject: Re: [PATCH RESEND] staging: sm750fb: avoid conflicting vesafb
Message-Id: <20170712060624.GA11450@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1498856263-4544-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20170711210301.GA4515@sudip-laptop>
In-Reply-To: <20170711210301.GA4515@sudip-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, Teddy Wang <teddy.wang@siliconmotion.com>, stable@vger.kernel.org

On Tue, Jul 11, 2017 at 10:03:01PM +0100, Sudip Mukherjee wrote:
> Hi Greg,
> 
> On Fri, Jun 30, 2017 at 09:57:43PM +0100, Sudip Mukherjee wrote:
> > From: Teddy Wang <teddy.wang@siliconmotion.com>
> > 
> > If vesafb is enabled in the config then /dev/fb0 is created by vesa
> > and this sm750 driver gets fb1, fb2. But we need to be fb0 and fb1 to
> > effectively work with xorg.
> > So if it has been alloted fb1, then try to remove the other fb0.
> > 
> > Cc: <stable@vger.kernel.org> # v4.4+
> > Signed-off-by: Teddy Wang <teddy.wang@siliconmotion.com>
> > Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> > ---
> > 
> > In the previous send, why #ifdef is used was asked.
> > https://lkml.org/lkml/2017/6/25/57
> > 
> > Answered at: https://lkml.org/lkml/2017/6/25/69
> > Also pasting here for reference.
> > 
> > 'Did a quick research into "why".
> > The patch d8801e4df91e ("x86/PCI: Set IORESOURCE_ROM_SHADOW only for the
> > default VGA device") has started setting IORESOURCE_ROM_SHADOW in flags
> > for a default VGA device and that is being done only for x86.
> > And so, we will need that #ifdef to check IORESOURCE_ROM_SHADOW as that
> > needs to be checked only for a x86 and not for other arch.'
> 
> A gentle ping.

It's in the middle of the merge window, I can't do anything with patches
right now, you know better than this...

I'll get to it after 4.13-rc1 is out, relax please.

greg k-h
