From: Dave Airlie <airlied@gmail.com>
Date: Thu, 17 Oct 2013 08:28:23 +0000
Subject: Re: [RFR 2/2] drm/panel: Add simple panel support
Message-Id: <CAPM=9tzU36cwcM0pH0J_Vgc6UOj5MHdVNDvn3wpGNuihbMqdQQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381947912-11741-1-git-send-email-treding@nvidia.com>
	<1381947912-11741-3-git-send-email-treding@nvidia.com>
	<1695169.rzbDl9PeRX@avalon>
In-Reply-To: <1695169.rzbDl9PeRX@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

>
> My biggest concern here is that this will not be compatible with the CDF DT
> bindings. They're not complete yet, but they will require connections between
> entities to be described in DT, in a way very similar (or actually identical)
> to the V4L2 DT bindings, documented in
> Documentation/devicetree/bindings/media/video-interfaces.txt. Could you have a
> look at that ? Please ignore all optional properties beside remote-endpoint,
> as they're V4L2 specific.
>
> I also plan to specify video bus parameters in DT for CDF, but this hasn't
> been finalized yet.
>

While I understand this, I don't see why CDF can't enhance these
bindings if it has
requirements > than they have without disturbing the panel ones,

is DT really that inflexible?

It seems that have a simple description for basic panels like Thierry wants
to support, that can be enhanced for the other cases in the future should
suffice, I really don't like blocking stuff that makes things work on the chance
of something that isn't upstream yet, its sets a bad precedent, its also breaks
the perfect is the enemy of good rule

Dave.
