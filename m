From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH 3/3] [FBDEV]: Hardware State Notification
Date: Fri, 25 Jun 2004 04:46:46 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200406250446.47073.adaplas@hotpop.com>
References: <200406220639.26576.adaplas@hotpop.com> <200406240750.28126.adaplas@hotpop.com> <1088044547.1855.185.camel@gaston>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bdb9g-0005pp-7s
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 24 Jun 2004 13:49:08 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bdb9f-0000o4-PY
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 24 Jun 2004 13:49:07 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id ABDDB674921
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 24 Jun 2004 20:08:44 +0000 (UTC)
In-Reply-To: <1088044547.1855.185.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, adaplas@pol.net
Cc: James Simmons <jsimmons@infradead.org>, Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thursday 24 June 2004 10:35, Benjamin Herrenschmidt wrote:
> On Wed, 2004-06-23 at 18:50, Antonino A. Daplas wrote:
> > Thanks Ben, I see it now. I did not realize it was in the console_blank
> > hook.  (I did not follow this list for a time). And no, I don't think you
> > missed a code path.  The problem is that we are calling
> > fb_set_var->set_par too early, before X has really given up on the
> > hardware. We can fix this by setting some kind of flag while in
> > fbcon_blank,  and depending on the setting of this flag, force a set_par
> > in fbcon_switch instead.
> >
> > I'll concoct a patch later. (I'll test James' new patch first).
>
> That would be a bug in X
>
> If console switching, the 'unblank' is done, afaik, after X calls the ioctl
> to relinguish the console to the kernel.
>
> When exiting X, I'm not sure, but that should be similar. If X still
> touches the HW after that, it's an X bug (and yes, I does that, at least in
> the radeon driver, afaik)
>

Include nvidia into the list.  With the nv driver, the whole machine hangs. 
The i810 has cursor sprite corruption, but has a workaround for it.

So, I would still like to do the set_par as late as possible such as in 
fbcon_switch().  (BTW, this fixes the riva driver)

Tony




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
