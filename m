From: Jim Hague <jim.hague@acm.org>
Subject: Re: New API and X option UseFBDev
Date: Tue, 09 Sep 2003 14:53:10 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030909145310.jim.hague@acm.org>
References: <1063099315.1407.43.camel@thor.holligenstrasse29.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wivi-0003gn-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 09 Sep 2003 06:53:14 -0700
Received: from mta05-svc.ntlworld.com ([62.253.162.45])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19wivh-0007Pu-DZ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Sep 2003 06:53:13 -0700
In-Reply-To: <1063099315.1407.43.camel@thor.holligenstrasse29.lan>
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
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: linux-fbdev-devel@lists.sourceforge.net

On 09-Sep-2003 Michel D=E4nzer wrote:
> On Tue, 2003-09-09 at 08:49, Jim Hague wrote:
>> I have a problem when I try and run X (Debian 4.2.1-11 20030829103906). =
My
>> config uses the Glint driver with UseFBDev true, and works fine on 2.4.2=
2.
>> [...]
>> It's occurred to me that maybe this just doesn't work and I need an upda=
ted
>> fbdevhw. Do I? Or should it really Just Work?
>=20
> It should just work, certainly does here with the radeon driver and
> radeonfb. I'd add some debugging output to the framebuffer device and/or
> fbdevHW.

Thanks for that. I'll keep digging into this, and cross-check with the rade=
on
driver for clues.

--=20
Jim Hague - jim.hague@acm.org          Never trust a computer you can't lif=
t.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
