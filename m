From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: radeon, apertures & memory mapping
Date: Mon, 14 Mar 2005 11:54:49 +1100
Message-ID: <1110761689.5787.202.camel@gaston>
References: <1110677744.19810.80.camel@gaston>
	<20050313103936.GA11002@sci.fi> <1110715499.14684.132.camel@gaston>
	<9e473391050313081937cde207@mail.gmail.com>
	<1110750553.5787.155.camel@gaston>
	<9e47339105031314101c89e50e@mail.gmail.com>
	<1110752401.19810.177.camel@gaston>
	<9e47339105031315002a444f00@mail.gmail.com>
	<20050313232735.GA19781@sci.fi> <1110757699.5787.196.camel@gaston>
	<9e47339105031316254524f72@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <9e47339105031316254524f72@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, dri-devel@lists.sourceforge.net, xorg@lists.freedesktop.org

On Sun, 2005-03-13 at 19:25 -0500, Jon Smirl wrote:
> On Mon, 14 Mar 2005 10:48:19 +1100, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > 
> > > > That shouldn't matter the page brought in would be for a speculative
> > > > read and never accessed. It should just fall out of the cache and not
> > > > be written back. There is only one cachable mapping. In this model
> > > > writes are always followed by a flush before telling the GPU to access
> > > > the memory that has just been written.
> > >
> > > What about this scenario?
> > >
> > > Speculative read -> AGP master writes new data -> CPU has invalid data in
> > > cache :(
> > 
> 
> You need to reverse the cache flush process if you are going to read
> data written by the GPU.
> 
> 1) Make sure GPU is finished writing
> 2) flush your cache
> 3) read AGP memory like normal RAM.

We call that kind of flush an "invalidate" in fact :)

Ben.
