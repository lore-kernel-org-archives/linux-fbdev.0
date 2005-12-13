From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: scrollmode selection problem
Date: Wed, 14 Dec 2005 00:09:06 +0800
Message-ID: <439EF222.6040408@gmail.com>
References: <439DB5A3.9050205@t-online.de> <Pine.LNX.4.62.0512131206120.17990@pademelon.sonytel.be> <439EBE5E.1040007@t-online.de> <439EF112.6090006@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EmCiJ-0004xl-UG
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Dec 2005 08:09:15 -0800
Received: from zproxy.gmail.com ([64.233.162.199])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EmCiJ-0001zo-J4
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Dec 2005 08:09:15 -0800
Received: by zproxy.gmail.com with SMTP id 4so1746542nzn
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 13 Dec 2005 08:09:15 -0800 (PST)
In-Reply-To: <439EF112.6090006@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Antonino A. Daplas wrote:
> Knut Petersen wrote:
>>> This used to work fine (garbage in borders was cleared when fbcon did
>>> pan/wrap), so I consider it a regression.
>>>
>>> =20
>>>
>> Well, it definitely is broken. If you don=C2=B4t have a quick fix, we =
should
>> disable
>> that code path for 2.6.15 as I suggested.
>=20
> What if you insert
>=20
> 	fbcon_clear_margins(vc, 1);
>=20
> after
> 	ops->update_start(info);
>=20
> in ywrap_up() and ywrap_down() inf fbcon.c?

Forget this, it won't work. ops->clear_margins will need to be
rewritten so it recognizes when it's in the ywrap boundary.

Tony


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
