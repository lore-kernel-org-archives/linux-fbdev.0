From: Luc Verhaegen <libv@skynet.be>
Subject: Re: [PATCH 06/20] vt8623fb: New
	framebuffer	driver for VIA VT8623
Date: Sun, 6 May 2007 04:07:42 +0200
Message-ID: <20070506020742.GA19784@skynet.be>
References: <463C996A.9050005@gmail.com> <20070505181551.GB6016@sci.fi>
	<20070505200801.GA28014@localhost.localdomain>
	<20070505203450.GC6016@sci.fi> <20070505224855.GA18807@skynet.be>
	<1178406457.22828.7.camel@daplas>
	<20070505233147.GA19039@skynet.be>
	<20070505233834.GA19120@skynet.be> <20070506013617.GA29760@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HkWA8-0007xb-Vp for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 19:07:49 -0700
Received: from outmx034.isp.belgacom.be ([195.238.6.171])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HkWA7-00062I-BN
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 19:07:48 -0700
Received: from outmx034.isp.belgacom.be (localhost.localdomain [127.0.0.1])
	by outmx034.isp.belgacom.be (8.13.4/8.13.4/Debian-3sarge3) with ESMTP
	id l4627d9E029405 for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 6 May 2007 04:07:39 +0200
Received: from death (2.175-64-87.adsl-dyn.isp.belgacom.be [87.64.175.2])
	by outmx034.isp.belgacom.be (8.13.4/8.13.4/Skynet-OUT-2.22) with ESMTP
	id l4627cJO029401 for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 6 May 2007 04:07:39 +0200 (envelope-from <libv@skynet.be>)
Received: from death by death with local (Exim 3.36 #1 (Debian))
	id 1HkWA2-00059M-00 for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 06 May 2007 04:07:42 +0200
Content-Disposition: inline
In-Reply-To: <20070506013617.GA29760@sci.fi>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

On Sun, May 06, 2007 at 04:36:17AM +0300, Ville Syrj=E4l=E4 wrote:
> =

> I think a big portion of the blame falls on VIA since they are the
> original authors and the they have decided not to work with the community.
> Maybe that's changing now that they posted the patches (even though they
> aren't clean). I didn't really read the viafb patch thread so I missed the
> details. Are they are prepared to clean it up or do they just expect to
> dump the code here and forget about it?

I of course don't know anything what i say here for sure, but i'd be =

really surprised if VIA did change their act.

VIA has a history of either:
* freeing code, seeing it cleaned up and included in the relevant =

project, yet continuing a seperate fork in VIA-space nonetheless (X =

driver).
* purposefully forking projects to keep VIA specific adaptations in =

(xine, mplayer)

I don't see why this here would be any different.

If VIAs own driver does get reworked by fb/kernel people and included, =

then VIA will not accept these changes and will just continue things =

seperately themselves.

The fact that some backward compatibility defines were deemed =

superfluous already, and the fact that VIAs direct customers probably =

want those things to be possible for quite some time still, will mean =

that VIA will see no other option but to keep things in their own fork.

History repeating.

Luc Verhaegen.
http://unichrome.sf.net/

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
