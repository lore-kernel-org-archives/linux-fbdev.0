From: "Kaj-Michael Lang" <milang@tal.org>
Subject: writing a framebuffer driver and font problem..
Date: Fri, 31 Oct 2003 10:16:22 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <004501c39f87$480b7e60$54dc10c3@amos>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AFUQs-0003Oi-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 31 Oct 2003 00:14:58 -0800
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AFUQr-0000V7-S8
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 31 Oct 2003 00:14:58 -0800
Received: from fairytale.tal.org (cruel.tal.org [195.16.220.85])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id AFB0291BB5F
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 31 Oct 2003 10:13:38 +0200 (EET)
Received: from amos (unknown [195.16.220.84])
	by fairytale.tal.org (Postfix) with SMTP id 372388D76
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 31 Oct 2003 10:17:17 +0200 (EET)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net

Hello..

I hope someone here can help me. I've started writing support for the b/w
framebuffer on
VAXstation for the Linux/VAX project. And I've got so far that it sort-of
works, I can output text
on the framebuffer and such. Problem is that all font are flipped/mirrored,
like a "b" looks like "d", this picture
might show it a little bit better: http://home.tal.org/~milang/vax/2.html
And as you can se from the picture the logo looks strange.

What might be the problem, and what should I do to fix it ?

I'm totaly new a writing kernel code so it might be something obvious that
I'm missing.

-- 
Kaj-Michael Lang , milang@tal.org



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
