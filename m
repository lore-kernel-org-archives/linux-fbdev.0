From: Kevin Hilman <khilman@deeprootsystems.com>
Date: Wed, 10 Oct 2012 18:12:04 +0000
Subject: Re: [PATCHv2 1/3] OMAP: VRFB: convert vrfb to platform device
Message-Id: <87wqyyxkln.fsf@deeprootsystems.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1349785827-27055-1-git-send-email-tomi.valkeinen@ti.com>
	<1349785827-27055-2-git-send-email-tomi.valkeinen@ti.com>
	<87fw5n1iwh.fsf@deeprootsystems.com> <1349842027.5972.8.camel@lappyti>
In-Reply-To: <1349842027.5972.8.camel@lappyti> (Tomi Valkeinen's message of
	"Wed, 10 Oct 2012 07:07:07 +0300")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Archit Taneja <archit@ti.com>

Tomi Valkeinen <tomi.valkeinen@ti.com> writes:

> On Tue, 2012-10-09 at 13:37 -0700, Kevin Hilman wrote:
>> Hi Tomi,
>> 
>> Tomi Valkeinen <tomi.valkeinen@ti.com> writes:
>> 
>> > This patch converts vrfb library into a platform device, in an effort to
>> > remove omap dependencies.
>> >
>> > The platform device is registered in arch/arm/plat-omap/fb.c and
>> > assigned resources depending on whether running on omap2 or omap3.
>> >
>> > The vrfb driver will parse those resources and use them to access vrfb
>> > configuration registers and the vrfb virtual rotation areas.
>> >
>> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> > Cc: Tony Lindgren <tony@atomide.com>
>> 
>> [...]
>> 
>> I was having a quick look at this for the context save/restore piece in
>> order to understand how this driver's context is being saved/restored.
>> 
>> Looking at mainline, I don't see where omap_vrfb_restore_context() is
>> being called currently.  Am I missing something?
>
> No, the driver is missing something. I noticed the same thing. It seems
> ctx restore for vrfb has never been functional in mainline. I don't
> really have any recollection if this was left out intentionally from
> mainline (possibly because we didn't have a good way to handle it at
> that point), or was it just a mistake.
>
> Nobody has complained about it, though, so it can't be a major problem
> =).

heh

> Vrfb is a platform device/driver after this patch. Do you see any
> problem with handling the context restore in runtime PM's runtime_resume
> callback? 

No, that's the right way to handle it IMO.  In fact, that's what I was
going to check on when reviewing this patch when I noticed that the
restore function wasn't being used.

> Hmm, I guess then we could have a problem if omapdss and
> omapfb are resumed before vrfb.

Possibly, but this could be handled by adding some sanity checks, or
having VRFB functions return -EAGAIN if it hasn't been resumed.  Or
better yet, VRFB functions should be using runtime PM get/put
themselves, if they're used by omapdss/omapfb, a runtime resume (and
context restore) is forced.  (disclaimer: I don't actually know how VRFB
works, so maybe this isn't possible.)

> Any way to manage the suspend/resume ordering of unrelated (i.e. no
> parent/child relation) devices?

No good way at the moment.

And to make things interesting: static suspend/resume ordering is not
dependent on parent/child.  It's based on driver discover/probe order.

runtime PM ordering manages parent/child relationships.

Kevin
