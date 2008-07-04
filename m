From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Enabling Hardware acceleration in
	existing	framebuffer driver
Date: Fri, 4 Jul 2008 21:21:23 +0300
Message-ID: <20080704182123.GE7132@sci.fi>
References: <486E4812.5070803@linuxinstruments.com>
	<20080704182215.6f64f848.krzysztof.h1@poczta.fm>
	<486E50F5.5070401@linuxinstruments.com>
	<20080704193226.a1750cf8.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KEpuW-0000qm-9O for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 04 Jul 2008 11:21:32 -0700
Received: from smtp5.pp.htv.fi ([213.243.153.39])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KEpuU-0006eQ-KJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 04 Jul 2008 11:21:32 -0700
Content-Disposition: inline
In-Reply-To: <20080704193226.a1750cf8.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Fri, Jul 04, 2008 at 07:32:26PM +0200, Krzysztof Helt wrote:
> On Fri, 04 Jul 2008 12:33:57 -0400
> Keith Williams <espian@linuxinstruments.com> wrote:
> =

> > The fillrect was the simplest to implement.  I agree that the others
> > will be much higher value.
> > =

> > In DirectFB there are a set of benchmarks that run through all of the
> > different drawing types including filled rectangles.  That is what I am
> > using as my baseline.
> > =

> =

> I don't know DirectFB. I am not sure if the DirectFB uses the frame buffer
> acceleration or its own. =


DirectFB has it's own low level gfx drivers. It can use fbdev for mode
switching but that's all.

In fact there is no way to call fbdev accel code from userspace.

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
