From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: [Question] Colour management
Date: Sun, 1 Aug 2004 07:47:43 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200408010747.43233.adaplas@hotpop.com>
References: <20040722184937.GA11361@sci.fi> <200407311826.27332.adaplas@hotpop.com> <20040731221858.GA17721@sci.fi>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Br3b5-0005iw-J5
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 31 Jul 2004 16:49:03 -0700
Received: from smtp-out3.hotpop.com ([38.113.3.71] helo=twix.hotpop.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1Br3b5-0001Je-2V
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 31 Jul 2004 16:49:03 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by twix.hotpop.com (Postfix) with SMTP id 514F41039429
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 31 Jul 2004 23:25:27 +0000 (UTC)
In-Reply-To: <20040731221858.GA17721@sci.fi>
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: Ville =?iso-8859-1?q?Syrj=E4l=E4?= <syrjala@sci.fi>, linux-fbdev-devel@lists.sourceforge.net

On Sunday 01 August 2004 06:18, Ville Syrj=E4l=E4 wrote:
> On Sat, Jul 31, 2004 at 06:26:27PM +0800, Antonino A. Daplas wrote:
> > On Saturday 31 July 2004 02:12, Alexander Kern wrote:
> > > Hallo Tony,
> > >
> > > can you explain the deep mining of fb_setcolreg. Background, I observe
> > > wrong palette using in 15 and 16 bpp modes, but can not understand,
> > > what is the right approach. In both cases from penguin logo I can see
> > > only contour in honey yellow and blue vertical string jsimmons, pretty
> > > scury ;-) The rest is black! The simple text or ncurses applications
> > > have always right colours. Additionally and only by 16bpp fbi shows
> > > blurry images. In 15bpp fbi works fine. fbtest works fine and his
> > > penguins look good in all resolutions ?!
> >
> > This will need a long answer. (For mistakes or ommisions, please let me
> > know)
> >
> > fb_setcolreg has 2 functions, initialize info->pseudopalette (if needed)
> > and initialize the hardware CLUT (if needed).
>
> BTW fb_setcolreg ends up writing half of the registers twice (more if you
> have to fill all slots). It might be better to have two functions. The
> first one would be the current fb_setcolreg except it wouldn't actually
> write anything. It would only fill in the correct register values. And the
> second one would write the clut to hardware. That would avoid the multiple
> writes.

Yes, we also need to separate the imageblit into a mono_src_color_expand
(for text drawing) and an 8_bit_src_color_expand (for the logo).  Both prop=
osals
will affect all drivers so let's leave it as is for now (unless you want to=
 risk
the ire again of the fbdev driver maintainers, they're a bit touchy from the
numerous breakages of the API :-)

Tony




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
