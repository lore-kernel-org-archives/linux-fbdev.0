From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Changing modes with fbset
Date: Tue, 06 Jan 2004 11:33:53 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1073349202.9503.178.camel@gaston>
References: <Pine.LNX.4.44.0401060005511.7347-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AdfBh-0006ux-Np
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jan 2004 16:35:13 -0800
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AdfBh-00077s-1P
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jan 2004 16:35:13 -0800
In-Reply-To: <Pine.LNX.4.44.0401060005511.7347-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: John Zielinski <grim@undead.cc>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2004-01-06 at 11:06, James Simmons wrote:
> Applied. Thanks for finding that.

Still... I don't get anything useful with just calling fbcon_resize,
though I do get something right if I actually call vc_resize. There is
a possible problem with "looping" between the callback and resize that
I currently fixed with a global flag. Note that the whole stty thing
only works properly if the fbdev do some mode validation (see my
note about FB_ACTIVATE_FIND).

I'm posting a set of patches againts current 2.6.1-rc separately

Ben.
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
