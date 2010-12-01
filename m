From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 01 Dec 2010 09:20:08 +0000
Subject: Re: [PATCH] lxfb: Maintain video processor palette through suspend/resume
Message-Id: <20101201092008.GC2982@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Nov 30, 2010 at 08:34:52PM +0000, Daniel Drake wrote:
> The Geode X driver uses both of the LX's palettes, one for gamma
> correction and one for colormaps.
> 
> The kernel driver currently only backs up the one used for colormaps
> during suspend/resume. If you mess with gamma settings and do a
> suspend/resume, colors go funny.
> 
> Fix this by backing up the video proc palette during suspend/resume,
> alongside the display controller one which is already handled.
> 
> Signed-off-by: Daniel Drake <dsd@laptop.org>
> Acked-by: Andres Salomon <dilinger@queued.net>

Applied, thanks.
