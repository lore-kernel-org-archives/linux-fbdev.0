From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 25 Oct 2013 11:33:11 +0000
Subject: Re: [RFR 2/2] drm/panel: Add simple panel support
Message-Id: <1580941.z2CDo8WmRF@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381947912-11741-1-git-send-email-treding@nvidia.com> <3278905.VOXO7bPE7e@avalon> <526999DA.7080409@wwwdotorg.org>
In-Reply-To: <526999DA.7080409-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Stephen,

On Thursday 24 October 2013 23:06:18 Stephen Warren wrote:
> On 10/24/2013 12:20 PM, Laurent Pinchart wrote:
> > On Sunday 20 October 2013 23:07:36 Stephen Warren wrote:
> >> On 10/17/2013 12:07 PM, Laurent Pinchart wrote:
> >> ...
> >> 
> >>>> As I said, anything that really needs a CDF binding to work
> >>>> likely isn't "simple" anymore, therefore a separate driver can
> >>>> easily be justified.
> >>> 
> >>> The system as a whole would be more complex, but the panel could be
> >>> the same. We can't have two drivers for the same piece of hardware
> >>> in the DT world, as there will be a single compatible string and no
> >>> way to choose between the drivers (unlike the board code world that
> >>> could set device names to "foo- encoder-v4l2" or "foo-encoder-drm"
> >>> and live happily with that ever after).
> >> 
> >> That's not true. We can certainly define two different compatible
> >> values for a piece of HW if we have to. We can easily control whether
> >> they are handled by the same or different drivers in the OS.
> > 
> > From an implementation point of view, sure. But from a conceptual point of
> > view, that would make the DT bindings pretty Linux-specific, with a
> > description of what the operating system should do instead of a
> > description of what the hardware looks like. My understanding is that
> > we've tried pretty hard in the past not to open that Pandora's box.
> > 
> > The case I'm mostly concerned about would be two different compatibility
> > strings to select whether the device should be handled by a KMS or V4L
> > driver. I don't think that's a good idea.
> 
> I wouldn't think of the two compatible values as selecting different
> specific Linux drivers, but rather they simply describe the HW in
> different levels of detail. The fact that if we know a certain level of
> detail about the HW means that Linux can and does create a KMS driver
> rather than a V4L2 driver seems like a detail that's completely hidden
> inside the OS.

I expect the same level of details to be needed on both the KMS and V4L sides. 
Taking the example of the ADV7511 HDMI transmitter, the only change in the DT 
bindings between KMS and V4L would be the compatible string. "adi,adv7511-v4l" 
and "adi,adv7511-kms" is an option that I don't really like. Renaming -v4l and 
-kms to different names wouldn't fundamentally change the problem.

-- 
Regards,

Laurent Pinchart

