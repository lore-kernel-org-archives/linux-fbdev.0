From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Reading the EDID block for x86 machines
Date: Wed, 12 Mar 2003 14:10:22 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030312141022.A6984@sci.fi>
References: <1047386934.1113.35.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from kura.mail.jippii.net ([195.197.172.113])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18t52Q-0002fr-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 12 Mar 2003 04:08:50 -0800
Received: from simpukka.saunalahti.fi (simpukka.saunalahti.fi [195.74.0.20])
	by kura.mail.jippii.net (Postfix) with ESMTP id F218E2483F0
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 12 Mar 2003 14:08:46 +0200 (EET)
Received: (from syrjala@localhost) by simpukka.saunalahti.fi (8.8.5/8.8.3) id OAA09322 for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 Mar 2003 14:10:22 +0200 (EET)
In-Reply-To: <1047386934.1113.35.camel@localhost.localdomain>; from adaplas@pol.net on Tue, Mar 11, 2003 at 08:49:46PM +0800
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, Mar 11, 2003 at 08:49:46PM +0800, Antonino Daplas wrote:
> Hi,
>=20
> I was wondering how to get the EDID block, and my first thought was to
> implement DDC.  But it is tricky to implement,

Forgive my ignorance but why is it tricky? As I understand it DDC1 only
involves reading from the monitor or does EDID require something more?

Reading stuff from my monitor via /dev/i2c works fine with matroxfb. I
just tried this and I can see my monitors model in the returned data but
parse-edid doesn't understand the data so I'm not sure it's the EDID.

Also the BIOS solution will fail when someone decides to change their
monitor. This got me thinking that with a real DDC solution would it be
feasible to have the driver re-read the EDID periodically and/or on mode
switch to prevent using bad modes?

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
