From: James Simmons <jsimmons@infradead.org>
Subject: Re: rivafb "Badness" using fbdev.diff.gz and
 2.5.5[45]
Date: Fri, 24 Jan 2003 19:09:33 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301241908420.6857-100000@phoenix.infradead.org>
References: <200301182028.33155.rfjak@eircom.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.infradead.org ([195.224.96.167])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18c9DL-0002sE-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 24 Jan 2003 11:10:07 -0800
In-Reply-To: <200301182028.33155.rfjak@eircom.net>
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
To: Jak <rfjak@eircom.net>
Cc: linux-fbdev-devel@lists.sourceforge.net


> Good news is that 2.5.59 seems quite stable as regards framebuffer.
> It no longer locks up after loading fbcon. But rmmod fbcon still
> causes instant death accompanied by increased whirring noises from inside
> box.

rmmod is really broken for fbcon. It shuts down the VT console system. It 
needs work in this area.




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
