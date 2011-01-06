From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 06 Jan 2011 06:47:42 +0000
Subject: Re: [PATCH] Fix the HGA framebuffer driver
Message-Id: <20110106064742.GE15340@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Dec 30, 2010 at 11:56:50PM -0600, Brent Cook wrote:
> Resurrected some old hardware and fixed up the hgafb driver to work again. Only
> tested with fbcon, since most fbdev-based software appears to only support
> 12bpp and up. It does not appear that this driver has worked for at least the
> entire 2.6.x series, perhaps since 2002.
> 
> I sent this to the sourceforge mailing list before realizing the list had
> moved. http://www.linux-fbdev.org/ has the wrong mailing list info.
> 
> Regards,
>  Brent
> 
> Signed-off-by: Brent Cook <busterb@gmail.com>
> 
> Hercules graphics hardware uses packed pixels horizontally, but rows are not
> linear. In other words, the pixels are not packed vertically. This means that
> custom imageblit, fillrect and copyarea need to be written specific to the
> hardware.
> 
>  * Removed the experimental acceleration option, since it is required for the
>    hardware to work.
>  * Fixed imageblit to work with fb_image's wider than 8 pixels.
>  * Updated configuration text (HGA hardware is from 1984)

I shuffled the changelog around to include these bits and applied it,
thanks.
