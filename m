From: James Simmons <jsimmons@infradead.org>
Subject: Re: Changing modes with fbset
Date: Tue, 6 Jan 2004 00:38:32 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0401060036120.7347-100000@phoenix.infradead.org>
References: <1073349202.9503.178.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AdfEz-0007OC-02
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jan 2004 16:38:37 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AdfEy-0000Hq-73
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jan 2004 16:38:36 -0800
In-Reply-To: <1073349202.9503.178.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: John Zielinski <grim@undead.cc>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Still... I don't get anything useful with just calling fbcon_resize,
> though I do get something right if I actually call vc_resize. There is
> a possible problem with "looping" between the callback and resize that
> I currently fixed with a global flag. Note that the whole stty thing
> only works properly if the fbdev do some mode validation (see my
> note about FB_ACTIVATE_FIND).
> 
> I'm posting a set of patches againts current 2.6.1-rc separately

Your right. We need to call vc_resize.



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
