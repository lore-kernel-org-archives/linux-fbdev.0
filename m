From: Jimmy.Jazz@gmx.net
Subject: Re: radeonfb monid i2c bus
Date: Mon, 09 Jun 2008 00:48:22 +0200
Message-ID: <484C61B6.8090902@gmx.net>
References: <20080606120151.7976df45@hyperion.delvare>	<1212760218.12464.33.camel@pasglop>
	<20080608162023.431083c7@hyperion.delvare>
Reply-To: Jimmy.Jazz@gmx.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K5Tgi-0002KX-Vp for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 08 Jun 2008 15:48:37 -0700
Received: from mail.gmx.net ([213.165.64.20])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1K5Tgi-00075E-Ex
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 08 Jun 2008 15:48:36 -0700
Received: from dspam-out (localhost.cryosphere.corp [127.0.0.1])
	by dspam.cryosphere.corp (Postfix) with SMTP id 698D5581A8
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon,  9 Jun 2008 00:48:25 +0200 (CEST)
In-Reply-To: <20080608162023.431083c7@hyperion.delvare>
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
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Jean Delvare a =E9crit :
>
> Where is the code handling this? In radeon_monitor.c I can only see
> radeon_probe_i2c_connector() being called on ddc_vga, ddc_dvi and
> ddc_crt2. No reference to ddc_monid.
>
>   =

You will find several patches that make use of that functionality.  The =

current radeonfd driver is quite incomplete and is unusable for  the =

never cards that use an atom bios.  The driver needs also to be =

patched.  Some of the ati x800 family cards like the one i own will only =

work with the ddc_monid and  one or more of the patches i mentioned.
> But apparently not all chips have the "monid" bus? Or is it a card
> property, and other cards using the same Radeon 9200 might have it
> while mine doesn't? I wouldn't care about an empty i2c bus, but a
> broken bus as I get now affects the whole i2c subsystem and its users
> in unpleasant ways. That's why I am wondering if there's a way to avoid
> it.
>   =

There are certainly many good reasons why the driver will stay =

unchanged. One reason could be, it is stable for most of the users and =

"easily" patchable to fit particular needs. Like me, you need particular =

needs :)




-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
