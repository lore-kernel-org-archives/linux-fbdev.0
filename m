From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: fbset noaccel
Date: Mon, 31 May 2004 09:08:12 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200405310908.12783.adaplas@hotpop.com>
References: <40B7296B.4030804@winischhofer.net> <1085819816.40b84ba84f22d@mail.theboonies.us> <1085832863.40b87e9fde073@mail.theboonies.us>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BUbIK-0001j4-SB
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 30 May 2004 18:08:52 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BUbIK-0001ll-85
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 30 May 2004 18:08:52 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id 220B2554189
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 31 May 2004 00:35:35 +0000 (UTC)
In-Reply-To: <1085832863.40b87e9fde073@mail.theboonies.us>
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
To: David Eger <eger-dated-1086437670.7c6138@theboonies.us>, David Eger <eger-sender-da68b9@theboonies.us>, linux-fbdev-devel@lists.sourceforge.net

On Saturday 29 May 2004 20:14, David Eger wrote:
> [ reads through fbset code ]
>
> So it looks like fbset turns off acceleration by setting up the accel flag
> in var (that FB_ACCELF_TEXT oddity).
>
> While it makes sense that changing acceleration is a mode-switch item
> (quiescing video engine and such), it seems more like it should be an ioctl
> (or sysfs!) thing now...  Changing certain bits of var and hoping that
> set_var() will guess in the correct way seems generally b0rken...
>
> comments?
>

It's not as bad as it seems.  As long as an accelerated driver does not ignore 
this flag and properly flushes->syncs->disables the accel engine on a 
set_var, it should work.  Plus, a lot of apps clear/depend on this flag 
(XFree86-fbdev, fbset, DirectFB, etc).

I agree though that turning off/syncing/flushing the accel engine deserves 
it's own ioctl/method so as to completely separate it from mode switching 
which is a different process in itself.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
