From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 20 Oct 2010 23:19:17 +0000
Subject: Re: [PATCH] fbdev: add a function to parse further EDID Detailed
Message-Id: <20101020161917.d0e526a3.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1008200847020.6103@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1008200847020.6103@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, 20 Oct 2010 17:12:05 +0200 (CEST)
Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:

> Hi Erik
> 
> On Fri, 20 Aug 2010, Erik Gilling wrote:
> 
> > Guennadi,
> >     Not sure how you're using the edid but you can get all 4 DTDs by
> > calling fb_edid_to_monspecs() then calling fb_videomode_to_var() on
> > each of the entries in monspecs.modedb.  This is still lacking as
> > modern monitors/tvs can have multiple EDID blocks.  My recent patch
> > [1] is a proposal for addressing that.
> 
> Thanks for your reply, yes, I did switch to using fb_edid_to_monspecs(), 
> which does just what I need. However, I would indeed need the extra modes 
> from extended EDID blocks, so, your patch would come in handy. What's its 
> status? There have been no comments and it's not in next. I would imagine, 
> that at least an EXPORT_SYNBOL() and a dummy version for when 
> CONFIG_FB_MODE_HELPERS is not set are missing in your patch, but otherwise 
> - are there any big objections? I.e., you just need to apply something 
> like the diff below. With it applied:
> 
> Tested-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> Andrew, would you be taking it after the above issues are corrected?

Sure.  Please cc me on the next version.

> As a TODO: are you planning to add parsing of SVDs to your E-EDID code?

