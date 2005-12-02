From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: scroll modes
Date: Fri, 02 Dec 2005 09:16:25 +0800
Message-ID: <438FA069.40605@gmail.com>
References: <438D9E60.7040007@t-online.de> <Pine.LNX.4.62.0511301347230.2123@pademelon.sonytel.be> <438DE211.2060900@t-online.de> <438E0E23.2000203@gmail.com> <438E2D8E.2040503@t-online.de> <438E3D66.8080601@gmail.com> <438F8136.5030005@t-online.de> <438F86F6.9090800@gmail.com> <438F8B9D.1060605@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EhzYN-0005te-7b
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Dec 2005 17:17:35 -0800
Received: from zproxy.gmail.com ([64.233.162.204])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EhzYM-0005Gg-2W
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Dec 2005 17:17:35 -0800
Received: by zproxy.gmail.com with SMTP id z3so127846nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 01 Dec 2005 17:17:33 -0800 (PST)
In-Reply-To: <438F8B9D.1060605@t-online.de>
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
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>

Knut Petersen wrote:
> Antonino A. Daplas schrieb:
>=20
>> I think I see the problem.  Can you try this instead?
>>
>> =20
>>
> I have to get up in 6 hours, so I will check it tomorrow. I think your
> fix is right, the problem
> was  returning with -EINVAL if yoffset + info->var.yres >
> info->var.yres_virtual instead of
> calling the drivers panning function.
>=20
>> Tony
>>
>> PS: Do you still need the previous patch?  The one that adjusts
>> p->vrows?
>>
>> =20
>>
> Don=B4t know,  but it=B4s in my working configuration, so at least it d=
oes
> not break anything.
>=20

I think it's needed, otherwise the entire memory will not be used. But
I'll wait for you to check this out.

> Geert stated that ywrap scrolling should be fine on amifb ... is that
> really true with
> current code?

Most probably, amifb broke too.

Tony


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
