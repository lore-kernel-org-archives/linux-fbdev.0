From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Card's view of framebuffer offset into userspace?
Date: Mon, 15 Jul 2002 04:56:26 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020715045626.A9296@sci.fi>
References: <20020714161029.A24172@sci.fi> <20020715000214.GD11998@ppc.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from kura.mail.jippii.net ([195.197.172.113])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17Tv2l-00050O-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 14 Jul 2002 18:52:55 -0700
Received: from simpukka.saunalahti.fi (simpukka.saunalahti.fi [195.74.0.20])
	by kura.mail.jippii.net (Postfix) with ESMTP id 5806A4E71
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Jul 2002 04:52:50 +0300 (EEST)
Received: (from syrjala@localhost) by simpukka.saunalahti.fi (8.8.5/8.8.3) id EAA10273 for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Jul 2002 04:56:26 +0300 (EET DST)
In-Reply-To: <20020715000214.GD11998@ppc.vc.cvut.cz>; from vandrove@vc.cvut.cz on Mon, Jul 15, 2002 at 02:02:14AM +0200
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net

On Mon, Jul 15, 2002 at 02:02:14AM +0200, Petr Vandrovec wrote:
> On Sun, Jul 14, 2002 at 04:10:29PM +0300, Ville Syrj=E4l=E4 wrote:
> > Is there a way to ge the framebuffer offset to userspace? I hacked
> > DirectFB to draw to the crtc2 display but currently I've had to hardcode
> > the framebuffer offset. So I need something I can feed to tmy G400.
>=20
> In what environment? With matroxfb you have special framebuffer which
> is displayed by CRTC2 engine.

Yes. That's what DirectFB uses for mode switching and buffer flipping. =20
But I need something for the DSTORG,SRCORG and TEXORG registers. DirectFB
uses it's own memory manager and the offsets there start from the
beginning of the framebuffer. It assumes the hardware sees the framebuffer
at offset 0 but with the CRTC2 that's not true.

> Offset is not explicitly exported, but
> if you'll take low 24 bits from fb_start, you'll get offset on
> G400/G450/G550 devices.

I don't see such a thing anywhere. Do you mean smem_start? Ok just tried
with (smem_start + offset & 0x1ffffff) and it works for both heads. So
that's actually 25 bits. Maybe I should just use 28 bits to accomodate
larger framebuffers?

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
