From: Antonino Daplas <adaplas@gmail.com>
Subject: Re: [PATCH 0/8] fbcon: Console Rotation
Date: Tue, 8 Nov 2005 14:26:54 +0800
Message-ID: <b00ca3bd0511072226l75a42b43ta8831992a6dff343@mail.gmail.com>
References: <436F33A2.6070107@gmail.com>
	 <20051107162301.0f7d5bc6.akpm@osdl.org> <436FF58A.4090506@gmail.com>
	 <20051107171153.28c4a594.akpm@osdl.org> <4370397C.2040304@gmail.com>
	 <20051107221607.76a6c521.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZMwa-0003H2-O5
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Nov 2005 22:26:56 -0800
Received: from zproxy.gmail.com ([64.233.162.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EZMwZ-00052G-HY
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Nov 2005 22:26:56 -0800
Received: by zproxy.gmail.com with SMTP id 40so464738nzk
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 07 Nov 2005 22:26:54 -0800 (PST)
In-Reply-To: <20051107221607.76a6c521.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On 11/8/05, Andrew Morton <akpm@osdl.org> wrote:
> "Antonino A. Daplas" <adaplas@gmail.com> wrote:
> >
> > Unfortunately though, this patch substantially changed fbcon.c, so
> >  any other patch affecting that file may have to wait or risk
> >  conflicts in the future.
>
> Yes, that's a problem.  We _could_ just slam this in this week and grit o=
ur
> teeth.  How would you evaluate the risk of regressions to existing setups=
?

Low, if rotation is disabled. Most of the rotation code will be
compiled as no-ops.

Tony


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
