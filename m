From: Alex Courbot <acourbot@nvidia.com>
Date: Mon, 26 Nov 2012 11:49:53 +0000
Subject: Re: [PATCHv9 1/3] Runtime Interpreted Power Sequences
Message-Id: <3319894.UD2L7QhyVv@percival>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353149747-31871-1-git-send-email-acourbot@nvidia.com>
 <20121122133941.24B883E129E@localhost>
 <20121122214021.GA14771@avionic-0098.adnet.avionic-design.de>
In-Reply-To: <20121122214021.GA14771@avionic-0098.adnet.avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Friday 23 November 2012 05:40:21 Thierry Reding wrote:
> On Thu, Nov 22, 2012 at 01:39:41PM +0000, Grant Likely wrote:
> [...]
> 
> > I do think that each sequence should be contained within a single
> > property, but I'm open to other suggestions.
> 
> IIRC a very early prototype did implement something like that. However
> because of the resource issues this had to be string based, so that the
> sequences looked somewhat like (Alex, correct me if I'm wrong):
> 
> 	power-on = <"REGULATOR", "power", 1, "GPIO", "enable", 1>;

You're right. Back when the burning sun of July was beating down a little bit 
too hard on my head.

https://lkml.org/lkml/2012/7/9/30

> Instead we could possibly have something like:
> 
> 	power-on = <0 &reg 1,
> 		    1 &gpio 42 0 1>;
> 
> Where the first cell in each entry defines the type (0 = regulator, 1 > GPIO) and the rest would be a regular OF specifier for the given type of
> resource along with some defined parameter such as enable/disable,
> voltage, delay in ms, ... I don't know if that sounds any better. It
> looks sort of cryptic but it is more "in the spirit of" DT, right Grant?
> 
> Writing this down, it seems to me like even that proposal was already
> discussed at some point. Again, Alex may remember better.

The idea that we had was to use preprocessor support in DTC to use macros 
instead of strings for the step type. We also thought about using phandles 
directly in there as well, but this would require some more API support.

Anyway, at the current point we are not even sure whether we want or need 
power seqs in the DT - so let's keep this topic on hold for a while. We can 
still introduce the feature without DT support, and if it eventually turns out 
during this winter that expressing power seqs in the DT makes sense, we will 
have plenty of archives to read in front of the fire.

Alex.

