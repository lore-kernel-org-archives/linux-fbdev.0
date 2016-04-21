From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 21 Apr 2016 07:30:43 +0000
Subject: Re: [PATCH 5/8] fbdev: fb_defio: Export fb_deferred_io_mmap
Message-Id: <20160421073043.GX2510@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461165929-11344-1-git-send-email-noralf@tronnes.org>
 <1461165929-11344-6-git-send-email-noralf@tronnes.org>
 <20160420174414.GQ2510@phenom.ffwll.local>
 <5717CB6D.8000708@tronnes.org>
In-Reply-To: <5717CB6D.8000708@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc: linux-fbdev@vger.kernel.org, tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

On Wed, Apr 20, 2016 at 08:33:17PM +0200, Noralf Tr=F8nnes wrote:
>=20
> Den 20.04.2016 19:44, skrev Daniel Vetter:
> >On Wed, Apr 20, 2016 at 05:25:26PM +0200, Noralf Tr=F8nnes wrote:
> >>Export fb_deferred_io_mmap so drivers can change vma->vm_page_prot.
> >>When the framebuffer memory is allocated using dma_alloc_writecombine()
> >>instead of vmalloc(), I get cache syncing problems.
> >>This solves it:
> >>
> >>static int drm_fbdev_cma_deferred_io_mmap(struct fb_info *info,
> >>					  struct vm_area_struct *vma)
> >>{
> >>	fb_deferred_io_mmap(info, vma);
> >>	vma->vm_page_prot =3D pgprot_writecombine(vma->vm_page_prot);
> >Hm, do we need pgpropt_writecombine? There recently was some discussion
> >(on the arc platform) that fbdev pgprots need to be fixed up in fbdev
> >code. I have no idea, just repeating from memory ...
>=20
> I need it or else I get partial lines that doesn't get updated on the
> display.
> fbdev code that doesn't set (struct fb_ops *)->fb_mmap, gets this for free
> in the default fb_mmap implementation (drivers/video/fbdev/core/fbmem.c).
> It calls fb_pgprotect() at the end which is an architecture specific
> function that on many platforms uses pgprot_writecombine(), but not on al=
l.
> And looking at some of the fb_mmap implementations, some of them sets
> vm_page_prot to nocache for instance, so I think the safest bet is to do
> this here and not in the fbdev core. And we can't call fb_pgprotect() from
> fb_deferred_io_mmap() either because we don't have access to the file
> pointer that powerpc needs.
> I think the case you refer to was solved with using fb_pgprotect() for
> the platform in question and it didn't involve deferred io.

Argh, oh well. I guess another case (besides the mmap thing in udl where
the default defio support from fbdev goes boom) where this isn't the most
awesome thing ever.

Please add your explanation to the commit message for posterity.

Thanks, Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
