From: Andrew Zabolotny <zap@homelink.ru>
Subject: Re: [Bugme-new] [Bug 4047] New: kerenl failt to
 kompile
Date: Tue, 18 Jan 2005 22:17:25 +0300
Message-ID: <20050118221725.4a68dbff.zap@homelink.ru>
References: <20050117004141.2dcb1e0f.zap@homelink.ru>
	<200501180504.07500.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cqyr8-0006u4-Lq
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Jan 2005 11:17:34 -0800
Received: from mail.homelink.ru ([81.9.33.123] helo=eltel.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Cqyr6-0003H0-PF
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Jan 2005 11:17:34 -0800
In-Reply-To: <200501180504.07500.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: adaplas@hotpop.com, linux-fbdev-devel@lists.sourceforge.net

On Tue, 18 Jan 2005 05:04:04 +0800
"Antonino A. Daplas" <adaplas@hotpop.com> wrote:

> > Here's an obvious fix plus a minor enhancement.
> Would it be better if backlight/lcd support is not fully dependent on
> the framebuffer? 
> It's your call, so I'm still submitting this patch to akpm.
I thought about it, but I don't see a lot of reasons for having
backlight without the framebuffer. Theoretically the FB-related stuff
could be enclosed within #if FB's but it would clutter the code. If
somebody will have a real reason for it, I think he'll quickly find out
how this can be achieved.

-- 
Greetings,
   Andrew


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
