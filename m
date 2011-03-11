From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 11 Mar 2011 04:54:20 +0000
Subject: Re: [PATCH v2] fbdev: sh_mobile_lcdc: Add YUV input support
Message-Id: <20110311045420.GB19466@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1298526433-6621-1-git-send-email-dhobsong@igel.co.jp>
In-Reply-To: <1298526433-6621-1-git-send-email-dhobsong@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, Mar 02, 2011 at 03:42:13PM +0900, Damian wrote:
> Supports YCbCr420sp, YCbCr422sp, and YCbCr44sp, formats
> (bpp = 12, 16, and 24) respectively.
> 
> When double-buffering both Y planes appear before the C planes (Y-Y-C-C),
> as opposed to  Y-C-Y-C.
> Set .nonstd in struct sh_mobile_lcdc_chan_cfg to enable YUV mode, and use
> .bpp to distiguish between the 3 modes.
> The value of .nonstd is copied to bits 16-31 of LDDFR in the LCDC and
> should be set accordingly.
> .nonstd must be set to 0 for RGB mode.
> 
> Due to the encoding of YUV data, the framebuffer will clear to green
> instead of black.
> 
> In YUV 420 mode, panning is only possible in 2 line increments.
> Additionally in YUV 420 mode the vertical resolution of the framebuffer
> must be an even number.
> 
> Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>

This version of the patch was horribly line-wrapped, but the previous one
'fbdev: sh_mobile_lcdc: Add YUV framebuffer support' which seemed to have
an identical description and versioning looked fine, so I've taken that
one in to the fbdev tree.

You may wish to double check to make sure that what has been merged is in
sync with your latest changes.
