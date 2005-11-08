From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 0/8] fbcon: Console Rotation
Date: Tue, 08 Nov 2005 13:37:00 +0800
Message-ID: <4370397C.2040304@gmail.com>
References: <436F33A2.6070107@gmail.com>	<20051107162301.0f7d5bc6.akpm@osdl.org>	<436FF58A.4090506@gmail.com> <20051107171153.28c4a594.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZMAm-0001aa-2c
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Nov 2005 21:37:32 -0800
Received: from xproxy.gmail.com ([66.249.82.198])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EZMAk-0003Vd-O5
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Nov 2005 21:37:32 -0800
Received: by xproxy.gmail.com with SMTP id h29so546643wxd
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 07 Nov 2005 21:37:30 -0800 (PST)
In-Reply-To: <20051107171153.28c4a594.akpm@osdl.org>
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

Andrew Morton wrote:
> "Antonino A. Daplas" <adaplas@gmail.com> wrote:
>> Andrew Morton wrote:
>>> "Antonino A. Daplas" <adaplas@gmail.com> wrote:
>> The rest are cleanups and can wait.
> 
> Well I was also referring to the rotation patches - a new feature.
> 
> I guess you'd like them in 2.6.15.  Ho hum.
> 

Not really, I already had a patch much similar to this since 2.5.x,
but never pushed it, so it can wait a few kernel versions. I would
rather that they get the testing for as long as possible. It's the
Zaurus people that may actually want this feature just because they
need it, but I believe they have their own development kernel with
this patch already included.

Unfortunately though, this patch substantially changed fbcon.c, so
any other patch affecting that file may have to wait or risk
conflicts in the future.

Tony 
 



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
