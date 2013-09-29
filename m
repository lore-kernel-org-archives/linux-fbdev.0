From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 29 Sep 2013 07:03:41 +0000
Subject: Re: [PATCH v2] pwm-backlight: allow for non-increasing brightness levels
Message-Id: <2374392.UQj3ulSGQM@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1379869196-19377-1-git-send-email-mikedunn@newsguy.com> <524423B6.4070609@ti.com> <017a01cebb31$9df90f60$d9eb2e20$%han@samsung.com>
In-Reply-To: <017a01cebb31$9df90f60$d9eb2e20$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: 'Tomi Valkeinen' <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, 'Thierry Reding' <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, 'Mike Dunn' <mikedunn-kFrNdAxtuftBDgjK7y7TUQ@public.gmane.org>, 'Richard Purdie' <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, 'Jean-Christophe Plagniol-Villard' <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, 'Grant Likely' <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Rob Herring' <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Robert Jarzmik' <robert.jarzmik-GANU6spQydw@public.gmane.org>, 'Marek Vasut' <marex-ynQEQJNshbs@public.gmane.org>, 'Laurent Pinchart' <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

Hi Jingoo,

On Friday 27 September 2013 12:28:21 Jingoo Han wrote:
> On Thursday, September 26, 2013 9:08 PM, Tomi Valkeinen wrote:
> > On 26/09/13 14:51, Thierry Reding wrote:
> > > On Thu, Sep 26, 2013 at 01:03:06PM +0300, Tomi Valkeinen wrote:
> > > [...]
> > > 
> > >> But if you and Thierry think this version is good, I'll take it.
> > > 
> > > That sounds like you want to take it through the fbdev tree. Jingoo is
> > > listed (along with Richard, but he hasn't been responsive to email for
> > > years) as maintainer for the backlight subsystem. Furthermore back at
> > 
> > Ah, so they are. I just thought it falls under fbdev, as it's under
> > drivers/video/ =).
> > 
> > I don't have any particular "want" to take it through fbdev tree. But I
> > can take it.
> > 
> > > the time when I began working on the PWM subsystem, the backlight sub-
> > > system was pretty much orphaned, and pwm-backlight was by far the
> > > biggest user of the PWM subsystem. I adopted the driver at the time
> > > because it needed to be updated for PWM subsystem changes.
> > > 
> > > What's the plan going forward? Given the coupling between the PWM
> > > subsystem and the pwm-backlight driver it might be useful to keep
> > > maintaining it as part of the PWM subsystem. On the other hand, there's
> > > some coupling between the driver and the backlight subsystem too.
> > 
> > And backlight is coupled with fbdev... Which is something I don't like.
> 
> +cc Laurent Pinchart,
> 
> Yes, right.
> The backlight should be de-coupled with fbdev.
> I remember that Laurent Pinchart was doing this patch.
> 
> Laurent Pinchart,
> Would you let us know your plan about this? :-)

My plans include finishing CDF first :-) I thus don't know when I'll have time 
to tackle this task. Feel free to pick it but. If you do, I would appreciate 
if you could discuss your ideas with me.

> > > I have a couple of patches queued up for 3.13 that rework parts of the
> > > driver, so it'd be good to know how you guys want to handle this.
> > 
> > Well. I'm happy if somebody wants to maintain the backlight side. In
> > fact, I'd be happy if somebody would start restructuring it totally,
> > it's rather messy. The link with fbdev should be removed, and some
> > backlight drivers are actually panel drivers. However, perhaps Common
> > Display Framework is required until it can be fully cleaned.
> 
> I think that some backlight drivers can be moved to 'Common Display
> Framework', after 'Common Display Framework' is merged.
> But, I am not sure, when it will be completed.

Hardware backlight devices don't process video streams, so they don't really 
belong to CDF, at least to the CDF that we know today. However, a hardware 
panel device that integrates a backlight would be supported by a CDF driver, 
which would create a Linux backlight device.

> > So... For the time being, I'm fine with merging pwm-backlight via any
> > tree that works best. I'm presuming here that backlight framework and
> > fbdev (for the parts that are relevant for backlight) are not really
> > being changed, so there shouldn't be conflicts.

-- 
Regards,

Laurent Pinchart

