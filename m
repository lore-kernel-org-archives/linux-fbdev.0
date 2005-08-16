From: "Dominik 'Rathann' Mierzejewski" <D.Mierzejewski@icm.edu.pl>
Subject: Re: cyberblade patch
Date: Tue, 16 Aug 2005 15:34:18 +0200
Message-ID: <20050816133418.GC10234@ws-gradcol1.icm.edu.pl>
References: <20050804102905.GE7605@ws-gradcol1.icm.edu.pl> <20050804151342.GB11179@ws-gradcol1.icm.edu.pl> <20050810131148.GC11962@ws-gradcol1.icm.edu.pl> <Pine.LNX.4.58.0508101938400.2328@linux.site> <20050811100108.GC1287@ws-gradcol1.icm.edu.pl> <Pine.LNX.4.58.0508120553160.2252@linux.site>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E51aG-00031j-CG
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 16 Aug 2005 06:34:28 -0700
Received: from gw.icm.edu.pl ([212.87.0.39] helo=atol.icm.edu.pl)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E51aD-0000PI-Oq
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 16 Aug 2005 06:34:28 -0700
Received: from fs.icm.edu.pl (fs.icm.edu.pl [192.168.1.165])
	by atol.icm.edu.pl (8.13.1/8.13.1/rzm-5.1/icm) with ESMTP id j7GDYJSA017245
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 16 Aug 2005 15:34:19 +0200
Received: from ws-gradcol1.icm.edu.pl (ws-gradcol1.icm.edu.pl [192.168.1.26])
	by fs.icm.edu.pl (8.13.3/8.13.2/rzm-2.9.4/icm) with ESMTP id j7GDYInU001046
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 16 Aug 2005 15:34:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508120553160.2252@linux.site>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

On Fri, Aug 12, 2005 at 06:17:36AM +0200, Knut_Petersen@t-online.de wrote:
> At the end of 2003 I complained about a lot of serious bugs. Nobody cared
> about that. Some people, even one of the linux gurus, just told me to use
> epiafb (not included in the standard distribution), but that driver is 
> even more broken. I then wrote a dirty hack and used it for some time ... 
> a vesafb with integrated cyberblade acceleration. Not really clean enough 
> for release ;-) At the end of 2005 I had some time and wrote cyblafb, based 
> on tridentfb. Probably cyblafb will be extended to include support for 
> cyberblade/i7 and another "Blade 3D" graphics cores. But fixing tridentfb 
> for all chips without hardware access is a task too time consuming for me.

I understand. Thank you for the detailed explanation. For the record:
if anyone wants to throw any patches that might work on Trident Cyber 9525
chipset at me, I'll be more than happy to test them.

Regards,

-- 
Dominik 'Rathann' Mierzejewski <rathann*at*icm.edu.pl>
Interdisciplinary Centre for Mathematical and Computational Modelling
Warsaw University  |  http://www.icm.edu.pl  |  tel. +48 (22) 5540810


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
