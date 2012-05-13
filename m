From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 13 May 2012 20:56:18 +0000
Subject: Re: [PATCH 0/4] fbdev: sh_mobile_hdmi: adds HDMI control register support
Message-Id: <4FB01FF2.6050801@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <87lil3mi69.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87lil3mi69.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Morimoto-san,

On 05/08/2012 04:05 AM, Kuninori Morimoto wrote:
> 
> Hi Florian
> Cc: Magnus, Guennadi, Simon
> 
> These are sh_mobile_hdmi update patches to supporting
> HDMI control register on latest SuperH chip
> 
> Kuninori Morimoto (4):
>       fbdev: sh_mobile_hdmi: add hdmi_bit_set() function
>       fbdev: sh_mobile_hdmi: add interrupt output option
>       fbdev: sh_mobile_hdmi: 32bit register access support
>       fbdev: sh_mobile_hdmi: add HDMI Control Register support

I applied these patches.


Thanks,

Florian Tobias Schandinat

> 
> These patches add 32bit access support, and init control registers.
> These are tested on Armadillo800eva board
> 
> Best regards
> ---
> Kuninori Morimoto
> 
