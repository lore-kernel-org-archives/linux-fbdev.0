From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] Disable mach64 accelerator
	if	stride is not multiple of 64
Date: Wed, 17 Jun 2009 20:21:49 +0300
Message-ID: <20090617172149.GA9980@sci.fi>
References: <Pine.LNX.4.64.0906170559040.30231@hs20-bc2-1.build.redhat.com>
	<Pine.LNX.4.64.0906170600590.30231@hs20-bc2-1.build.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <syrjala@sci.fi>) id 1MGypp-0000UT-FF
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 17 Jun 2009 17:22:05 +0000
Received: from smtp4.welho.com ([213.243.153.38])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MGypl-0001Vf-Le for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 17 Jun 2009 17:22:04 +0000
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0906170600590.30231@hs20-bc2-1.build.redhat.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, paulus@samba.org

On Wed, Jun 17, 2009 at 06:02:30AM -0400, Mikulas Patocka wrote:
> On my card, the accelerator corrupts display if its line length is not
> multiple of 64 bytes.
> =

> Misaligned lines in the drawn recrangle are shifted left, as if the accel=
erator
> thought that every line begins on 64-byte boundary. For example, in 800x6=
00x8
> (scanlines are aligned on 32 bytes) every odd scanline is drawn shifted by
> 32 bytes to the left.
> =

> The card is ATI Technologies Inc 3D Rage Pro 215GP (rev 5c) onboard on
> Sparc64 Ultra 5.

I think normally the offset should be just aligned to 8 bytes and pitch
to 8 bytes and 8 pixels.

I was under the impression that 64 byte aligned offset and pitch are only
required if block writes are used. But perhaps it is always required
with SGRAM/WRAM, or perhaps you have auto block writes enabled. Can you
check the memory type and the the value of the HW_DEBUG register?

> This patch disables accelerator if scanline is not multiple of 64 bytes.

A better option would be to round the pitch up in check_var(). Also it
would be more proper to use fix.line_length as the pitch value instead
of var.xres_virtual. That way check_var() could leave var.xres_virtual
alone and just round fix.line_length to whatever is required.

Actually now that I think about it I would prefer to round to 64 bytes
always when SGRAM/WRAM is found. The reason is that the mach64 DirectFB
driver always enables auto block writes on SGRAM boards and if atyfb
uses less alignment things will not work correctly. Perhaps atyfb should
enable auto block writes too.

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

---------------------------------------------------------------------------=
---
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing =

server and web deployment.
http://p.sf.net/sfu/businessobjects
