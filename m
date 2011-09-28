From: Timur Tabi <timur@freescale.com>
Date: Wed, 28 Sep 2011 21:23:46 +0000
Subject: Re: [PATCH 4/9] drivers/video: fsl-diu-fb: add several new video
Message-Id: <4E839062.7040706@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1317244795-24671-4-git-send-email-timur@freescale.com>
In-Reply-To: <1317244795-24671-4-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Timur Tabi wrote:
> Also add margin data to the 320x240 video mode.  This mode was originally
> intended only for the AOIs (overlays) used on planes two and three, but with
> real margin data, it can now be used as an actual video mode.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

Ugh, I forgot something in this commit message.  Florian, if you apply this
patch, would you mind adding this:

Video mode data is from earlier work done by Jerry Huang
<Chang-Ming.Huang@freescale.com>.

-- 
Timur Tabi
Linux kernel developer at Freescale

