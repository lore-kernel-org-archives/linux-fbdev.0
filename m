From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: bk fbdev-2.5 doesn't boot
Date: Sun, 2 May 2004 00:40:00 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040501214000.GA2822@sci.fi>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BK2EO-0002we-DW
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 01 May 2004 14:41:08 -0700
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BK2EN-0001NQ-2H
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 01 May 2004 14:41:07 -0700
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id 2CEB8113BE50
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun,  2 May 2004 00:40:01 +0300 (EEST)
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
Content-Type: text/plain; charset="windows-1254"
To: linux-fbdev-devel@lists.sourceforge.net

I have three computers: a desktop system with Matrox G400, a laptop with=20
Rage Mobility (mach64) and another laptop with Rage LT-Pro. I can't get=20
the fbdev-2.5 bk tree to boot on any of the systems.

The only reason for even trying the bk tree is that I need to get atyfb=20
working on the laptops. 2.4.24 atyfb works with the laptops. 2.6 vanilla=20
and mm work just fine with vesafb and matroxfb but atyfb in those trees i=
s=20
seriously out of date. With the bk tree only vgacon works :(

Does someone have an atyfb-only patch against mm?

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
