From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/8] fbcon: Console Rotation
Date: Mon, 7 Nov 2005 22:16:07 -0800
Message-ID: <20051107221607.76a6c521.akpm@osdl.org>
References: <436F33A2.6070107@gmail.com>
	<20051107162301.0f7d5bc6.akpm@osdl.org>
	<436FF58A.4090506@gmail.com>
	<20051107171153.28c4a594.akpm@osdl.org>
	<4370397C.2040304@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZMmL-0002v9-U4
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Nov 2005 22:16:21 -0800
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1EZMmL-00015b-Gg
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Nov 2005 22:16:21 -0800
In-Reply-To: <4370397C.2040304@gmail.com>
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
Cc: linux-fbdev-devel@lists.sourceforge.net

"Antonino A. Daplas" <adaplas@gmail.com> wrote:
>
> Unfortunately though, this patch substantially changed fbcon.c, so
>  any other patch affecting that file may have to wait or risk
>  conflicts in the future.

Yes, that's a problem.  We _could_ just slam this in this week and grit our
teeth.  How would you evaluate the risk of regressions to existing setups?


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
