From: sylvain ferriol <sferriol@imag.fr>
Subject: bug in new tga framebuffer on dec 21030
Date: Fri, 24 Sep 2004 18:29:07 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <41544B53.4060008@imag.fr>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CAqtc-00072z-Ab
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 24 Sep 2004 07:18:00 -0700
Received: from gauss.mathematik.uni-oldenburg.de ([134.106.106.200])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CAqtb-0006EM-Ln
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 24 Sep 2004 07:18:00 -0700
Received: from imag.fr (dhcp-sn164-08.hrz.uni-oldenburg.de [134.106.164.18])
	by gauss.mathematik.uni-oldenburg.de (Postfix) with ESMTP id 0B7124BCF6
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 24 Sep 2004 16:17:43 +0200 (CEST)
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

hello
i'm testing debian installer on alpha and it does not work because we 
use 2.4.27 with the new tga framebuffer.
but it does not work with dec 21030 tga 8 plane card.
I succeed to install woody on this computer because it uses 2.2 kernel 
and tga driver works

sylvain


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
