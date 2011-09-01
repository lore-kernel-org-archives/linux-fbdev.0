From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 01 Sep 2011 13:27:03 +0000
Subject: Re: [PATCH] fbdev: fix parsing of standard timings
Message-Id: <1314883623.1933.10.camel@deskari>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1314362328-30456-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1314362328-30456-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, 2011-09-01 at 13:10 +0000, Florian Tobias Schandinat wrote:
> On 08/30/2011 05:31 AM, Tomi Valkeinen wrote:
> > Hi Florian,
> > 
> > On Fri, 2011-08-26 at 18:02 +0000, Florian Tobias Schandinat wrote:
> >> Hi Tomi,
> >>
> >> On 08/26/2011 12:38 PM, Tomi Valkeinen wrote:
> >>> The standard timings parses uses 1:1 dimensions when the ratio in the
> >>> EDID data is 0. However, for EDID 1.3 and later the dimensions are 16:10
> >>> when the ratio is 0.
> >>>
> >>> Pass the version and revision numbers to get_std_timing() which can then
> >>> make the right decision about dimensions.
> >>>
> >>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> >>
> >> Thanks, looks good to me.
> >> I'd be happy if someone with access to the original EDID specs could confirm
> >> this and add his reviewed by.
> >> I also think adding a comment explaining this change would be helpful.
> > 
> > You can see the same thing done in
> > drivers/gpu/drm/drm_edid.c:drm_mode_std(). Although they seem to check
> > only revision, which looks a bit risky to me.
> > 
> > The specs seem to be available by just googling them, although I don't
> > know if it's legal to distribute them or not...
> > 
> > I've added your comment, I agree it's good. Patch below.
> 
> Looks like your googling is better than mine, I only found references to it.

=). Try "e-edid standard pdf" or "edid standard pdf".

> Anyway, I've applied this patch.

Thanks!

 Tomi


