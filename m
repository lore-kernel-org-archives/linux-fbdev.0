From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] initialize fb_info->lock mutex
	in	the framebuffer_alloc()
Date: Mon, 4 May 2009 01:54:02 +0300
Message-ID: <20090503225402.GA17782@sci.fi>
References: <20090503233008.bf4b9f57.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <syrjala@sci.fi>) id 1M0kZW-0001In-Db
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 03 May 2009 22:54:10 +0000
Received: from smtp4.welho.com ([213.243.153.38])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M0kZU-000759-E8 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 03 May 2009 22:54:10 +0000
Content-Disposition: inline
In-Reply-To: <20090503233008.bf4b9f57.krzysztof.h1@poczta.fm>
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

On Sun, May 03, 2009 at 11:30:08PM +0200, Krzysztof Helt wrote:
> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> =

> The fb_info->lock mutex should be initialized inside =

> the framebuffer_alloc() function. Otherwise, someone
> may call a fb layer function which indirectly uses uninitialized =

> mutex.

How can that someone find the fb_info without it being in the
registered_fb[] array?

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
