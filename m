From: Yauhen Kharuzhy <jekhor@gmail.com>
Date: Wed, 19 May 2010 06:25:02 +0000
Subject: Re: s3c-fb updates
Message-Id: <20100519062501.GA1429@jeknote.loshitsa1.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1274180045-14645-1-git-send-email-ben-linux@fluff.org>
	<AANLkTinXI9Fgqk8juRNpAA4nxsDnL82CMXwYThZo6y1l@mail.gmail.com>
	<20100519004519.GB4720@trinity.fluff.org>
In-Reply-To: <20100519004519.GB4720@trinity.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, May 19, 2010 at 01:45:19AM +0100, Ben Dooks wrote:
> On Tue, May 18, 2010 at 11:35:00PM +0900, Kyungmin Park wrote:
> > Hi,
> > 
> > On Tue, May 18, 2010 at 7:54 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> > > Updates for the s3c-fb to improbe the build and update support
> > > for s5pv210 and s3c2416 devices.
> > >
> > > The dependency on Inki Dae's patches have been removed since they've
> > > not been reposted, and at-least one causes build failures.
> > 
> > Ben please check your mailbox again. He sent it after your reply.
> 
> no, what he sent was three patch files attached to a mail[1] which
> Andrew Morton replied to saying that these needed to be sent as proper
> patches with descriptions and other such things that patches have.
>  
> > Anyway, how do you integrate the FIMD and FIMC features in current
> > driver? Any plans?
> 
> I've been discussiong things with the engineers here. However, the first
> thing is to get the driver closer aligned to the one that Sys.LSI have
> been shipping, which means getting some missing features sorted out.
> 
> By the way, which is the FIMC block? I've not seen any documentation
> referencing this as an block in the SoC.
FIMC is a camera interface block. It can output video stream directly to
display controller FIFO.

-- 
Yauhen Kharuzhy		jekhor _at_ gmail.com
			JID: jek@jabber.ru

A: No
Q: Should I quote below my post?
