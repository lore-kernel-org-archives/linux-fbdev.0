From: Lia Maggioni <voloterreno@tin.it>
Subject: VESAFB ,YWRAP and screen glitches
Date: Tue, 8 Jul 2003 01:45:31 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <187610BC-B0D5-11D7-804B-00039387DFA2@tin.it>
References: <EEA72549-B0D3-11D7-804B-00039387DFA2@tin.it>
Mime-Version: 1.0 (Apple Message framework v482)
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from vsmtp2.tin.it ([212.216.176.222])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19Zfc2-00072U-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 07 Jul 2003 16:41:38 -0700
Received: from localhost (62.211.128.197) by vsmtp2.tin.it (6.7.016)
        id 3EE0613200C3ED40 for linux-fbdev-devel@lists.sourceforge.net; Tue, 8 Jul 2003 01:41:32 +0200
In-Reply-To: <EEA72549-B0D3-11D7-804B-00039387DFA2@tin.it>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net


Marted=EC, luglio 8, 2003, alle 01:37 , Lia Maggioni ha scritto:

>
> When I start the system with YWRAP activated I have scrolling=20
> problems , in fact when I make the screen scrolling for a while (for=20=

> example during the examination of a document with "less" or during the=20=

> compilation of a software) , on the screen starts appear colored lines=20=

> on the screen and these starts scrolling . When the screen is full of=20=

> this lines these disappear and the text is back , but after few scroll=20=

> again these lines appears. With 2.4.21-ac4 kernel the problem is more=20=

> evident than the 2.4.21 "vanilla" .  If I reboot the system doesn't=20
> appears lines anymore, but instead of the lines appears words of the=20=

> precedent boot of the system, seems like that the video memory have =
not=20
> been reset , and that the FB takes parts of the Video data Junk=20
> remained after the reboot and visualize these on the screen. Seems =
like=20
> an error in addressing the video memory .
>
> With 2.4.20 and precedent this doesn't happen .
>
> Please help me :cry:
>
> Bye
>
> marcello
>
>
>
> -------------------------------------------------------
> This SF.Net email sponsored by: Free pre-built ASP.NET sites including
> Data Reports, E-commerce, Portals, and Forums are available now.
> Download today and enter to win an XBOX or Visual Studio .NET.
> =
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
