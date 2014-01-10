From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Fri, 10 Jan 2014 12:46:53 +0000
Subject: Re: [PATCHv5][ 1/5] fbdev: Add the lacking FB_SYNC_* for matching the DISPLAY_FLAGS_*
Message-Id: <20140110124653.GA15937@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1383915693-9422-1-git-send-email-denis@eukrea.com>
 <52CFE994.8070701@ti.com>
In-Reply-To: <52CFE994.8070701@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Jan 10, 2014 at 02:37:40PM +0200, Tomi Valkeinen wrote:
> I don't think this is better than the previous version where
> FB_SYNC_DE_HIGH_ACT and FB_SYNC_PIXDAT_HIGH_ACT were in
> include/uapi/linux/fb.h. Now those flag defines are not visible to the
> userspace, but the actual flags are still visible from the var->sync field.
> 
> It's true what Russell replied to the previous version, that the
> userspace has no idea how to handle those new flags. But then again, for
> LCDs, the userspace has no idea how to handle, say, hsync polarity either.
> 
> In any case, splitting the FB_SYNC_ defines into uapi and
> kernel-internal header files, but still giving the kernel-internal
> values to userspace is surely wrong.

The difference between the sync states and these other flags is that
the sync states are part of the mode definition - as per the CEA-861
documentation.

However, that does not extend to LCD panels, which generally need to
have one set of timings, with the various control signals at certain
polarities - and those control signal polarities are a property of
the panel itself, not of the displayed mode.  So, if you know that
you have LCD panel X, and it needs control signals with a certain
polarity, that is how you configure the hardware _irrespective_ of
what userspace says that the sync states should be.

The sync states specified by userspace should of course be used for
the sync pulses being sent to a VGA display or HDMI sink.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
