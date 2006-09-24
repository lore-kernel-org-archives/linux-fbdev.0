From: Torgeir Veimo <torgeir@pobox.com>
Subject: Re: Status of WAITFORVSYNC (waitretrace)
Date: Sun, 24 Sep 2006 12:57:27 +0100
Message-ID: <96AEB292-5B41-4436-80C4-104EE418556C@pobox.com>
References: <45165586.2@freemail.gr>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GRSc8-0004hV-GC for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 24 Sep 2006 04:57:41 -0700
Received: from proof.pobox.com ([207.106.133.28] ident=postfix)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GRSc5-0004Zz-RJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 24 Sep 2006 04:57:40 -0700
Received: from proof (localhost [127.0.0.1])
	by proof.pobox.com (Postfix) with ESMTP id DA14929D4D
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 24 Sep 2006 07:57:54 -0400 (EDT)
Received: from [192.168.1.11] (iampivot.plus.com [80.229.27.41])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by proof.sasl.smtp.pobox.com (Postfix) with ESMTP id 5513A790B3
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 24 Sep 2006 07:57:54 -0400 (EDT)
In-Reply-To: <45165586.2@freemail.gr>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net


On 24 Sep 2006, at 10:53, jfj wrote:

>
> I have kernel 2.6.17
> It seems that the matrox card implements FBIO_WAITFORVSYNC ioctl.

My patch for radeonfb was turned down since using that ioctl might  
freeze kernel if the drm kernel module is active and is using the  
same interrupt. I think an alternative option would be to disable it  
by default unless a kernel module param is set when loading radeonfb,  
since it's currently a bit difficult to get inter module  
communication between the drm and radeonfb modules. I never got  
around to resubmit a modified patch though.


-- 
Torgeir Veimo
torgeir@pobox.com




-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
