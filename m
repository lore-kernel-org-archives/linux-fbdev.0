From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Thu, 28 Apr 2011 06:08:01 +0000
Subject: Re: [RFC][PATCH 0/3] MERAM support for LCDC
Message-Id: <4DB90441.3010303@igel.co.jp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1301369758-18394-1-git-send-email-dhobsong@igel.co.jp>
In-Reply-To: <1301369758-18394-1-git-send-email-dhobsong@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Magnus,

Thanks for your comments.

On 2011/04/26 14:46, Magnus Damm wrote:
> Hi Damian,
> 
> Thanks for your work on this!
> 
> I think these patches look very good in general. I have one request
> and some general comments:
> 
> Please add Runtime PM support to the MERAM driver. The MSTP113 bit of
> SMSTPCR1 should be dynamically controlled using pm_runtime_get_sync()
> and pm_runtime_put_sync().

Ok, I'll look into this, but I think that it will take some thinking.
The MERAM is accessed not only from the LCDC, but can also be accessed
from user space via the uio_pdrv_genirq driver.  I think we need to take
care of proper reference counting across these drivers.
> 
> I also wonder if we can chose to use MERAM dynamically somehow. I know
> the sh7372 MERAM can be used to back the entire frame buffer memory
> (controlled by the LRCTRL register, see the MERAM section in the
> sh7372 data sheet). This fully-backed mode can perhaps be used to save
> power for regular low-performance operation and/or semi-standby.
> 
> For low-performance operation I imagine that by using MERAM for frame
> buffer memory we can put the SDRAM in self-refresh mode and that way
> enter deep idle modes even though the screen is still operating.

I'm not sure that I follow your criteria for "low-performance
operation".  What do you define as low-performance?  Is this assuming
that we don't have (or disable) high-resolution (i.e. HDMI) secondary
output?
If so,it may be possible to dynamically reassign the area of the MERAM
that was allocated to HDMI for LCD output.  Otherwise the whole
framebuffer will not fit in MERAM and we'd have to revert to SDRAM.

> 
> The semi-standby would be that the "real" framebuffer is in say 32-bit
> RGB in SDRAM, but we keep a 8-bit RGB shadow buffer in MERAM and
> switch to that at the same instant we move from full backlight to low
> backlight. This is most likely useful only when combined with
> switching the LCD panel itself to 8-bit mode as well to save
> bandwidth.

By "keep an 8-bit RGB shadow buffer" are you talking about generating a
quantized version (RGB 332) of the "real" framebuffer in the MERAM when
we switch modes? It would be nice to be able to do such a conversion in
the hardware, but there currently isn't any support for VEU or the like
in the kernel.

> 
> Then you have your full-performance mode that I guess is what these
> patches implement. =)
> 
> Any ideas/suggestions about the low power LCDC modes?
> 
> Thanks,
> 
> / magnus

Thanks again for your feedback,
Damian
