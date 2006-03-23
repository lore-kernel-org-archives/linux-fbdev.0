From: "Dave Airlie" <airlied@gmail.com>
Subject: Re: [PATCH] [git tree] Intel i9xx support for intelfb
Date: Thu, 23 Mar 2006 17:09:56 +1100
Message-ID: <21d7e9970603222209r45beeb99nccc6435b99b79154@mail.gmail.com>
References: <21d7e9970603221820p5c89e46fgbd9878a3c60eac0a@mail.gmail.com>
	 <b00ca3bd0603222159t63ea0f4j38e085ecff5b93c8@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMJ1D-0001nE-69
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 22 Mar 2006 22:09:59 -0800
Received: from nproxy.gmail.com ([64.233.182.197])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FMJ1C-0004eo-Pm
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 22 Mar 2006 22:09:59 -0800
Received: by nproxy.gmail.com with SMTP id a25so256508nfc
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 22 Mar 2006 22:09:57 -0800 (PST)
In-Reply-To: <b00ca3bd0603222159t63ea0f4j38e085ecff5b93c8@mail.gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sylvain.meyer@worldonline.fr, akpm@osdl.org

> >
> > This code isn't perfect but I've got no documentation so I cannot
> > answer some questions on what exactly is going on just yet...
>
> Better than nothing, and if it works for digital displays, then that
> would be great.

It doesn't support LVDS or DVI yet but I'm hoping to make it go in
that direction, I've no LVDS h/w, and some chipsets have it integrated
and some don't, but this is a better basis for future work, and I'll
have no problems keeping it updated with fixes as they come from the
X.org driver... I'd like to get at least LVDS support working for
laptop users with these chipsets, getting DVI working is a bit more
work as there are external chips that need to be driven over i2c, so
I'll need to at least add i2c support to the i8xx driver. (I noticed
Sylvain has done some of this work before)..... I'd like to expose i2c
buses to userspace anyways....

> There's no git tree for the framebuffer layer, I just send updates
> directly to akpm. Andrew?
>

I'd like to keep the git history if possible, so maybe we can pull
this tree into -mm and I can get it pulled by Linus later.

Regards,
Dave


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
