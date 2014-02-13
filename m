From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 13 Feb 2014 19:43:10 +0000
Subject: Re: Fixing the kernels backlight API
Message-Id: <52FD204E.40507@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <52FB8F45.9060006@redhat.com>
	<CAPM=9tyYLuoTtW69-cPx-JSuar++D5WEtYRZr_-aP7uowZpVyA@mail.gmail.com>
	<52FCCBA1.3070303@redhat.com> <20140213171932.GB4420@srcf.ucam.org>
In-Reply-To: <20140213171932.GB4420-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: "xorg-devel-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-devel-go0+a7rfsptAfugRpC6u6w@public.gmane.org>, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

Hi,

On 02/13/2014 06:19 PM, Matthew Garrett wrote:
> On Thu, Feb 13, 2014 at 02:41:53PM +0100, Hans de Goede wrote:
> 
>> I still believe we need to do better, but maybe that better needs to be done
>> in userspace rather then in the kernel.
> 
> One option is to put it on the connector but provide some mechanism for 
> userspace to define the relationship between platform/firmware 
> interfaces and connectors. We ought to be able to tie connectors into 
> the ACPI namespace and do a better job than we currently do with the 
> association between backlight and connector. The bigger problem is 
> figuring out how platform interfaces tie into things, and that's where 
> heuristics are probably going to be involved.

Right, but as Dave Airlie pointed out that means putting links between
two completely unrelated subsystems, causing locking and module load
ordering problems.

I can understand where Dave is coming from, from a kernel pov, so this
might really be easier to just solve in userspace. I don't know if you've
seen my very rough sketch of how this could work in userspace in my other
mail. The idea would be to still make this show up on a specific connector,
but only at the xrandr level, not at the drm level, and have the xserver
talk to some kind of backlightd for this.  The backlightd API should of cource
be generic enough that it can be used in wayland too.

This sounds like a reasonable and workable plan to me, but I must admit
I'm very naive when it comes to backlight stuff.

Regards,

Hans
