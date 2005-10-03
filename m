From: Richard Smith <smithbone@gmail.com>
Subject: Re: VESA, EDID & flat panels
Date: Mon, 3 Oct 2005 18:18:13 -0500
Message-ID: <8a0c36780510031618m48c55f45u648d867bcf0130d2@mail.gmail.com>
References: <1128380013.8267.125.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EMZZd-000618-7z
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 03 Oct 2005 16:18:21 -0700
Received: from zproxy.gmail.com ([64.233.162.207])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EMZZc-0007j8-QQ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 03 Oct 2005 16:18:21 -0700
Received: by zproxy.gmail.com with SMTP id i11so342963nzh
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 03 Oct 2005 16:18:13 -0700 (PDT)
In-Reply-To: <1128380013.8267.125.camel@gaston>
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
Cc: Discuss issues related to the xorg tree <xorg@lists.freedesktop.org>

> Somebody around here has access to the VESA specs ? I'm trying to figure
> out if the EDID block, at least on recent flat panels, tells us wether
> the panel digital input is 6:6:6 or 8:8:8 ... If it's 6:6:6, we should
> enable dithering in drivers like radeon and "nv", while if 8:8:8, we
> should not. If not enabling it on a 6 bits panel, we end up with crappy
> looking gradients, if enabling it on a 8 bits panel, we basically end up
> sending a 6 bits signal to a 8 bits panel, thus reducing the quality.

We have  a copy from a few years ago.  Its not too descriptive if
IIRC.  I'll try to look at it tomorrow.

--
Richard A. Smith


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
