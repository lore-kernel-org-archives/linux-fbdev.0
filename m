From: Samuel Ortiz <sameo@linux.intel.com>
Date: Fri, 22 Mar 2013 14:09:06 +0000
Subject: Re: [PATCH v2] mfd: as3711: add OF support
Message-Id: <20130322140906.GA13778@zurbaran>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1302181049510.4526@axis700.grange>
 <20130302041547.GJ6610@opensource.wolfsonmicro.com>
 <Pine.LNX.4.64.1303202034090.24222@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1303202034090.24222@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, devicetree-discuss@lists.ozlabs.org, Liam Girdwood <lrg@ti.com>, Richard Purdie <rpurdie@rpsys.net>, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev@vger.kernel.org

Hi Guennadi,

On Wed, Mar 20, 2013 at 08:40:15PM +0100, Guennadi Liakhovetski wrote:
> Hi all
> 
> On Sat, 2 Mar 2013, Mark Brown wrote:
> 
> > On Mon, Feb 18, 2013 at 10:57:44AM +0100, Guennadi Liakhovetski wrote:
> > > Add device-tree bindings to the AS3711 regulator and backlight drivers.
> > 
> > Reviwed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> This patch has been submitted more than a month ago and only has got one 
> reviewed-be (thanks) and no comments otherwise. The patch touches multiple 
> subsystems, so, it is a bit difficult to decide via which tree it should 
> be pushed. Since the least trivial and largest portion of the patch is 
> backlight-related, maybe Samuel could add his ack and then Andrew could 
> pull it via his tree?
We could do that, yes. But it also seems to me that this patch could be split
into 3 different ones that could go in via their own trees. Is there a runtime
dependency that I'm missing here ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
