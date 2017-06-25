From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sun, 25 Jun 2017 15:07:39 +0000
Subject: Re: [PATCH 1/2] staging: sm750fb: avoid conflicting vesafb
Message-Id: <20170625150739.GA9422@sudip-laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1497904378-4808-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20170625124334.GA6942@sudip-laptop>
 <20170625125451.GB2728@kroah.com>
 <20170625135429.GA8651@sudip-laptop>
 <20170625142723.GA11105@kroah.com>
In-Reply-To: <20170625142723.GA11105@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, Teddy Wang <teddy.wang@siliconmotion.com>

On Sun, Jun 25, 2017 at 04:27:23PM +0200, Greg Kroah-Hartman wrote:
> On Sun, Jun 25, 2017 at 02:54:29PM +0100, Sudip Mukherjee wrote:
> > On Sun, Jun 25, 2017 at 02:54:51PM +0200, Greg Kroah-Hartman wrote:
> > > On Sun, Jun 25, 2017 at 01:43:34PM +0100, Sudip Mukherjee wrote:
> > > > On Mon, Jun 19, 2017 at 09:32:57PM +0100, Sudip Mukherjee wrote:
> > > > > From: Teddy Wang <teddy.wang@siliconmotion.com>
> > > > > 
> > > > > If vesafb is enabled in the config then /dev/fb0 is created by vesa
> > > > > and this sm750 driver gets fb1, fb2. But we need to be fb0 and fb1 to
> > > > > effectively work with xorg.
> > > > > So if it has been alloted fb1, then try to remove the other fb0.
> > > > > 
> > > > > Signed-off-by: Teddy Wang <teddy.wang@siliconmotion.com>
> > > > > Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> > > > > ---
> > > > 
> > > > Hi Greg,
> > > > You applied the second patch but not this one. Did I miss any review
> > > > comments from you about this one?
> > > 
> > > All of the other complaints about this patch were not sufficient for me
> > > to justify ignoring it?  Why would I not listen to them?
> > 
> > This patch is doing what all the drm drivers are doing. So you want
> > us to do something completely new rather than following the established
> > practice of a drm driver?
> 
> I despise cargo-cult programming.  You could not answer the "why", so
> why would I accept such a patch?

Did a quick research into "why".
The patch d8801e4df91e ("x86/PCI: Set IORESOURCE_ROM_SHADOW only for the
default VGA device") has started setting IORESOURCE_ROM_SHADOW in flags
for a default VGA device and that is being done only for x86.
And so, we will need that #ifdef to check IORESOURCE_ROM_SHADOW as that
needs to be checked only for a x86 and not for other arch.

--
Regards
Sudip
