From: James Simmons <jsimmons@infradead.org>
Subject: Re: const fb_{fillrect,copyarea,image}?
Date: Tue, 7 Jan 2003 21:21:03 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301072119370.17129-100000@phoenix.infradead.org>
References: <Pine.GSO.4.21.0212301127150.18122-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18W1AI-0006Wu-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 07 Jan 2003 13:21:39 -0800
In-Reply-To: <Pine.GSO.4.21.0212301127150.18122-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


> Wouldn't it make sense to make the fb_{fillrect,copyarea,image} parameters of
> the fb_ops.fb_{fillrect,copyarea,image}() operations const? This would protect
> us against side effects when reusing the fb_{fillrect,copyarea,image} structs
> without reinitializing their contents (as is currently done by the logo drawing
> code in fbcon_show_logo() on SMP).

Where is this exactly?

> Of course this means that we have to modify the clipping code, which currently
> just modifies the passed structure.

:-( That is done to prevent someone from passing data that is larger than 
the framebuffer.



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
