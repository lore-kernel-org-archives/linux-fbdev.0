From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: 2.5.71, fbconsole: No boot logo?
Date: Tue, 17 Jun 2003 18:27:31 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306171821080.15267-100000@phoenix.infradead.org>
References: <3EEF489D.4050303@myrealbox.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19SKFb-0005n6-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 17 Jun 2003 10:28:08 -0700
In-Reply-To: <3EEF489D.4050303@myrealbox.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicholas Wourms <nwourms@myrealbox.com>
Cc: linux-fbdev-devel@lists.sourceforge.net


> I see the same problem on my smp box with a G450.  

The issues is a bug in cfb_imageblit. I have a patch for it.

> Speaking of which, 
> this stripped down driver really bites.  This is no offense to Petr, 
> since I *know* it isn't his fault that he was restricted by the new 
> fbdev API.  

The api is not restrictive in any way. The code is in there just not 
finished in some ways. A good example is EDID support. 

> James, can't you compromise with Petr on a few of your 
> changes so that the missing original, fully featured matroxfb driver 
> bits can be merged.  

I'm working on some new stuff right now. More cleanup for the cursor api.
The changes to the cursor api will also allow fast fonts which the matrox 
hardware can support and texture mapped fonts. 





-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
