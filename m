From: =?iso-8859-1?q?alain=20volmat?= <avolmat@yahoo.fr>
Subject: Re: Framebuffer on banked video memory device (MMAP/NOPAGE)
Date: Mon, 12 May 2003 08:30:30 +0200 (CEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030512063030.86553.qmail@web41703.mail.yahoo.com>
References: <20030512045148.86794.qmail@web41712.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web41703.mail.yahoo.com ([66.218.93.120])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19F6pX-0007S4-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 11 May 2003 23:30:35 -0700
In-Reply-To: <20030512045148.86794.qmail@web41712.mail.yahoo.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net

I forget to mention that I'm using kernel 2.4.19 on
SH3 (big endian).

Alain

 --- alain volmat <avolmat@yahoo.fr> a =E9crit : > Hello
guys,
>=20
> my email concern MMAP / NOPAGE but applied to
> framebuffer so I decided to write here.
> Actually it's about an old story I wrote about few
> months ago; having a framebuffer for a custom chip
> which has video memory banked (ie, I need to set
> manually registers of the chip in order to select
> which bank of the memory I want to be visible from
> the
> CPU).
> FBCON works perfectly on the top of this framebuffer
> (I have overwritten fb_readb/w/l and fb_writeb/w/l
> to
> be able to insert those bank switch thing), but I am
> still facing lot of problems concerning MMAP access
> to
> framebuffer memory.
> In case of MMAP, I cannot control bank switching as
> easier as in case of FBCON. By using the NOPAGE
> handler, I can switch bank but still it seems that
> it
> doesn't work in the perfect way.
>=20
> First let me explain a bit more; the memory to be
> MMAPed is physical memory (not allocated). Inside
> the
> mmap function nothing is done except passing the
> structure for the NOPAGE handler; the NOPAGE handler
> is then in charge of calling "remap_page_range" and
> "pgd_offset", "pmd_offset" and "pte_offset".
> I've noticed that in that case, the NOPAGE handler
> is
> actually only called once per bank. I mean if a page
> has never been mapped before then the nopage handler
> will be called, but after that the nopage handler
> will
> never again be called. As a result, my display is
> only
> refresh once (in full) and then after only 1 bank is
> accessed (because the nopage handler is not called).
> In order to have the nopage handler always called, I
> tried to modify my NOPAGE handler to make him FORGET
> about the previous mapped page. (in that case at a
> time only 1 page is always mapped). I don't think
> it's
> a good solution but currently I use
> "zap_page_range".
> Well this function was not static but I had to
> EXPORT
> it to make it available to module. I don't think it
> is
> the right solution but since I didn't find anybody
> who's facing this problem I've checked a bit
> memory.c
> to find this function.
>=20
> Actually I'm quite surprise to see that nobody is
> facing this problem, (well maybe it's just my
> misunderstanding of the use of nopage handler), why
> does the NOPAGE handler is only call once. Are there
> any way to make it forget previous page ??
>=20
> Even with this modification everything doesn't works
> fine, well I got all the display refreshed but it
> seems that (maybe due to timing issue) sometimes it
> mistake bank. I know that this problem is related to
> MMAP/NOPAGE because this problem doesn't happens at
> all for FBCON, even if the way to control the
> hardware
> is same. I would like to learn more about timing of
> the NOPAGE handler, when is it called ? does the
> process "stop" during that time and wait or just
> continue ?
>=20
> Sorry ... I noticed that my email is finally more
> related to MMAP/NOPAGE that actually framebuffer
> itself, but I also would like to know if some people
> have framebuffer on banked memory device.
>=20
> Sincerely,
> Alain
>=20
>
___________________________________________________________
> Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et
> en fran=E7ais !
> Yahoo! Mail : http://fr.mail.yahoo.com
>=20
>=20
>
-------------------------------------------------------
> Enterprise Linux Forum Conference & Expo, June 4-6,
> 2003, Santa Clara
> The only event dedicated to issues related to Linux
> enterprise solutions
> www.enterpriselinuxforum.com
>=20
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel=20

___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en fran=E7ais !
Yahoo! Mail : http://fr.mail.yahoo.com


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
