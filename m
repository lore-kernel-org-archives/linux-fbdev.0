From: Stephen Warren <swarren@wwwdotorg.org>
Date: Sun, 20 Oct 2013 22:07:36 +0000
Subject: Re: [RFR 2/2] drm/panel: Add simple panel support
Message-Id: <52645428.9080607@wwwdotorg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381947912-11741-1-git-send-email-treding@nvidia.com> <525FB368.6020003@ti.com> <20131017104856.GA10993@ulmo.nvidia.com> <3592147.9IprvsogX6@avalon>
In-Reply-To: <3592147.9IprvsogX6@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 10/17/2013 12:07 PM, Laurent Pinchart wrote:
...
>> As I said, anything that really needs a CDF binding to work
>> likely isn't "simple" anymore, therefore a separate driver can
>> easily be justified.
> 
> The system as a whole would be more complex, but the panel could be
> the same. We can't have two drivers for the same piece of hardware
> in the DT world, as there will be a single compatible string and no
> way to choose between the drivers (unlike the board code world that
> could set device names to "foo- encoder-v4l2" or "foo-encoder-drm"
> and live happily with that ever after).

That's not true. We can certainly define two different compatible
values for a piece of HW if we have to. We can easily control whether
they are handled by the same or different drivers in the OS.

Now, we should try to avoid this, because then that means that the
original binding wasn't fully describing the HW. However, at least in
the case of these simple LCD panels, it's hard to see that there is
anything more than what's already in Thierry's binding. Remember, the
binding is a description of the HW, not any Linux-internal details of
how e.g. a CDF or DRM subsystem is supposed to use the HW; that had
better be embodied into the driver or subsystem code, which aren't
ABIs, and hence can be easily modified/enhanced.
