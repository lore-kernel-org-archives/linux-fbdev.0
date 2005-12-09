From: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
Subject: RE: Frame swapping
Date: Fri, 9 Dec 2005 09:37:10 -0000
Message-ID: <35786B99AB3FDC45A8215724617919736D9183@gbrwgceumf01.eu.xerox.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ekehe-0004aB-EO
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 01:38:10 -0800
Received: from wvmler4.mail.xerox.com ([13.8.138.219])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1Ekehb-0004dc-QQ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 01:38:10 -0800
Content-class: urn:content-classes:message
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
To: "Antonino A. Daplas" <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net

> From: Antonino A. Daplas [mailto:adaplas@gmail.com]=20
> Sent: 08 December 2005 21:18
> To: linux-fbdev-devel@lists.sourceforge.net
> Cc: Jenkins, Clive
> Subject: Re: [Linux-fbdev-devel] Frame swapping
>=20
> Jenkins, Clive wrote:
> > How is frame swapping done, using the mechanisms provided
> > by FB (in 2.4 and 2.6)?
> > Can anyone point me to any good code examples in the
> > existing FB device drivers?
> >=20
> > ["Frame swapping" or "video page flipping" is switching
> > to an alternate framebuffer memory area during the
> > vertical blank period. This is a common technique to
> > achieve animation or a single clean change of picture.]
>=20
> Use the pan display ioctl, FBIOPAN_DISPLAY.  Basically, set
> var->yres_virtual to be at least 2x var->yres so you can have
> 2 video buffers, one visible, one offscreen.  Then just do a
> ypan ioctl to set which buffer becomes visible and which
> becomes offscreen.
>=20
> Doing it during vblank is a little difficult.  You can poll
> the VGA registers (which is slow), or set up an interrupt
> handler for the driver you are using that waits for vblank.
>=20
> See www.directfb.org for code on how this can be done.  Also,
> the directfb source have patches to some drivers that implements
> the wating for vblank, such as in matroxfb.
>=20
> Tony

Thanks Tony. I was thinking I would have to implement my own
ioctl to do this, but I agree it can be regarded as a special
case of panning (even though my hardware doesn't fully support
panning).

I would expect panning to be smooth and glitch-free whenever
possible within the limitations of the hardware, so the
switch-over should always occur during vblank. I have seen some
drivers that definitely do this, by deferring all updates until
the vb interrupt. But maybe many other drivers don't bother.

Another way might be to do a GETVAR ioctl, modify "yoffset",
set the FB_ACTIVATE_VBL bit of "activate", and do a SETVAR
ioctl. I am sure this is the intended usage of the ACTIVATE_VBL
bit, even though it may not be well supported by existing drivers.

I notice in fbmem.c (2.4.20 version), there is no fall-back
code for the PAN_DISPLAY ioctl when the device method is absent.
Perhaps the getvar/modify/setvar above should be coded here.

Clive


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
