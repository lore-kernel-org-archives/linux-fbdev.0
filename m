From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [patch] video/i810: module_param fixes
Date: Mon, 10 Jan 2005 05:16:13 +0800
Message-ID: <200501100516.13769.adaplas@hotpop.com>
References: <20041229094707.GB21404@nd47.coderock.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CnkR4-0006y7-GM
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 09 Jan 2005 13:17:18 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CnkR4-0000eV-2t
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 09 Jan 2005 13:17:18 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 61019CDB582
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun,  9 Jan 2005 21:16:20 +0000 (UTC)
In-Reply-To: <20041229094707.GB21404@nd47.coderock.org>
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
To: Domen Puncer <domen@coderock.org>, adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net

On Wednesday 29 December 2004 17:47, Domen Puncer wrote:
> Last parameter is file permition in sysfs, not default value.
> (If 0, file is not accessible trough sysfs, and that's what i did.)
>
>
> Signed-off-by: Domen Puncer <domen@coderock.org>

Thank you for the fix.

Tony




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
