From: Imago <imago@devinity.de>
Subject: Fbcon issue
Date: Mon, 27 Dec 2004 01:52:43 +0100
Message-ID: <41CF5CDB.8040300@devinity.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CijB5-00031n-EJ
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 26 Dec 2004 16:56:03 -0800
Received: from p15093822.pureserver.info ([217.160.109.210])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CijB4-0008Nq-MJ
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 26 Dec 2004 16:56:03 -0800
Received: from [192.168.1.9] (pD9568197.dip.t-dialin.net [217.86.129.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by p15093822.pureserver.info (Postfix) with ESMTP id D7461400145
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 27 Dec 2004 01:55:59 +0100 (CET)
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Hi
while doing some bug hunting for another project I discovered an issue
which is imho a bug in fbcon.
The problem is that each virtual console has its own color palette but
the framebuffer only has one color map.
So, for example, if im running fbcon on vt1 and set there a non-default
colormap and then allocate a new vt, for which the standard
color palette is set, also the framebuffer colormap is set back to the
default.Which will lead to color corruption on the actual vt.
A fix could be to allow setting of color palette only for the foreground
console,
ie change following in fbcon.c: fbcon_set_palette() at line 2400:

if (fbcon_is_inactive(vc, info))
                return -EINVAL;

to

if ( fbcon_is_inactive(vc, info) ||  (vc->vc_num != fg_console) )
                return -EINVAL;

Cu
Peter




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
