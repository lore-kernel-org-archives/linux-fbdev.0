From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: Added 915G to intelfb of 2.6.10-kernel-sources
Date: Sat, 29 Jan 2005 05:54:24 +0800
Message-ID: <200501290554.24649.adaplas@hotpop.com>
References: <41F9BEA6.2030300@XLsigned.net> <41FA6B64.6090506@worldonline.fr>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CueBc-0008VF-Dw
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Jan 2005 14:01:52 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Cue5j-0004GB-UJ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Jan 2005 14:01:52 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 7CBF9D6B53E
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 28 Jan 2005 21:55:30 +0000 (UTC)
In-Reply-To: <41FA6B64.6090506@worldonline.fr>
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
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net, Sylvain Meyer <sylvain.meyer@worldonline.fr>, "Buttchereit, Axel (XLsigned)" <XL@XLsigned.net>

On Saturday 29 January 2005 00:42, Sylvain Meyer wrote:
>         Hi Axel,
>
>     Thanks for your patch but could you format it as described in this
> document
> http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt
>
> and resend it.
>
> The best is to use these tools to maintain and send kernel patches
> http://www.zip.com.au/~akpm/linux/patches/
>
> Also you should subscribe and send fbdev-related mails to
> linux-fbdev-devel@lists.sourceforge.net
>
> Regards
> Sylvain
>
> Buttchereit, Axel (XLsigned) a =E9crit:
> > Hi,
> >
> > though I'm quite sure that the attached patch (intelfb-...) is far
> > from complete
> > I think that someone/you (guessing from the comments that you are
> > maintaining
> > the code) might be interested in my work.

Can you resend the patch that touches only intelfb?  Also, there are a lot
of XLSigned with the printk's, what is that?

> >
> > Having no technical documentation (from Intel) I had to "develop" the
> > patch by
> > looking at the xfree/xorg-code that already supports I915G and by using
> > trial-and-error (My ThinkCentre's internal graphics device is an I915G
> > and that made me start working on this subject).
> >
> > During development and testing I've discovered that the way "intelfb"
> > and maybe
> > other framebuffer-drivers are using "modedb" does not work, if
> > compiled as a
> > module. The initial "modedb entries" are lost (overwritten?) when
> > "fb_find_mode"
> > is called from the module. Linking "intelfb" into the kernel works as

Because the modedb array is marked __init.  You can however pass
the vesa_modes array instead to fb_find_mode().
=20
> > expected.
> >
> > ByTheWay: Why isn't the framebuffer module (intelfb) automatically
> > loaded, if
> > "video=3Dintelfb:..." is specified as kernel-parameter?

If you want it loaded automatically, compile the driver statically. If you =
don't
want to load a compiled-in driver, use:

video=3Dintelfb:off

Tony




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
