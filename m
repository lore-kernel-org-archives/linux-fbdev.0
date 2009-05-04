From: krzysztof.h1@poczta.fm
Subject: Re: 
	=?utf-8?q?=5BPATCH=5D_initialize_fb=5Finfo-?=
	=?utf-8?q?=3Elock_mutex_in_the_framebuffer=5Falloc=28=29?=
Date: 04 May 2009 10:23:55 +0200
Message-ID: <20090504082355.756042B7C45@f04.poczta.interia.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1M0tT0-0001Co-8e
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 04 May 2009 08:24:02 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M0tSv-0000xv-6r for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 04 May 2009 08:24:02 +0000
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
To: Ville =?UTF-8?q?Syrj=E4l=E4?= <syrjala@sci.fi>, Krzysztof Helt <krzysztof.h1@poczta.fm>, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundat>

Ville Syrj=E4l=E4 napisa=B3(a):
> On Sun, May 03, 2009 at 11:30:08PM +0200, Krzysztof Helt wrote:
> > From: Krzysztof Helt >krzysztof.h1@wp.pl>
> > =

> > The fb_info->lock mutex should be initialized inside =

> > the framebuffer_alloc() function. Otherwise, someone
> > may call a fb layer function which indirectly uses uninitialized =

> > mutex.
> =

> How can that someone find the fb_info without it being in the
> registered_fb[] array?
> =


It cannot but one can call functions modyfing fb_info structure.

An example is the fb_check_var() function which is called
by most drivers indirectly by the fb_try_mode().

The question to answer is what is a purpose of the
fb_info->lock. What is there assumed to be protected?

Currenlty, it seems randomly set all around the layer.
Is supposed to protect against concurent access
from the userspace or something more?

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
