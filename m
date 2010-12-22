From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 22 Dec 2010 07:28:43 +0000
Subject: Re: [PATCH 1/3] fbdev: sh-mobile: restore display size configuration
Message-Id: <20101222072843.GA28151@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1012211048100.32347@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1012211048100.32347@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Dec 21, 2010 at 11:46:26AM +0100, Guennadi Liakhovetski wrote:
> An earlier patch replaced open-coded video-mode configuration from 
> platform data by a call to fb_videomode_to_var(), thereby setting 
> ofdisplay sizes have been accidentally lost. Restore them.

On Tue, Dec 21, 2010 at 11:46:35AM +0100, Guennadi Liakhovetski wrote:
> Monitor EDID contains information about physical display sizes. Retrieve 
> it and propagate to the framebuffer driver.

Both applied for .37, thanks.
