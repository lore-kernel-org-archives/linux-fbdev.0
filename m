From: dolbeaur@club-internet.fr (Romain Dolbeau)
Subject: Re: State of pm3fb driver
Date: Tue, 5 Oct 2004 15:01:23 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1gl6uux.9w928rity4liM%dolbeaur@club-internet.fr>
References: <20041003125343.GA7675@mercury.jahnsnet.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CEova-000855-8e
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 05 Oct 2004 06:00:26 -0700
Received: from gandalf.caps-entreprise.com ([212.180.111.10])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1CEovR-0006Gj-Lg
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 05 Oct 2004 06:00:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by gandalf.caps-entreprise.com (Postfix) with ESMTP id 5E13916EBB
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue,  5 Oct 2004 15:00:09 +0200 (CEST)
Received: from gandalf.caps-entreprise.com ([127.0.0.1])
	by localhost (gandalf [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 16366-07 for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 5 Oct 2004 15:00:08 +0200 (CEST)
Received: from [172.21.96.10] (tibook-ap.caps-entreprise.com [172.21.96.10])
	by gandalf.caps-entreprise.com (Postfix) with ESMTP id C338F16E0C
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue,  5 Oct 2004 15:00:08 +0200 (CEST)
In-Reply-To: <20041003125343.GA7675@mercury.jahnsnet.de>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Fbdev <linux-fbdev-devel@lists.sourceforge.net>

Thomas Jahns <Thomas.Jahns@epost.de> wrote:

> after I was quite unhappy with the support for my ATI Mach64 adapter in
> my Powermac 7500 I aquired a Formac Proformance III adapter that  
> supposedly uses a Permedia 3 chip. Unfortunately it seems that the  
> driver is broken in kernel 2.6.8 (at least to my incomplete  
> understanding of the subject) for the following reasons:

Noone ever updated pm3fb to works with 2.6.x, so as you noticed,
it doesn't work. There was a lot of changes for FB driver in 2.6.x,
so the driver is in need of a complete rewrite.

You can try using the likely working (but surely slow) offb, the generic
OpenFirmware driver. Or (down|up)grade to 2.4.x.

-- 
Romain Dolbeau


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
