From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Thu, 23 Apr 2015 16:46:55 +0000
Subject: Re: [PATCH v3 05/17] video: fbdev: matrox: use arch_phys_wc_add() and ioremap_wc()
Message-Id: <20150423164655.GM5622@wotan.suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429647398-16983-1-git-send-email-mcgrof@do-not-panic.com>
 <1429647398-16983-6-git-send-email-mcgrof@do-not-panic.com>
 <alpine.DEB.2.10.1504231019190.3260@hadrien>
In-Reply-To: <alpine.DEB.2.10.1504231019190.3260@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia Lawall <julia.lawall@lip6.fr>, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, Rob Clark <robdclark@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Airlie <airlied@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, luto@amacapital.net, cocci@systeme.lip6.fr, Geert Uytterhoeven <geert@linux-m68k.org>, Mikulas Patocka <mpatocka@redhat.com>, Suresh Siddha <sbsiddha@gmail.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>, Antonino Daplas <adaplas@gmail.com>, linux-kernel@vger.kernel.org

On Thu, Apr 23, 2015 at 10:20:10AM +0200, Julia Lawall wrote:
> > @ mtrr_found @
> > expression index, base, size;
> > @@
> >
> > -index = mtrr_add(base, size, MTRR_TYPE_WRCOMB, 1);
> > +index = arch_phys_wc_add(base, size);
> >
> > @ mtrr_rm depends on mtrr_found @
> > expression mtrr_found.index, mtrr_found.base, mtrr_found.size;
> > @@
> >
> > -mtrr_del(index, base, size);
> > +arch_phys_wc_del(index);
> >
> > @ mtrr_rm_zero_arg depends on mtrr_found @
> > expression mtrr_found.index;
> > @@
> >
> > -mtrr_del(index, 0, 0);
> > +arch_phys_wc_del(index);
> >
> > @ mtrr_rm_fb_info depends on mtrr_found @
> > struct fb_info *info;
> 
> Is this specific to the fb_info type?
> 

Glad you asked. Technically all framebuffer drivers will have
the fb_info and they *should* fill this properly with the base
and length. More on this below though.

> 
> > expression mtrr_found.index;
> > @@
> >
> > -mtrr_del(index, info->fix.smem_start, info->fix.smem_len);
> > +arch_phys_wc_del(index);

Note: when I mention mtrr_add() I mean arch_phys_wc_add() as that
is what we have been changing the drivers to over the years and in
this series as well. Likewise for mtrr_del() there is arch_phys_wc_del(),
but since you might be revieiwng the code with mtrr_add() figured I'd
mention the current state of affairs prior to this set of series'
changes.

*Ideally* when the mtrr_add() or mtrr_del() call is made on framebuffer drivers
we'd be able to use info->fix.smem_start, info->fix.smem_len for those call's
purposes, where info is struct fb_info *info. I however did not find that to be
the case for all framebuffer device drivers, but it does not mean its not
possible. Even if its not possible for all framebuffer device drivers quite a
few do fall under this category and as such once all were vetted in grammar
form (maybe another cleanup on top of this series) I figured we could have
register_framebuffer() do the mtrr_add() call for drivers that need it by
simply setting a flag on a struct passed, likewise if such flag is set we'd
have the framebuffer core do the mtrr_del() later upon deregistration. I
considered doing this as another series but ran out of steam.

The only thing with this also though is we have DRM drivers and they have the DRM
core doing the mtrr stuff for them but I failed to complete the review there
and if we can just unify things for all framebuffer / DRM drivers I think that'd
be best, but it was also not clear if we want or if this is worth doing. Since
mtrr stuff is low hanging fruit and its all legacy stuff I didn't
bother to pursue more -- but in terms of grammar and cleanup there sure is
quite a bit of room left for love here. For a unified mtrr set of calls for
both framebuffer / DRM drivers it may be good to get guidance from fbdev / DRM
developers.

I hinted towards this on my original cover letter on the first version of
this series, see section d):

http://article.gmane.org/gmane.linux.kernel/1913979

BTW what I mean by "option" on that d) section of that cover letter I
mean all the driver string options passed to the driver, see matroxfb_setup()
for example, there is an option for mtrr.

  Luis
