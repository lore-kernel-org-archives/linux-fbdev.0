From: James Simmons <jsimmons@infradead.org>
Subject: Re: will the new edid functionality allow vesafb
 to set a frequency?
Date: Thu, 10 Apr 2003 22:42:30 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0304102241430.23050-100000@phoenix.infradead.org>
References: <24510.212.153.94.193.1049371331.squirrel@webmail.xs4all.nl>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 193jp2-0007aF-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 10 Apr 2003 14:43:04 -0700
In-Reply-To: <24510.212.153.94.193.1049371331.squirrel@webmail.xs4all.nl>
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
To: Jurriaan Kalkman <thunder7@xs4all.nl>
Cc: linux-fbdev-devel@lists.sourceforge.net


> As the owner of a NVidia card, whose evil proprietary driver won't work
> with rivafb, but would possibly work with vesafb (I see mixed messages
> on usenet about this), I have the following question:
> 
> will the new edid-functionality that is currently in heavy development
> allow linux (somewhere in the future) to set a vertical refresh frequency
> with vesafb? I did notice that this Ti500 card has a VESA/VBE 3.0
> compatible BIOS, so it should be possible.

Yes. Also long as your monitor supports EDID correctly. I tested it on my 
laptop and the data was botched :-(



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
