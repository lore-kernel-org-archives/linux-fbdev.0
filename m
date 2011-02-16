From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Wed, 16 Feb 2011 17:41:40 +0000
Subject: Re: [PATCH 0/6] sisfb: XGI Z9 POST
Message-Id: <alpine.DEB.1.10.1102161916510.479@loser>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297635088-13224-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1297635088-13224-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Hi,

On Mon, 14 Feb 2011, Aaro Koskinen wrote:
> Here's some patches to get POST working with XGI Z9. I have tested them
> with the following card:
>
> 	http://www.roboard.com/Files/RB-100/MiniPCI-VGA-Z9s_UM_v1r1A.pdf
>
> I'm using the card on an ARM board where the bootloader knows nothing
> about VGA or VGA BIOS, so having POST support in the kernel driver
> is mandatory. With these patches the memory size is correct detected,
> R/W test passes and it's possible to use e.g. framebuffer console.
>
> Aaro Koskinen (6):
>  sisfb: POST should fail if R/W test fails
>  sisfb: move XGI POST RAM type detection into a subroutine
>  sisfb: add subroutine for detecting XGI Z9
>  sisfb: add RAM type detection for XGI Z9
>  sisfb: move XGI POST DDR2 bootup code into subroutines
>  sisfb: add support for XGI Z9 DDR2 POST

Hmm, I think these patches can be ignored, at least for a while.

I realized that xgifb driver is now in staging, and it has much wider
support for XGI chips. So, we should work on getting that driver into
an acceptable form. And after that, it should be even possible to drop
XGI support from sisfb.

A.
