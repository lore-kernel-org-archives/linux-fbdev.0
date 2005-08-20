From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: mono, gray and index configs
Date: Fri, 19 Aug 2005 21:13:52 -0400
Message-ID: <9e473391050819181321f2cfe5@mail.gmail.com>
References: <9e47339105081020216574ac7e@mail.gmail.com>
	 <42FAE3F8.8080902@gmail.com>
	 <Pine.LNX.4.62.0508111020520.1037@numbat.sonytel.be>
	 <b00ca3bd05081104086fa9e639@mail.gmail.com>
	 <Pine.LNX.4.62.0508111344070.1037@numbat.sonytel.be>
	 <42FB8C29.4070503@gmail.com>
	 <9e47339105081112142c67e1a8@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E6HwC-0005kK-FR
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Aug 2005 18:14:20 -0700
Received: from wproxy.gmail.com ([64.233.184.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E6Hvx-0006MH-TA
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Aug 2005 18:14:20 -0700
Received: by wproxy.gmail.com with SMTP id i3so658960wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 19 Aug 2005 18:13:58 -0700 (PDT)
In-Reply-To: <9e47339105081112142c67e1a8@mail.gmail.com>
Content-Disposition: inline
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Could everyone give this a try and give me some feedback?

On 8/11/05, Jon Smirl <jonsmirl@gmail.com> wrote:
> Here's a new version that actually lets me set all possible scanout
> configs on radeonfb. I can even set I4 but I don't think the code is
> correct for it yet everywhere in radeonfb. The core code in the patch
> should be ok. My further changes should be restricted to the radeonfb
> code. For example, I haven't added the logic to radeonfb to "round up"
> to the next config.
>=20
> You get two new sysfs attributes:
> configs - optional, but really nice to have, list of all configs
> supported by the driver
> config - current config the hardware is set to.
>=20
> example syntax...
> [root@jonsmirl fb0]# cat configs
> I4
> I8
> A1R5G5B5
> R5G6B5
> R8G8B8
> A8R8G8B8
> A4R4G4B4
> A8I8
> A2R10G10B10
>=20
> Offsets are computed from the field widths. So if a card sets BGR vs
> RGB and you cat its config you will see RGB or BGR in the config
> string. M is used for a grayscale field.
>=20
> So give the patch a try and start expanding it to handle other cards.
>=20
> --
> Jon Smirl
> jonsmirl@gmail.com
>=20
>=20
>=20


--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
