From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Bugme-new] [Bug 4047] New: kerenl failt to kompile
Date: Tue, 18 Jan 2005 05:04:04 +0800
Message-ID: <200501180504.07500.adaplas@hotpop.com>
References: <20050117004141.2dcb1e0f.zap@homelink.ru>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cqe2w-00017b-7m
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 Jan 2005 13:04:22 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Cqe2u-0001x6-Hr
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 Jan 2005 13:04:22 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id A38C8CFE891
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 17 Jan 2005 21:04:07 +0000 (UTC)
In-Reply-To: <20050117004141.2dcb1e0f.zap@homelink.ru>
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
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Zabolotny <zap@homelink.ru>

On Monday 17 January 2005 05:41, Andrew Zabolotny wrote:
> Hello!
>
> > Date: Sun, 16 Jan 2005 03:14:57 -0800
> > From: bugme-daemon@osdl.org
> > To: bugme-new@lists.osdl.org
> > Subject: [Bugme-new] [Bug 4047] New: kerenl failt to kompile
> >
> > http://bugme.osdl.org/show_bug.cgi?id=4047
> >
> >           Summary: kerenl failt to kompile
> >    Kernel Version: 2.6.11-rc1-mm1
> >            Status: NEW
> >          Severity: blocking
> >             Owner: jsimmons@infradead.org
> >         Submitter: bug-track@fisher-privat.net
> >
> >
> > Distribution:Debian Sarge
> >
> > Problem Description:
> > LD      init/built-in.o
> >  LD      .tmp_vmlinux1
> >
> > drivers/built-in.o(.text+0x9bfa): In function `lcd_device_register':
> > : undefined reference to `fb_register_client'
>
> Here's an obvious fix plus a minor enhancement.

Would it be better if backlight/lcd support is not fully dependent on the
framebuffer? 

It's your call, so I'm still submitting this patch to akpm.

Tony 




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
