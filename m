From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: vesafb on Savage4
Date: Tue, 3 Aug 2004 20:22:50 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200408032022.51173.adaplas@hotpop.com>
References: <cenq8o$lkv$1@sea.gmane.org>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BryKx-0007K1-Vl
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 03 Aug 2004 05:24:11 -0700
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BryKx-0000JQ-Lp
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 03 Aug 2004 05:24:11 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 3141570500
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue,  3 Aug 2004 11:09:47 +0000 (UTC)
In-Reply-To: <cenq8o$lkv$1@sea.gmane.org>
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
To: Miernik <miernik@ctnet.pl>, linux-fbdev-devel@lists.sourceforge.net

On Tuesday 03 August 2004 18:43, Miernik wrote:
>
> Aug  3 13:52:19 localhost kernel: vesafb: probe of vesafb0 failed with
> error -6

The error is -ENXIO and in vesafb it means that your graphics card failed to 
go to graphics mode.

Can you post your dmesg and kernel config?

Tony




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
