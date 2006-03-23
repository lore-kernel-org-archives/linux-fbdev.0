From: Sylvain Meyer <sylvain.meyer@worldonline.fr>
Subject: Re: [PATCH] [git tree] Intel i9xx support for
 intelfb
Date: Thu, 23 Mar 2006 23:29:42 +0100
Message-ID: <44232156.6060701@worldonline.fr>
References: <21d7e9970603221820p5c89e46fgbd9878a3c60eac0a@mail.gmail.com>	 <b00ca3bd0603222159t63ea0f4j38e085ecff5b93c8@mail.gmail.com> <21d7e9970603222209r45beeb99nccc6435b99b79154@mail.gmail.com> <44229D48.6040502@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMYLE-0004su-0z
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 14:31:40 -0800
Received: from smtp1.wanadoo.fr ([193.252.22.30])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FMYLC-0006Ja-NF
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 14:31:40 -0800
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0112.wanadoo.fr (SMTP Server) with ESMTP id 50B641C00618
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Mar 2006 23:31:32 +0100 (CET)
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org

        Not for all the i2c ports. I will post my code tomorrow.

Regards
Sylvain

Antonino A. Daplas a =E9crit:

>Dave Airlie wrote:
>
> =20
>
>>laptop users with these chipsets, getting DVI working is a bit more
>>work as there are external chips that need to be driven over i2c, so
>>I'll need to at least add i2c support to the i8xx driver. (I noticed
>>Sylvain has done some of this work before)..... I'd like to expose i2c
>>buses to userspace anyways....
>>   =20
>>
>
>Someone mentioned (I think it was Nicholas Boichat) that the i2c code
>of i810fb works for intelfb too, but I cannot verify that.
>
>Tony
>
> =20
>





-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
