From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: Where is place of arch independed companion chips?
Date: Mon, 8 Aug 2005 22:09:08 +0100 (BST)
Message-ID: <20050808210908.1672.qmail@web30311.mail.mud.yahoo.com>
References: <1123019379.7782.86.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E2Lbv-0004hH-Js
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 08 Aug 2005 21:21:07 -0700
Received: from [68.142.201.229] (helo=web30311.mail.mud.yahoo.com)
	by mail.sourceforge.net with smtp (Exim 4.44)
	id 1E2Etm-00034d-Fe
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 08 Aug 2005 14:11:07 -0700
In-Reply-To: <1123019379.7782.86.camel@localhost.localdomain>
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
To: Richard Purdie <rpurdie@rpsys.net>, Greg KH <gregkh@suse.de>
Cc: Jamey Hicks <jamey.hicks@hp.com>, Andrey Volkov <avolkov@varma-el.com>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org


--- Richard Purdie <rpurdie@rpsys.net> wrote:

> On Mon, 2005-08-01 at 11:13 -0700, Greg KH wrote:
> > > Good question.  I was about to submit a patch
> that created=20
> > > drivers/platform because the toplevel driver for
> MQ11xx is a=20
> > > platform_device driver.  Any thoughts on this?
> >=20
> > drivers/platform sounds good to me.
>=20
> In another thread (about the ucb1x00) we came up
> with the idea of
> drivers/mfd (mfd =3D multi function devices).
>=20
> The core and platform specific parts would live here
> with suitable clear
> naming and the subsection specific parts that were
> separable would live
> in the appropriate place within the kernel.
>=20
> Just another idea to add to the mix and removes the
> dilemma of a
> multifunction device with isn't platform based...

This is where my sugguestion on the ucb1x00 comess in
(although it seems to have ot lost as I have had no
reply :-( ). To repeat myself:

I was thinking of something like driver/bus into which
we might also be able to put the I2C and LL3 buses.
The only problem is that this might leave some parts
of the multi function chip homeless (if they can't
find a home in other subsystems).

I need to do more homework ;-), but
I think we need a bus driver (I need to see what the
bus subsystem offers) (IP block specific,
platform and arch independent), a core driver to
register busses and clients, and client drivers.

Mark


>=20
> Richard
>=20
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=20
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20



	=09
___________________________________________________________=20
To help you stay safe and secure online, we've developed the all new Yaho=
o! Security Centre. http://uk.security.yahoo.com


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
