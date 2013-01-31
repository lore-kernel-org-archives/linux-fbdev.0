From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 31 Jan 2013 04:14:21 +0000
Subject: Re: [RFC 1/4] video: panel: add CLAA101WA01A panel support
Message-Id: <CAAVeFuJkJ4cftWvSvt1YJa6c48JyJPVTu=i18yMHptZMi3DAzg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1359514939-15653-1-git-send-email-acourbot@nvidia.com>
 <1359514939-15653-2-git-send-email-acourbot@nvidia.com> <51098229.7080508@wwwdotorg.org>
In-Reply-To: <51098229.7080508-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

On Thu, Jan 31, 2013 at 5:27 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> So this looks like a reasonable binding to me. The one issue is that
> it's very generic, and if we go this route, we'll probably end up with
> tens or hundreds of identical or extremely similar simple bindings, and
> associated drivers.
>
> We can avoid this instead by defining something like a "simple-lcd"
> binding, and associated driver, that will work for perhaps 90%, 95%,
> 99%, even 100%(?) of panels.

That seems totally doable indeed. Actually the right way to do this
might be by extending the simple DPI panel driver Laurent included in
his patchset.

> Just like the above, but with:
>
> compatible="simple-panel", "chunghwa,claa101wa01a"
>
> instead, and the driver binding to "simple-panel" rather than
> "chunghwa,claa101wa01a".

Just out of curiosity, why don't we rather define

compatible="chunghwa,claa101wa01a", "simple-panel"

in that order? I thought DT compatible strings should go from more to
less specific. The device would still bind to "simple-panel" if no
more specific driver exists.

> The driver can assume that a specific set of supplies (and perhaps
> GPIOs) is always present, and that the /sequence/ of manipulating those
> is fixed. This will avoid the need for anything like the power sequences
> code. If a particular panel doesn't fit those assumptions, including the
> exact sequence of manipulations for each state transition (which should
> be documented in the binding) then it can get a custom driver, this also
> avoiding having to define custom sequences in DT.
>
> Things that might be parameterized/optional:
>
> * Perhaps some GPIOs aren't always present.
> * If some regulators aren't SW-controllable, DT should still provide a
> fixed/dummy regulator so the driver doesn't care.

How about making all regulators and GPIO optional in the driver?

> * Wait times between regulator/GPIO/... manipulation could be specified
> in DT.
> * For panels without EDID, CDF DT bindings can provide the list of
> supported modes, otherwise we assume that the display controller that
> drives the panel has been told how to access the EDID, just like it
> would for an "external" display.

Excellent. Thanks for the feedback.

Alex.
