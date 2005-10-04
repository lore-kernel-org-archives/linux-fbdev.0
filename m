From: Richard Smith <smithbone@gmail.com>
Subject: Re: VESA, EDID & flat panels
Date: Tue, 4 Oct 2005 07:35:01 -0500
Message-ID: <8a0c36780510040535g16a3074p66384d8b07d03ea1@mail.gmail.com>
References: <1128380013.8267.125.camel@gaston>
	 <8a0c36780510031618m48c55f45u648d867bcf0130d2@mail.gmail.com>
	 <1128397436.31063.0.camel@gaston> <434220D0.3020101@gmail.com>
	 <1128407961.31063.50.camel@gaston> <43423666.8090001@gmail.com>
	 <1128415836.6291.12.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EMm0k-0004WA-UH
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 04 Oct 2005 05:35:10 -0700
Received: from zproxy.gmail.com ([64.233.162.207])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EMm0h-00067q-Dd
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 04 Oct 2005 05:35:07 -0700
Received: by zproxy.gmail.com with SMTP id i11so398111nzh
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 04 Oct 2005 05:35:01 -0700 (PDT)
In-Reply-To: <1128415836.6291.12.camel@gaston>
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

> So I wonder how widespread really is that EEDID stuff... I'm afraid the
> reason a lot of monitors come with a windows install CD is that they do
> _not_ provide those infos via EDID, but windows has a database with
> per-monitor infos (as Apple actually has in OS X) and we should probably
> do something similar. (but not in the kernel)

Our experience agrees with you that the EEDID stuff is not well used.=20
We make some LCD driver products and I'm pretty sure we didn't include
the EEDID info.

I gave the specs a quick look and I don't see anything in (thats
obvious) there that would allow you to see if the panel is 666 or 888.
The specs are somewhat less than clear in several cases so I'll be
happy to review any sections closer if you think one might be a
possibility.

--
Richard A. Smith


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
