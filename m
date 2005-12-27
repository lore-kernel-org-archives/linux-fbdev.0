From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: fbcon rotation or cyblafb bugs?
Date: Tue, 27 Dec 2005 08:43:03 +0100
Message-ID: <43B0F087.1070405@t-online.de>
References: <43AFC436.9090002@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Er9Sp-0007uE-6B
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 26 Dec 2005 23:41:43 -0800
Received: from mailout07.sul.t-online.com ([194.25.134.83])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Er9So-0001Xh-11
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 26 Dec 2005 23:41:43 -0800
In-Reply-To: <43AFC436.9090002@t-online.de>
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
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Knut Petersen schrieb:

> Can anybody confirm that clockwise / counterclockwise console rotation=20
> is working
> or not working for arbitrary virtual x resolutions? Using cyblafb I=20
> get solid lockups
> for certain combinations of font height and vxres. It does work=20
> perfectly reliable for
> other combinations. It would be really nice if someone could run a=20
> test like e.g.


Forget about that help request, my problems are caused by a hardware bug=20
of the
cyberblade/i1 graphics core.

Whenever an imageblit tries to blit across  pixel colum 2048, the=20
graphics engine locks up.
Rock solid. Isn=B4t that a nice christmas gift?

cu,
 knut


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
