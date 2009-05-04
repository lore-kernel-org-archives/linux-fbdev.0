From: krzysztof.h1@poczta.fm
Subject: Re: 
	=?utf-8?q?=5BPATCH=5D_initialize_fb=5Finfo-?=
	=?utf-8?q?=3Elock_mutex_in_the_framebuffer=5Falloc=28=29?=
Date: 04 May 2009 11:53:00 +0200
Message-ID: <20090504095300.28D2CE715BF@f16.poczta.interia.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1M0urD-0008HQ-1f
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 04 May 2009 09:53:07 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M0urA-0005iy-UC for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 04 May 2009 09:53:07 +0000
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
To: Krzysztof Helt <krzysztof.h1@poczta.fm>, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>

Krzysztof Helt napisa=B3(a):
> From: Krzysztof Helt >krzysztof.h1@wp.pl>
> =

> The fb_info->lock mutex should be initialized inside =

> the framebuffer_alloc() function. Otherwise, someone
> may call a fb layer function which indirectly uses uninitialized =

> mutex.
> Move initialization of the mutex from the register_framebuffer()
> to framebuffer_alloc().
> =

> This may cause problems for drivers which do not use
> the framebuffer_alloc() to allocate the fb_info structure.
> Convert the two last drivers to use the framebuffer_alloc().
> =

> Signed-off-by: Krzysztof Helt >krzysztof.h1@wp.pl>
> ---
> =


Please drop this patch as it breaks framebuffers with
static global fb_info structures. The fb_info->lock
will be uninitialized. Thanks to Geert for helping
me realizing that.

I will repost driver conversion to the framebuffer_alloc()
without moving mutex initialization.

Regards,
Krzysztof


----------------------------------------------------------------------
Gotowka na koncie. Otworz konto direct i wez podwojny limit. 	 =

http://link.interia.pl/f2145


---------------------------------------------------------------------------=
---
Register Now & Save for Velocity, the Web Performance & Operations =

Conference from O'Reilly Media. Velocity features a full day of =

expert-led, hands-on workshops and two days of sessions from industry =

leaders in dedicated Performance & Operations tracks. Use code vel09scf =

and Save an extra 15% before 5/3. http://p.sf.net/sfu/velocityconf
