From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 20 Sep 2011 19:56:43 +0000
Subject: Re: [PATCH] fbdev: sh_mobile_lcdc: Turn dot clock on before resuming from runtime PM
Message-Id: <201109202156.44492.laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1310387754-23033-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1310387754-23033-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Florian,

On Tuesday 20 September 2011 21:52:36 Florian Tobias Schandinat wrote:
> On 09/20/2011 07:30 PM, Laurent Pinchart wrote:
> > On Monday 11 July 2011 14:35:54 Laurent Pinchart wrote:
> >> Resuming from runtime PM restores all LCDC registers. If the dot clock
> >> is off at that time display panning information will be corrupted.
> >> 
> >> Turn the dot clock on before resuming from runtime PM. Similarly,
> >> turn the clock off after suspending the LCDC.
> > 
> > Could you please pick this patch for v3.2 ?
> 
> I assume you meant the currently developed 3.1? (as 3.2 is the next one for
> which the patch is lying in my fbdev-next anyway)

No, I meant v3.2. As I haven't received any pull notification in response to 
the patch, and as I had no way to check your fbdev-next tree on kernel.org, I 
just wanted to make sure the patch would be queued for v3.2.

Please ignore this e-mail (and the other similar ones I've just sent) if the 
patches are already in your queue. And thank you for picking them.

> Uhm, I originally didn't plan to ask Linus pulling anything before getting
> rid of the old stuff, but okay, will go through my patches in the next
> days and look what else is appropriate unless Linus beats me and releases
> 3.1 (although I do not consider this likely as long as kernel.org is still
> down)

-- 
Regards,

Laurent Pinchart
