From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [patch 1/1] delete unused file
Date: Mon, 10 Jan 2005 05:15:50 +0800
Message-ID: <200501100515.52513.adaplas@hotpop.com>
References: <20041226151328.47F751ECC0@trashy.coderock.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CnkPw-0006vR-Mb
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 09 Jan 2005 13:16:08 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CnkPu-0001f2-M5
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 09 Jan 2005 13:16:08 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 42EB61337433
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun,  9 Jan 2005 21:15:51 +0000 (UTC)
In-Reply-To: <20041226151328.47F751ECC0@trashy.coderock.org>
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
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, domen@coderock.org

On Sunday 26 December 2004 23:13, domen@coderock.org wrote:
> Remove nowhere referenced file. (egrep "filename\." didn't find anything)
>

This file is now being used for BIOS-less booting of Rage XL cards in
2.6.10-mm1.

Tony




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
