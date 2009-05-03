From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: fix fb_info->lock and mm->mmap_sem
	problem	again
Date: Mon, 4 May 2009 01:54:33 +0300
Message-ID: <20090503225433.GB17782@sci.fi>
References: <20090503211938.c9293813.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <syrjala@sci.fi>) id 1M0ka1-0005f8-82
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 03 May 2009 22:54:41 +0000
Received: from smtp6.welho.com ([213.243.153.40])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M0kZy-0004yI-CR for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 03 May 2009 22:54:41 +0000
Content-Disposition: inline
In-Reply-To: <20090503211938.c9293813.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@gmail.com>

On Sun, May 03, 2009 at 09:19:38PM +0200, Krzysztof Helt wrote:
> Hi,
> =

> I have run into the lockdep problem between the fb_info->lock and mm->mma=
p_sem again.
> I run the Mplayer with fbdev output device. The latest git tree.
> =

> I looked through the fb_info->lock usage and I have some questions.
> =

> The main issue is that fb_mmap acquires the fb_info->lock. I wonder
> what is protected there. The part of the fb_mmap which uses the lock
> is below:
> =

> ...
>     if (fb->fb_mmap) {
>         int res;
>         mutex_lock(&info->lock);
>         res =3D fb->fb_mmap(info, vma);
>         mutex_unlock(&info->lock);
>         return res;
>     }
> =

>     mutex_lock(&info->lock);
> =

>     /* frame buffer memory */
>     start =3D info->fix.smem_start;
>     len =3D PAGE_ALIGN((start & ~PAGE_MASK) + info->fix.smem_len);
>     if (off >=3D len) {
>         /* memory mapped io */
>         off -=3D len;
>         if (info->var.accel_flags) {
>             mutex_unlock(&info->lock);
>             return -EINVAL;
>         }
>         start =3D info->fix.mmio_start;
>         len =3D PAGE_ALIGN((start & ~PAGE_MASK) + info->fix.mmio_len);
>     }
>     mutex_unlock(&info->lock);
> ...
> =

> The lock protects two things:
> 1. Read of the info->fix.smem_start and info->fix.smem_len.
> 2. The fbops->fb_mmap call.
> =

> The first point seems redundant as I have checked and
> the smem_start and smem_len are only set in the
> probe and release functions. They are always set
> before the register_framebuffer() is called and
> after the unregister_framebuffer() call.

matroxfb changes smem_start/len in set_par().

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

---------------------------------------------------------------------------=
---
Register Now & Save for Velocity, the Web Performance & Operations =

Conference from O'Reilly Media. Velocity features a full day of =

expert-led, hands-on workshops and two days of sessions from industry =

leaders in dedicated Performance & Operations tracks. Use code vel09scf =

and Save an extra 15% before 5/3. http://p.sf.net/sfu/velocityconf
