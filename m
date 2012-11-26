From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 26 Nov 2012 15:34:53 +0000
Subject: Re: [PATCHv9 1/3] Runtime Interpreted Power Sequences
Message-Id: <20121126153453.2AA023E1AAA@localhost>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353149747-31871-1-git-send-email-acourbot@nvidia.com>
 <1353149747-31871-2-git-send-email-acourbot@nvidia.com>
 <20121120215429.B621F3E1821@localhost> <13540495.epaCf4JVn9@percival>
 <20121122133941.24B883E129E@localhost>
 <20121122214021.GA14771@avionic-0098.adnet.avionic-design.de>
In-Reply-To: <20121122214021.GA14771@avionic-0098.adnet.avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, 22 Nov 2012 22:40:21 +0100, Thierry Reding <thierry.reding@avionic-design.de> wrote:
> On Thu, Nov 22, 2012 at 01:39:41PM +0000, Grant Likely wrote:
> [...]
> > I do think that each sequence should be contained within a single
> > property, but I'm open to other suggestions.
> 
> IIRC a very early prototype did implement something like that. However
> because of the resource issues this had to be string based, so that the
> sequences looked somewhat like (Alex, correct me if I'm wrong):
> 
> 	power-on = <"REGULATOR", "power", 1, "GPIO", "enable", 1>;
> 
> Instead we could possibly have something like:
> 
> 	power-on = <0 &reg 1,
> 		    1 &gpio 42 0 1>;

Yes, that would work, although I still think it would be a good idea to
split the used resources off into the gpios/pwms/regs/etc properties.

> Where the first cell in each entry defines the type (0 = regulator, 1 > GPIO) and the rest would be a regular OF specifier for the given type of
> resource along with some defined parameter such as enable/disable,
> voltage, delay in ms, ... I don't know if that sounds any better. It
> looks sort of cryptic but it is more "in the spirit of" DT, right Grant?

It is still kind of a ham-handed approach, but it does fit better with
existing conventions than the hierarchy of nodes does.

g.
