From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 10 Nov 2010 11:27:02 +0000
Subject: Re: [PATCHv2] sisfb: limit POST memory test according to PCI resource length
Message-Id: <20101110112702.GB1475@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1289387059-31760-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1289387059-31760-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Thomas Winischhofer <thomas@winischhofer.net>

On Wed, Nov 10, 2010 at 01:04:19PM +0200, Aaro Koskinen wrote:
> If the POST memory test fails, the driver may access illegal
> memory areas. Instead of hard coding the maximum size, set it
> according to the PCI resource length (an additional check is needed in
> sisfb_post_map_vram() to ensure it's big enough). DRAM sizing will later
> adjust video_size to the correct value.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: Thomas Winischhofer <thomas@winischhofer.net>
> ---
> 
> v2: Add a check to sisfb_post_map_vram().
> 

Queued for .37, thanks.
