From: Stelios Xanthakis <sxanth@ceid.upatras.gr>
Subject: Question about radeon 3000 driver
Date: Mon, 1 Jun 2009 18:13:37 +0300 (EEST)
Message-ID: <Pine.LNX.4.64.0906011805490.16330@diogenis.ceid.upatras.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sxanth@ceid.upatras.gr>) id 1MB9Cq-00060Y-11
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Jun 2009 15:13:44 +0000
Received: from poseidon.ceid.upatras.gr ([150.140.141.169])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MB9Cn-0002rn-FM for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Jun 2009 15:13:43 +0000
Received: from mail.ceid.upatras.gr (unknown [10.1.0.143])
	by poseidon.ceid.upatras.gr (Postfix) with ESMTP id B5B0CEB526A
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon,  1 Jun 2009 18:13:37 +0300 (EEST)
Received: from localhost (europa.ceid.upatras.gr [127.0.0.1])
	by mail.ceid.upatras.gr (Postfix) with ESMTP id A4E28450ED
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon,  1 Jun 2009 18:13:37 +0300 (EEST)
Received: from mail.ceid.upatras.gr ([127.0.0.1])
	by localhost (europa.ceid.upatras.gr [127.0.0.1]) (amavisd-new,
	port 10024) with ESMTP id ZFo9MLKA6G6y
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon,  1 Jun 2009 18:13:37 +0300 (EEST)
Received: from diogenis.ceid.upatras.gr (unknown [10.1.0.181])
	by mail.ceid.upatras.gr (Postfix) with ESMTP id 796CE450C6
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon,  1 Jun 2009 18:13:37 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
	by diogenis.ceid.upatras.gr (Postfix) with ESMTP id 6D5D0178002
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon,  1 Jun 2009 18:13:37 +0300 (EEST)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

Hi.

I have a PC with an integrated radeon 3000 gfx card
(pci id 9616) and I'd really like to be able to use
the linux framebuffer with a proper driver because
vesafb has all sorts of problems.

I plan to start with the usual procedure of copying
stuff from the xf86-video-ati drivers, since this
card is already supported by xf86-video-ati-12.

The question is, are there any pending patches for
the radeon drivers, or git trees that may have
relevant work for the R600 chipsets?

Thanks,

Stelios


------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
