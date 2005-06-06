From: Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC/PATCH 2.6.12-rc5 1/1] Framebuffer driver for Arc LCD board
Date: Mon, 6 Jun 2005 14:43:52 -0700
Message-ID: <20050606144352.140cfe42.akpm@osdl.org>
References: <200506061416.j56EG18b017582@intworks.biz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DfPNK-0003Ym-7Z
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 06 Jun 2005 14:43:14 -0700
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DfPNJ-0003Mp-6h
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 06 Jun 2005 14:43:13 -0700
In-Reply-To: <200506061416.j56EG18b017582@intworks.biz>
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
To: jayalk@intworks.biz
Cc: adaplas@pol.net, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

jayalk@intworks.biz wrote:
>
> I did this diff against
> rc5. Should I be doing it against -mm instead?

I generally prefer diffs against whatever is in -mm, mainly so we can see
what changed, and so that we can make sure that everyones fixups didn't get
lost.

If a patch has only been in -mm for a short period then a wholesale
replacement is OK.  It gets a bit complex because people do insist on trying
to add lots of trailing whitespace to the tree and I do insist on thwarting
them, but I fix all that up.

In this case I got anal and turned your new patch into an incremental one ;)


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
