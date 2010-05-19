From: Ben Dooks <ben-linux@fluff.org>
Date: Wed, 19 May 2010 00:45:19 +0000
Subject: Re: s3c-fb updates
Message-Id: <20100519004519.GB4720@trinity.fluff.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1274180045-14645-1-git-send-email-ben-linux@fluff.org>
	<AANLkTinXI9Fgqk8juRNpAA4nxsDnL82CMXwYThZo6y1l@mail.gmail.com>
In-Reply-To: <AANLkTinXI9Fgqk8juRNpAA4nxsDnL82CMXwYThZo6y1l@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, May 18, 2010 at 11:35:00PM +0900, Kyungmin Park wrote:
> Hi,
> 
> On Tue, May 18, 2010 at 7:54 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> > Updates for the s3c-fb to improbe the build and update support
> > for s5pv210 and s3c2416 devices.
> >
> > The dependency on Inki Dae's patches have been removed since they've
> > not been reposted, and at-least one causes build failures.
> 
> Ben please check your mailbox again. He sent it after your reply.

no, what he sent was three patch files attached to a mail[1] which
Andrew Morton replied to saying that these needed to be sent as proper
patches with descriptions and other such things that patches have.
 
> Anyway, how do you integrate the FIMD and FIMC features in current
> driver? Any plans?

I've been discussiong things with the engineers here. However, the first
thing is to get the driver closer aligned to the one that Sys.LSI have
been shipping, which means getting some missing features sorted out.

By the way, which is the FIMC block? I've not seen any documentation
referencing this as an block in the SoC.

As such I will try and see if Pawel's previous patcehs that got missed
can be merged into this tree and into the kernel this round.

[1] http://lkml.org/lkml/2010/5/7/63

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

