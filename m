From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH 4/9] fbcon/fbdev: Add blanking notification
Date: Thu, 13 Jan 2005 04:24:05 +0800
Message-ID: <200501130424.11594.adaplas@hotpop.com>
References: <20041221213648.89B701A0278@smtp-1.hotpop.com> <009001c4f893$87964630$0f01a8c0@max>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cop5c-0006ch-AJ
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 Jan 2005 12:27:36 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Cop5U-0005SX-Hd
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 Jan 2005 12:27:31 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 68B4E133E130
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 12 Jan 2005 20:26:49 +0000 (UTC)
In-Reply-To: <009001c4f893$87964630$0f01a8c0@max>
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
To: Richard Purdie <rpurdie@rpsys.net>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Wednesday 12 January 2005 18:43, Richard Purdie wrote:
> Tony,
>
> I've just switched to using this patch when I updated to 2.6.11-rc1 and
> I've noticed a problem. Basically my code which is monitoring
> FB_EVENT_BLANK events doesn't see any.

If fb_blank is directly called by fbcon_blank, it might proceed into an unending
cycle...

fb_blank()->blank_event_notify->do_blank_screen()->fbcon_blank()->fb_blank()

...however, we do store the current blank state in ops->blank_state, so the above
is probably an imaginary problem.

I'll do the call to fb_blank() instead of info->fbops->fb_blank() instead.

(I'm still in the process of resyncing my tree and merging pending patches,
just came back from a break).

Tony





-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
