From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/3] [FBDEV]: Hardware State
	Notification
Date: Wed, 23 Jun 2004 21:35:49 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1088044547.1855.185.camel@gaston>
References: <200406220639.26576.adaplas@hotpop.com>
	 <1088006572.1855.154.camel@gaston>  <200406240750.28126.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BdK7W-00010T-U7
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 19:37:46 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BdK7W-0000Ic-H2
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 19:37:46 -0700
In-Reply-To: <200406240750.28126.adaplas@hotpop.com>
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
Cc: James Simmons <jsimmons@infradead.org>, Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2004-06-23 at 18:50, Antonino A. Daplas wrote:

> Thanks Ben, I see it now. I did not realize it was in the console_blank hook.  (I did
> not follow this list for a time). And no, I don't think you missed a code path.  The 
> problem is that we are calling fb_set_var->set_par too early, before X has really
> given up on the hardware. We can fix this by setting some kind of flag while in
> fbcon_blank,  and depending on the setting of this flag, force a set_par in 
> fbcon_switch instead.
> 
> I'll concoct a patch later. (I'll test James' new patch first).

That would be a bug in X

If console switching, the 'unblank' is done, afaik, after X calls the ioctl
to relinguish the console to the kernel.

When exiting X, I'm not sure, but that should be similar. If X still touches
the HW after that, it's an X bug (and yes, I does that, at least in the radeon
driver, afaik)

Ben.




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
