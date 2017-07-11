From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 11 Jul 2017 21:03:01 +0000
Subject: Re: [PATCH RESEND] staging: sm750fb: avoid conflicting vesafb
Message-Id: <20170711210301.GA4515@sudip-laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1498856263-4544-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1498856263-4544-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, Teddy Wang <teddy.wang@siliconmotion.com>, stable@vger.kernel.org

Hi Greg,

On Fri, Jun 30, 2017 at 09:57:43PM +0100, Sudip Mukherjee wrote:
> From: Teddy Wang <teddy.wang@siliconmotion.com>
> 
> If vesafb is enabled in the config then /dev/fb0 is created by vesa
> and this sm750 driver gets fb1, fb2. But we need to be fb0 and fb1 to
> effectively work with xorg.
> So if it has been alloted fb1, then try to remove the other fb0.
> 
> Cc: <stable@vger.kernel.org> # v4.4+
> Signed-off-by: Teddy Wang <teddy.wang@siliconmotion.com>
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> ---
> 
> In the previous send, why #ifdef is used was asked.
> https://lkml.org/lkml/2017/6/25/57
> 
> Answered at: https://lkml.org/lkml/2017/6/25/69
> Also pasting here for reference.
> 
> 'Did a quick research into "why".
> The patch d8801e4df91e ("x86/PCI: Set IORESOURCE_ROM_SHADOW only for the
> default VGA device") has started setting IORESOURCE_ROM_SHADOW in flags
> for a default VGA device and that is being done only for x86.
> And so, we will need that #ifdef to check IORESOURCE_ROM_SHADOW as that
> needs to be checked only for a x86 and not for other arch.'

A gentle ping.

--
Regards
Sudip
