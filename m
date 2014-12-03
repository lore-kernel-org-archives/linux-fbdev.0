From: David Ung <davidu@nvidia.com>
Date: Wed, 03 Dec 2014 01:16:30 +0000
Subject: RE: [PATCH] video: fbmon: Check Standard Timing against DMT and maxclk
Message-Id: <079115258a0d482f80b043cd57ada820@HQMAIL102.nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1416626512-12919-1-git-send-email-davidu@nvidia.com>
In-Reply-To: <1416626512-12919-1-git-send-email-davidu@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Ping?

> -----Original Message-----
> From: David Ung [mailto:davidu@nvidia.com]
> Sent: Friday, November 21, 2014 7:22 PM
> To: plagnioj@jcrosoft.com; tomi.valkeinen@ti.com
> Cc: linux-fbdev@vger.kernel.org; David Ung
> Subject: [PATCH] video: fbmon: Check Standard Timing against DMT and
> maxclk
> 
> fbmon may generate mode timings that are out of spec of the monitor.
> eg DELL U2410 has a max clock 170mhz but advertises a resolutions of
> 1920x1200@60 in its Standard Timings, fbmon creates a mode using the
> GTF timing calculation which gave it a 193mhz clock.
> This patch add the VESA Display Monitor Timing (DMT) table.
> During parsing of Standard Timings, it compare the 2 byte STD code
> with DMT to see what the VESA mode should be.  If there is no entry
> in the vesa_modes table or no match found, it fallsback to the GTF
> timings.  A final check to see if the mode can be supported by the
> monitor by comparing against monspecs.dclkmax.
> 
> Signed-off-by: David Ung <davidu@nvidia.com>
> ---

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
