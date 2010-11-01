From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 01 Nov 2010 17:42:17 +0000
Subject: Re: [PATCH 1/4] video: add fb_edid_add_monspecs for parsing
Message-Id: <20101101104217.1eb8ff0b.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1010281427240.1257@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1010281427240.1257@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, 1 Nov 2010 16:57:00 +0100 (CET) Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:

> Hi Andrew
> 
> On Thu, 28 Oct 2010, Andrew Morton wrote:
> 
> > On Thu, 28 Oct 2010 14:34:44 +0200 (CEST)
> > Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> > 
> > > From: Erik Gilling <konkers@android.com>
> 
> Thanks for your comments. My plan is to add my S-o-b to this patch from 
> Erik, but otherwise leave it unchanged, because that's what the 2nd patch 
> in this series is for - for fixes and improvements. So, I'll address all 
> your comments in it, is this ok with you?
> 

Yes, that's OK.

It's unusual to do things this way - normally I'd just clump Erik's
patch and your changes to it into a single commit.  So we end up with
something which can be more effectively reviewed and a cleaner kernel
history.

But that's not a terribly important thing - if for some particular
reason you want to do it this way then that's OK by me.
