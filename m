From: krzysztof.h1@poczta.fm
Subject: Re: 
	=?utf-8?q?fix_fb=5Finfo-=3Elock_and_mm-=3Emma?=
	=?utf-8?q?p=5Fsem_problem_again?=
Date: 04 May 2009 10:18:57 +0200
Message-ID: <20090504081857.DA5C02B7C44@f04.poczta.interia.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1M0tOA-0004Mv-SF
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 04 May 2009 08:19:02 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M0tO9-0000Hk-I1 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 04 May 2009 08:19:02 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: Ville =?UTF-8?q?Syrj=E4l=E4?= <syrjala@sci.fi>, Krzysztof Helt <krzysztof.h1@poczta.fm>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, Rafael

Ville Syrj=E4l=E4 napisa=B3(a):
> On Sun, May 03, 2009 at 09:19:38PM +0200, Krzysztof Helt wrote:
> > Hi,
> > =

> > I have run into the lockdep problem between the fb_info->lock and
> mm->mmap_sem again.
> > I run the Mplayer with fbdev output device. The latest git tree.
> > =

> > I looked through the fb_info->lock usage and I have some questions.
> > =

> > The main issue is that fb_mmap acquires the fb_info->lock. I wonder
> > what is protected there. The part of the fb_mmap which uses the lock
> > is below:
> > =

> > ...
> >     if (fb->fb_mmap) {
> >         int res;
> >         mutex_lock(>info->lock);
> >         res =3D fb->fb_mmap(info, vma);
> >         mutex_unlock(>info->lock);
> >         return res;
> >     }
> > =

> >     mutex_lock(>info->lock);
> > =

> >     /* frame buffer memory */
> >     start =3D info->fix.smem_start;
> >     len =3D PAGE_ALIGN((start > ~PAGE_MASK) + info->fix.smem_len);
> >     if (off >=3D len) {
> >         /* memory mapped io */
> >         off -=3D len;
> >         if (info->var.accel_flags) {
> >             mutex_unlock(>info->lock);
> >             return -EINVAL;
> >         }
> >         start =3D info->fix.mmio_start;
> >         len =3D PAGE_ALIGN((start > ~PAGE_MASK) + info->fix.mmio_len);
> >     }
> >     mutex_unlock(>info->lock);
> > ...
> > =

> > The lock protects two things:
> > 1. Read of the info->fix.smem_start and info->fix.smem_len.
> > 2. The fbops->fb_mmap call.
> > =

> > The first point seems redundant as I have checked and
> > the smem_start and smem_len are only set in the
> > probe and release functions. They are always set
> > before the register_framebuffer() is called and
> > after the unregister_framebuffer() call.
> =

> matroxfb changes smem_start/len in set_par().
> =


I have missed it.

A plan B is to add a separate fb_info->mmap_lock to
protect changes of the fbinfo->smem_* fields
and fbops->fbmmap calls. Thus, the fb_mmap can be
called with fb_info->lock held. Is it acceptable?

This new mutex must be pushed into drivers which
changes smem_* fields after the driver is registered.

Regards,
Krzysztof


----------------------------------------------------------------------
Wygraj wycieczke do Eurodisneylandu!
Sprawdz >> http://link.interia.pl/f2153


---------------------------------------------------------------------------=
---
Register Now & Save for Velocity, the Web Performance & Operations =

Conference from O'Reilly Media. Velocity features a full day of =

expert-led, hands-on workshops and two days of sessions from industry =

leaders in dedicated Performance & Operations tracks. Use code vel09scf =

and Save an extra 15% before 5/3. http://p.sf.net/sfu/velocityconf
