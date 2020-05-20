From: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 20 May 2020 06:13:56 +0000
Subject: Re: [RFC PATCH 1/4] gpu: dxgkrnl: core code
Message-Id: <20200520061356.GA2269481@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200519163234.226513-1-sashal@kernel.org>
 <20200519163234.226513-2-sashal@kernel.org>
 <20200519172105.GB1101627@kroah.com>
 <20200519174553.GF33628@sasha-vm>
In-Reply-To: <20200519174553.GF33628@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sasha Levin <sashal@kernel.org>
Cc: linux-hyperv@vger.kernel.org, sthemmin@microsoft.com, tvrtko.ursulin@intel.com, haiyangz@microsoft.com, spronovo@microsoft.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, chris@chris-wilson.co.uk, wei.liu@kernel.org, linux-fbdev@vger.kernel.org, iourit@microsoft.com, alexander.deucher@amd.com, kys@microsoft.com, Hawking.Zhang@amd.com

On Tue, May 19, 2020 at 01:45:53PM -0400, Sasha Levin wrote:
> On Tue, May 19, 2020 at 07:21:05PM +0200, Greg KH wrote:
> > On Tue, May 19, 2020 at 12:32:31PM -0400, Sasha Levin wrote:
> > > +
> > > +#define DXGK_MAX_LOCK_DEPTH	64
> > > +#define W_MAX_PATH		260
> > 
> > We already have a max path number, why use a different one?
> 
> It's max path for Windows, not Linux (thus the "W_" prefix) :)

Ah, not obvious :)

> Maybe changing it to WIN_MAX_PATH or such will make it better?

Probably.

> > > +#define d3dkmt_handle		u32
> > > +#define d3dgpu_virtual_address	u64
> > > +#define winwchar		u16
> > > +#define winhandle		u64
> > > +#define ntstatus		int
> > > +#define winbool			u32
> > > +#define d3dgpu_size_t		u64
> > 
> > These are all ripe for a simple search/replace in your editor before you
> > do your next version :)
> 
> I've actually attempted that, and reverted that change, mostly because
> the whole 'handle' thing became very confusing.

Yeah, "handles" in windows can be a mess, with some being pointers and
others just integers.  Trying to make a specific typedef for it is
usually the better way overall, that way you can get the compiler to
check for mistakes.  These #defines will not really help with that.

But, 'ntstatus' should be ok to just make "int" everywhere, right?

> Note that we have a few 'handles', each with a different size, and thus
> calling get_something_something_handle() type of functions becase very
> confusing since it's not clear what handle we're working with in that
> case.

Yeah, typedefs can help there.

> With regards to the rest, I wanted to leave stuff like 'winbool' to
> document the expected ABI between the Windows and Linux side of things.
> Ideally it would be 'bool' or 'u8', but as you see we had to use 'u32'
> here which I feel lessens our ability to have the code document itself.

'bool' probably will not work as I think it's compiler dependent, __u8
is probably best.

thanks,

greg k-h
