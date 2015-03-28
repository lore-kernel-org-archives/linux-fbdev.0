From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Date: Sat, 28 Mar 2015 12:23:34 +0000
Subject: Re: [PATCH v1 09/47] vidoe: fbdev: atyfb: remove and fix MTRR MMIO "hole" work around
Message-Id: <20150328122334.GA32543@sci.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
 <1426893517-2511-10-git-send-email-mcgrof@do-not-panic.com>
 <20150321091514.GA22926@sci.fi>
 <20150327193813.GH5622@wotan.suse.de>
 <CALCETrVfC8aGKuPvaqv3edBADnKKvgDRiKbDvaaOr-HLB7jijg@mail.gmail.com>
 <20150327195759.GK5622@wotan.suse.de>
 <20150327215655.GA29933@sci.fi>
 <CALCETrWW9WrE_4x6SctQQBe=zXp1yMQ1i=qtsACTnHV0_Ku2iQ@mail.gmail.com>
 <20150328002818.GT5622@wotan.suse.de>
In-Reply-To: <20150328002818.GT5622@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: Andy Lutomirski <luto@amacapital.net>, Bjorn Helgaas <bhelgaas@google.com>, "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>, Jan Beulich <JBeulich@suse.com>, Borislav Petkov <bp@suse.de>, Suresh Siddha <suresh.b.siddha@intel.com>, venkatesh.pallipadi@intel.com, Dave Airlie <airlied@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, X86 ML <x86@kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Sat, Mar 28, 2015 at 01:28:18AM +0100, Luis R. Rodriguez wrote:
> On Fri, Mar 27, 2015 at 03:02:10PM -0700, Andy Lutomirski wrote:
> > On Fri, Mar 27, 2015 at 2:56 PM, Ville Syrj=E4l=E4 <syrjala@sci.fi> wro=
te:
> > > On Fri, Mar 27, 2015 at 08:57:59PM +0100, Luis R. Rodriguez wrote:
> > >> On Fri, Mar 27, 2015 at 12:43:55PM -0700, Andy Lutomirski wrote:
> > >> > On Fri, Mar 27, 2015 at 12:38 PM, Luis R. Rodriguez <mcgrof@suse.c=
om> wrote:
> > >> > > On Sat, Mar 21, 2015 at 11:15:14AM +0200, Ville Syrj=E4l=E4 wrot=
e:
> > >> > >> On Fri, Mar 20, 2015 at 04:17:59PM -0700, Luis R. Rodriguez wro=
te:
> > >> > >> > diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/v=
ideo/fbdev/aty/atyfb_base.c
> > >> > >> > index 8025624..8875e56 100644
> > >> > >> > --- a/drivers/video/fbdev/aty/atyfb_base.c
> > >> > >> > +++ b/drivers/video/fbdev/aty/atyfb_base.c
> > >> > >> > @@ -2630,21 +2630,10 @@ static int aty_init(struct fb_info *i=
nfo)
> > >> > >> >
> > >> > >> >  #ifdef CONFIG_MTRR
> > >> > >> >     par->mtrr_aper =3D -1;
> > >> > >> > -   par->mtrr_reg =3D -1;
> > >> > >> >     if (!nomtrr) {
> > >> > >> > -           /* Cover the whole resource. */
> > >> > >> > -           par->mtrr_aper =3D mtrr_add(par->res_start, par->=
res_size,
> > >> > >> > +           par->mtrr_aper =3D mtrr_add(info->fix.smem_start,
> > >> > >> > +                                     info->fix.smem_len,
> > >> > >> >                                       MTRR_TYPE_WRCOMB, 1);
> > >> > >>
> > >> > >> MTRRs need power of two size, so how is this supposed to work?
> > >> > >
> > >> > > As per mtrr_add_page() [0] the base and size are just supposed t=
o be in units
> > >> > > of 4 KiB, although the practice is to use powers of 2 in *some* =
drivers this
> > >> > > is not standardized and by no means recorded as a requirement. O=
bviously
> > >> > > powers of 2 will work too and you'd end up neatly aligned as wel=
l. mtrr_add()
> > >> > > will use mtrr_check() to verify the the same requirement. Furthe=
rmore,
> > >> > > as per my commit log message:
> > >> >
> > >> > Whatever the code may or may not do, the x86 architecture uses
> > >> > power-of-two MTRR sizes.  So I'm confused.
> > >>
> > >> There should be no confusion, I simply did not know that *was* the
> > >> requirement for x86, if that is the case we should add a check for t=
hat
> > >> and perhaps generalize a helper that does the power of two helper ch=
anges,
> > >> the cleanest I found was the vesafb driver solution.
> > >>
> > >> Thoughts?
> > >
> > > The vesafb solution is bad since you'll only end up covering only
> > > the first 4MB of the framebuffer instead of the almost 8MB you want.
> > > Which in practice will mean throwing away half the VRAM since you rea=
lly
> > > don't want the massive performance hit from accessing it as UC. And t=
hat
> > > would mean giving up decent display resolutions as well :(
> > >
> > > And the other option of trying to cover the remainder with multiple e=
ver
> > > smaller MTRRs doesn't work either since you'll run out of MTRRs very
> > > quickly.
> > >
> > > This is precisely why I used the hole method in atyfb in the first
> > > place.
> > >
> > > I don't really like the idea of any new mtrr code not supporting that
> > > use case, especially as these things tend to be present in older mach=
ines
> > > where PAT isn't an option.
> >=20
> > According to the Intel SDM, volume 3, section 11.5.2.1, table 11-6,
> > non-PAT CPUs that have a WC MTRR, PCD =3D 1, and PWT =3D 1 (aka UC) have
> > an effective memory type of UC.  Hence my suggestion to add
> > ioremap_x86_uc and/or set_memory_x86_uc to punch a UC hole in an
> > otherwise WC MTRR-covered region.
>=20
> OK I think I get it now.
>=20
> And I take it this would hopefully only be used for non-PAT systems?
> Would there be a use case for PAT systems? I wonder if we can wrap
> this under some APIs to make it clean and hide this dirty thing
> behind the scenes, it seems a fragile and error prone and my hope
> would be that we won't need more specialization in this area for
> PAT systems.

One potential complication is kernel vs. userspace mmap. MTRR applies to
the physical address, but PAT applies to the virtual address, so with
the WC MTRR you get WC for userspace "for free" as well. Also the
userspace mmaps request will have the length of smem_len (at most), so
it won't be the nice power of two in that case.

Also on PAT systems w/o a BIOS provided WC MTRR, the fbdev mmap seems
to be total crap at the moment. IIRC I have a patch to fix things a bit...

From 4e6d70d223f35953c8a11a58cf3376a8a001fa4f Mon Sep 17 00:00:00 2001
From: Ville Syrjala <syrjala@sci.fi>
Date: Fri, 15 Apr 2011 04:02:43 +0300
Subject: [PATCH] fb: writecombine fb

---
 drivers/video/fbdev/core/fbmem.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fb=
mem.c
index 0705d88..ecbde0e 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1396,6 +1396,7 @@ fb_mmap(struct file *file, struct vm_area_struct * vm=
a)
 	unsigned long mmio_pgoff;
 	unsigned long start;
 	u32 len;
+	bool mmio =3D false;
=20
 	if (!info)
 		return -ENODEV;
@@ -1426,11 +1427,20 @@ fb_mmap(struct file *file, struct vm_area_struct * =
vma)
 		vma->vm_pgoff -=3D mmio_pgoff;
 		start =3D info->fix.mmio_start;
 		len =3D info->fix.mmio_len;
+		mmio =3D true;
 	}
 	mutex_unlock(&info->mm_lock);
=20
+	if (!mmio) {
+		vma->vm_page_prot =3D vm_get_page_prot(vma->vm_flags);
+		vma->vm_page_prot =3D pgprot_writecombine(vma->vm_page_prot);
+
+		if (!vm_iomap_memory(vma, start, len))
+			return 0;
+	}
+
 	vma->vm_page_prot =3D vm_get_page_prot(vma->vm_flags);
-	fb_pgprotect(file, vma, start);
+	vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);
=20
 	return vm_iomap_memory(vma, start, len);
 }

Perhaps it's time I tried to send that upstream properly :P

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
