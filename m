From: Olaf Hering <olh@suse.de>
Subject: Re: [Linux-fbdev-devel] Re: 2.6.11-rc5, rivafb i2c oops, bogus error handling
Date: Tue, 1 Mar 2005 13:02:21 +0100
Message-ID: <20050301120221.GA10091@suse.de>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org> <20050227203214.GA15572@suse.de> <200502282241.55815.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200502282241.55815.adaplas@hotpop.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-nvidia@lists.surfsouth.com, Kernel Mailing List <linux-kernel@vger.kernel.org>

 On Mon, Feb 28, Antonino A. Daplas wrote:

> On Monday 28 February 2005 04:32, Olaf Hering wrote:
> >  On Wed, Feb 23, Linus Torvalds wrote:
> > > This time it's really supposed to be a quickie, so people who can, please
> > > check it out, and we'll make the real 2.6.11 asap.
> >
> > Here is another one, probably not new.
> > Is riva_get_EDID_i2c a bit too optimistic by not having a $i2cadapter_ok
> > member in riva_par->riva_i2c_chan? It calls riva_probe_i2c_connector
> > even if riva_create_i2c_busses fails to register all 3 busses.
> >
> 
> Thanks,
> 
> Can you try this?
> 
> Fixed error handling in rivafb-i2c.c if bus registration fails.

I havent heard back from the reporter, yet.
