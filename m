From: James Simmons <jsimmons@infradead.org>
Subject: Re: Vertical retrace interrupts?
Date: Tue, 28 Jan 2003 19:21:30 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301281920520.12076-100000@phoenix.infradead.org>
References: <1043545888.3795.2.camel@h9n1fls20o980.telia.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18dbJ6-0004NT-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 28 Jan 2003 11:22:05 -0800
In-Reply-To: <1043545888.3795.2.camel@h9n1fls20o980.telia.com>
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
To: Fredrik Noring <noring@nocrew.org>
Cc: linux-fbdev-devel@lists.sourceforge.net


> Are there any plans on merging DirectFB features? Stuff like vertical
> retrace interrupts etc.?

Thats already supported. Just add a poll function to fb_ops. To date no 
one has used this feature.




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
