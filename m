From: Carlos Manuel Duclos Vergara <carlos@embedded.cl>
Subject: Re: Kernel panic by write to console while switching consoles.
Date: Thu, 29 Jul 2004 12:13:40 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200407291213.40358.carlos@embedded.cl>
References: <1091116646.41091e66f1b3c@webmail.quest-innovations.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BqDP5-0002wm-S4
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 29 Jul 2004 09:05:11 -0700
Received: from [200.73.64.66] (helo=apolo.virtuabyte.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BqDP5-00009S-Fg
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 29 Jul 2004 09:05:11 -0700
Received: from cm-vina3-148-69.cm.vtr.net ([200.104.148.69])
        by apolo.virtuabyte.com (Merak 7.4.4) with ASMTP id CQA74038
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 29 Jul 2004 12:05:01 -0400
In-Reply-To: <1091116646.41091e66f1b3c@webmail.quest-innovations.com>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net

Hi,

[...]

the console is enabled very early in the boot process in order to print some 
info about the boot process itself. Read start_kernel() in 
$(KERNEL_SOURCE)/init/main.c
for more info

bye


-- 
Carlos Manuel Duclos Vergara
carlos@embedded.cl


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
