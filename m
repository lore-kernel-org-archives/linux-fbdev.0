From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 09 Dec 2016 08:13:35 +0000
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
Message-Id: <20161209081335.q2bnqmtoo2xtcgri@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
 <1481158879.26959.41.camel@kernel.crashing.org>
 <035da7a8-5a3f-1ef6-f686-479773e78084@ti.com>
 <1481232210.26959.47.camel@kernel.crashing.org>
 <1481233393.26959.53.camel@kernel.crashing.org>
In-Reply-To: <1481233393.26959.53.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fbdev@vger.kernel.org, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnaud Patard <arnaud.patard@rtp-net.org>

On Fri, Dec 09, 2016 at 08:43:13AM +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2016-12-09 at 08:23 +1100, Benjamin Herrenschmidt wrote:
> > > From memory, David claimed you cannot directly work on the fb with a "proper"
> > 
> > DRM driver. Maybe I misunderstood but then the DRM shines by its complete
> > absence of useful documentation 
> 
> That sentence should have been in the past, it does look like
> documentation has been landing in the tree this year ! yay ! I'll go
> off read it.

We've been building up that documentation for years now, not sure where
exactly you've looked in the past ;-)

And to make sure you're looking at the right stuff: Please run

$ make DOCBOOKS="" htmldocs

and then look at Documentation/output/gpu. Otherwise all the kerneldoc
stuff isn't pulled in, and a lot of the overview sections (not just
abi/struct docs) are in there.

And if something looks fishy or doesn't make sense, please raise it here
or on #dri-devel on freenode so that we can improve the docs.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
