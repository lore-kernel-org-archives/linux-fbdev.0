From: Shaun Jackman <sjackman@gmail.com>
Subject: Re: Hang when using a Matrox G550 with DVI
Date: Thu, 26 May 2005 10:27:58 -0700
Message-ID: <7f45d93905052610271e39240e@mail.gmail.com>
References: <7f45d93905042111313ae10b39@mail.gmail.com>
	 <20050525233958.05ceaa58.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DbM9I-0006yr-Mt
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 26 May 2005 10:28:00 -0700
Received: from rproxy.gmail.com ([64.233.170.198])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DbM9I-00079b-9H
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 26 May 2005 10:28:00 -0700
Received: by rproxy.gmail.com with SMTP id j1so349574rnf
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 26 May 2005 10:27:59 -0700 (PDT)
In-Reply-To: <20050525233958.05ceaa58.akpm@osdl.org>
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On 5/25/05, Andrew Morton <akpm@osdl.org> wrote:
> Shaun Jackman <sjackman@gmail.com> wrote:
> >
> > When I have a DVI display plugged into my Matrox G550 video card the
> > Linux kernel 2.6.11 hangs while booting. This can be worked around by
> > "disabling CONFIG_VIDEO_SELECT and/or comment out call to store_edid
> > in arch/i386/boot/video.S" [1], or by unplugging the DVI display
> > before the kernel boots and plugging it back in before X starts. This
> > is the same bug listed here [2], and it has been around since the
> > 2.5.67-bk6 days.
> >
> > Please cc me in your reply. Cheers,
> > Shaun
> >
> > [1] http://www.ussg.iu.edu/hypermail/linux/kernel/0408.2/0434.html
> > [2] http://bugme.osdl.org/show_bug.cgi?id=3D1458
>=20
> Do the fbdev guys know about this?
=20
On 2005-Apr-29 you forwarded to
linux-fbdev-devel@lists.sourceforge.net the message quoted above that
I sent to lkml.

> Does 2.6.12-rc5 still have the bug?

I'm sorry, I don't know. If somebody believes they've fixed the bug,
I'd be happy to test for them.

Cheers,
Shaun


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
