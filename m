From: Dave Airlie <airlied@redhat.com>
Date: Fri, 25 Feb 2011 01:14:59 +0000
Subject: Re: Linux 2.6.38-rc6
Message-Id: <1298596499.10585.27.camel@clockmaker-el6>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTi=TTZ57d1wUz1uH3R6igN8O77iDvSLMW=t86g9V@mail.gmail.com>
	 <20110222140349.GA20708@kryptos.osrc.amd.com>
	 <AANLkTikESHHfjBqoLFOno6qQz-NXEAo-wBY5JEeAW61N@mail.gmail.com>
	 <AANLkTinh4pF7iaUGMcv_9gPy+VBD5POsTHbF_2zPJ17r@mail.gmail.com>
	 <AANLkTi=Ys4mb4pc28cH4NMdtMgb2KewJbkXEGJmEP4J0@mail.gmail.com>
	 <AANLkTinxHVDwSCouTaZEvR3yTJnSPAas9z6JauGDdS7=@mail.gmail.com>
	 <AANLkTinD2cC9dGg2eBtZQhWvhSsuH2BcWDj8byLhWWso@mail.gmail.com>
	 <AANLkTin8+F003-jFoQ0pd9OjN1oT2iqyNjd58SDJZuMK@mail.gmail.com>
	 <AANLkTinzse1ZfEvAuWfuZ_8VDypcnD5poU6GwOdYTgWh@mail.gmail.com>
	 <AANLkTi=wbtcAOmYE8UF7ynPZ_nR3ZXxVRBcuMVGNK4u0@mail.gmail.com>
	 <AANLkTin7+AHAqKz5T-1_=N6tqPytyT4ooqyJuhHC6ET=@mail.gmail.com>
In-Reply-To: <AANLkTin7+AHAqKz5T-1_=N6tqPytyT4ooqyJuhHC6ET=@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Anca Emanuel <anca.emanuel@gmail.com>, linux-fbdev@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>, dri-devel@lists.freedesktop.org, Borislav Petkov <bp@amd64.org>, Herton Ronaldo Krzesinski <herton.krzesinski@canonical.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, 2011-02-24 at 16:54 -0800, Linus Torvalds wrote:
> On Thu, Feb 24, 2011 at 4:48 PM, Anca Emanuel <anca.emanuel@gmail.com> wrote:
> >
> > diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
> > index e2bf953..e8f8925 100644
> > --- a/drivers/video/fbmem.c
> > +++ b/drivers/video/fbmem.c
> > @@ -1511,6 +1511,7 @@ void remove_conflicting_framebuffers(struct
> > apertures_struct *a,
> >                               "%s vs %s - removing generic driver\n",
> >                               name, registered_fb[i]->fix.id);
> >                        unregister_framebuffer(registered_fb[i]);
> > +                       registered_fb[i] = NULL;
> >
> > Tested the patch, and now I get this:
> > dmesg: http://pastebin.com/ieMNrA7C
> >
> > [   12.252328] BUG: unable to handle kernel NULL pointer dereference
> > at 00000000000003b8
> > [   12.252342] IP: [<ffffffff81311178>] fb_mmap+0x58/0x1d0
> 
> Ok, goodie.
> 
> Or not so goodie, but it does make it clear that yeah, the fb code
> seems to be using stale pointers from that registered_fb[] array, and
> the whole unregistration process is just racing with people using it.
> 
> Herton had that much bigger patch, can you test it?

I think Andy's patch worked, not sure why it fell between the cracks,
either didn't appear on lkml or in my inbox at all.

if we can get Herton to repost it properly + a tested by I'm happy for
it to go in.

Dave.

