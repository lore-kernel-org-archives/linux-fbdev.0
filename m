From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH 3/3] [FBDEV]: Hardware State Notification
Date: Thu, 24 Jun 2004 07:50:28 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200406240750.28126.adaplas@hotpop.com>
References: <200406220639.26576.adaplas@hotpop.com> <1088006572.1855.154.camel@gaston>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BdHTK-0007wV-Gy
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 16:48:06 -0700
Received: from snickers.hotpop.com ([38.113.3.51])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BdHTK-00075C-2Q
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 16:48:06 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by snickers.hotpop.com (Postfix) with SMTP id C6C4C73DCF
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 23 Jun 2004 22:45:41 +0000 (UTC)
In-Reply-To: <1088006572.1855.154.camel@gaston>
Content-Disposition: inline
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>, Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thursday 24 June 2004 00:02, Benjamin Herrenschmidt wrote:
> You don't need that. A method for that was _ALREADY_ added to the kernel,
> it's based on the fact that the blank() callback is called on switches
> between KD_TEXT and KD_GRAPHICS. After discussing the issue with Linus,
> we decided to add a parameter to it indicating the nature of the
> switch. You should be able to rely on that. Actually, if you look at
> the code, I'm forcing a set_par in this case. If this doesn't work, then
> I may have missed a code path, and that should be fixed but there is no
> need at this point to change the infrastructure.
>

Thanks Ben, I see it now. I did not realize it was in the console_blank hook.  (I did
not follow this list for a time). And no, I don't think you missed a code path.  The 
problem is that we are calling fb_set_var->set_par too early, before X has really
given up on the hardware. We can fix this by setting some kind of flag while in
fbcon_blank,  and depending on the setting of this flag, force a set_par in 
fbcon_switch instead.

I'll concoct a patch later. (I'll test James' new patch first).

Tony




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
