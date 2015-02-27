From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 27 Feb 2015 02:05:21 +0000
Subject: Re: [PATCH 03/15] fbdev: aty128fb: replace PPC_OF with PPC
Message-Id: <1425002721.4645.43.camel@kernel.crashing.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
 <1422712065-9403-4-git-send-email-haokexin@gmail.com>
 <1424995875.4645.42.camel@kernel.crashing.org>
 <20150227010549.GA10596@pek-khao-d1.corp.ad.wrs.com>
In-Reply-To: <20150227010549.GA10596@pek-khao-d1.corp.ad.wrs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kevin Hao <haokexin@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Paul Mackerras <paulus@samba.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

On Fri, 2015-02-27 at 09:05 +0800, Kevin Hao wrote:
> On Fri, Feb 27, 2015 at 11:11:15AM +1100, Benjamin Herrenschmidt wrote:
> > On Sat, 2015-01-31 at 21:47 +0800, Kevin Hao wrote:
> > > The PPC_OF is a ppc specific option which is used to mean that the
> > > firmware device tree access functions are available. Since all the
> > > ppc platforms have a device tree, it is aways set to 'y' for ppc.
> > > So it makes no sense to keep a such option in the current kernel.
> > > Replace it with PPC.
> > > 
> > > Signed-off-by: Kevin Hao <haokexin@gmail.com>
> > 
> > For this and generally the whole series,
> > 
> > Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Thanks Ben.
> 
> > 
> > Which tree do we expect this to go through ?
> 
> I just sent out a v2 [1] a few hours earlier with some minor updates. We plan
> to merge this patch series via the powerpc tree in 4.1 cycle if I can collect
> all the acks from the corresponding driver maintainers.
> 
> [1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-February/125331.html

Anything I'm the maintainer by default for has my ack (radeonfb,
aty128fb, ...)

Cheers,
Ben.


