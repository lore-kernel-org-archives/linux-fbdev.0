From: Sylvain Meyer <sylvain.meyer@worldonline.fr>
Subject: Re: [Linux-fbdev-devel] [PATCH] [git tree] Intel i9xx support for
 intelfb
Date: Thu, 23 Mar 2006 18:57:05 +0100
Message-ID: <4422E171.1040909@worldonline.fr>
References: <21d7e9970603221820p5c89e46fgbd9878a3c60eac0a@mail.gmail.com>	 <b00ca3bd0603222159t63ea0f4j38e085ecff5b93c8@mail.gmail.com> <21d7e9970603222209r45beeb99nccc6435b99b79154@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422640AbWCWR7M@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org

        Sorry for my very long silence.

=46or i2c support. I've done it to have a workable tv-out on my hardwar=
e.=20
It was the main reason  why i ported the driver to kernels 2.6 as i use=
=20
my computer as a set-top-box only connected to a tv. I've it on my own=20
tree (very old).
I can send you the code. I did it in a way not accepted by kernel=20
reviewers as my tv driver (for chrontel ch7011 chipset) is all in kerne=
l=20
space. But it can be a base for a better scheme.

Regards
Sylvain

Dave Airlie a =E9crit:

>>>This code isn't perfect but I've got no documentation so I cannot
>>>answer some questions on what exactly is going on just yet...
>>>     =20
>>>
>>Better than nothing, and if it works for digital displays, then that
>>would be great.
>>   =20
>>
>
>It doesn't support LVDS or DVI yet but I'm hoping to make it go in
>that direction, I've no LVDS h/w, and some chipsets have it integrated
>and some don't, but this is a better basis for future work, and I'll
>have no problems keeping it updated with fixes as they come from the
>X.org driver... I'd like to get at least LVDS support working for
>laptop users with these chipsets, getting DVI working is a bit more
>work as there are external chips that need to be driven over i2c, so
>I'll need to at least add i2c support to the i8xx driver. (I noticed
>Sylvain has done some of this work before)..... I'd like to expose i2c
>buses to userspace anyways....
>
> =20
>
>>There's no git tree for the framebuffer layer, I just send updates
>>directly to akpm. Andrew?
>>
>>   =20
>>
>
>I'd like to keep the git history if possible, so maybe we can pull
>this tree into -mm and I can get it pulled by Linus later.
>
>Regards,
>Dave
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by xPML, a groundbreaking scripting lan=
guage
>that extends applications into web and mobile media. Attend the live w=
ebcast
>and join the prime developer group breaking into this new coding terri=
tory!
>http://sel.as-us.falkag.net/sel?cmd=3Dk&kid=110944&bid$1720&dat=121642
>_______________________________________________
>Linux-fbdev-devel mailing list
>Linux-fbdev-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>
> =20
>
