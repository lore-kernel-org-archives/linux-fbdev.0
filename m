From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 30 Apr 2015 20:20:44 +0000
Subject: Re: [PATCH v3] staging: sm750fb: use arch_phys_wc_add() and ioremap_wc()
Message-Id: <20150430202044.GC22039@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429647230-16870-1-git-send-email-mcgrof@do-not-panic.com>
 <CAB=NE6Vb-u05VZhm5KDnwxqYeDuJjhd89=mFmGJkofSg2y2rnw@mail.gmail.com>
In-Reply-To: <CAB=NE6Vb-u05VZhm5KDnwxqYeDuJjhd89=mFmGJkofSg2y2rnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: arnaud.patard@rtp-net.org, aaro.koskinen@iki.fi, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, Andy Lutomirski <luto@amacapital.net>, "cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Suresh Siddha <sbsiddha@gmail.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Airlie <airlied@redhat.com>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Apr 30, 2015 at 10:38:27AM -0700, Luis R. Rodriguez wrote:
> On Tue, Apr 21, 2015 at 1:13 PM, Luis R. Rodriguez
> <mcgrof@do-not-panic.com> wrote:
> > From: "Luis R. Rodriguez" <mcgrof@suse.com>
> >
> > The same area used for ioremap() is used for the MTRR area.
> > Convert the driver from using the x86 specific MTRR code to
> > the architecture agnostic arch_phys_wc_add(). arch_phys_wc_add()
> > will avoid MTRR if write-combining is available, in order to
> > take advantage of that also ensure the ioremap'd area is requested
> > as write-combining.
> >
> > There are a few motivations for this:
> >
> > a) Take advantage of PAT when available
> >
> > b) Help bury MTRR code away, MTRR is architecture specific and on
> >    x86 its replaced by PAT
> >
> > c) Help with the goal of eventually using _PAGE_CACHE_UC over
> >    _PAGE_CACHE_UC_MINUS on x86 on ioremap_nocache() (see commit
> >    de33c442e titled "x86 PAT: fix performance drop for glx,
> >    use UC minus for ioremap(), ioremap_nocache() and
> >    pci_mmap_page_range()")
> >
> > The conversion done is expressed by the following Coccinelle
> > SmPL patch, it additionally required manual intervention to
> > address all the #ifdery and removal of redundant things which
> > arch_phys_wc_add() already addresses such as verbose message
> > about when MTRR fails and doing nothing when we didn't get
> > an MTRR.
> >
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
> > expression mtrr_found.index;
> > @@
> >
> > -mtrr_del(index, info->fix.smem_start, info->fix.smem_len);
> > +arch_phys_wc_del(index);
> >
> > @ ioremap_replace_nocache depends on mtrr_found @
> > struct fb_info *info;
> > expression base, size;
> > @@
> >
> > -info->screen_base = ioremap_nocache(base, size);
> > +info->screen_base = ioremap_wc(base, size);
> >
> > @ ioremap_replace_default depends on mtrr_found @
> > struct fb_info *info;
> > expression base, size;
> > @@
> >
> > -info->screen_base = ioremap(base, size);
> > +info->screen_base = ioremap_wc(base, size);
> >
> > Generated-by: Coccinelle SmPL
> > Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> > Cc: Teddy Wang <teddy.wang@siliconmotion.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Suresh Siddha <sbsiddha@gmail.com>
> > Cc: Ingo Molnar <mingo@elte.hu>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Juergen Gross <jgross@suse.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Andy Lutomirski <luto@amacapital.net>
> > Cc: Dave Airlie <airlied@redhat.com>
> > Cc: Antonino Daplas <adaplas@gmail.com>
> > Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Cc: devel@driverdev.osuosl.org
> > Cc: linux-fbdev@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
> 
> Hey folks, just a follow up. Can this be considered to be merged?
> 
>  Luis

I'm just starting to get to staging tree patches after the -rc1 window
was over.  Give me a week or so, they are at the bottom of my list.

thanks,

greg k-h
