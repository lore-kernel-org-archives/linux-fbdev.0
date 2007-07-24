From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [PATCH] fix s3c2410 compilation
Date: Tue, 24 Jul 2007 15:00:28 +0200
Message-ID: <85ir8alzwz.fsf@Orfeo.duckcorp.org>
References: <20070724125233.GA5389@fluff.org.uk>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IDK0F-0007OW-Ny for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 24 Jul 2007 06:00:39 -0700
Received: from orfeo.duckcorp.org
	([195.5.254.194] helo=mx.duckcorp.org ident=postfix)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IDK0C-0006jF-ER
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 24 Jul 2007 06:00:38 -0700
Received: from localhost (localhost [127.0.0.1])
	by mx.duckcorp.org (Postfix) with ESMTP id 19E5E219B4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 24 Jul 2007 15:00:32 +0200 (CEST)
Received: from mx.duckcorp.org ([127.0.0.1])
	by localhost (smtp.duckcorp.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bg--KxMNfMPl
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 24 Jul 2007 15:00:28 +0200 (CEST)
Received: from Orfeo.duckcorp.org (localhost [127.0.0.1])
	by mx.duckcorp.org (Postfix) with ESMTP id C5B95219AD
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 24 Jul 2007 15:00:28 +0200 (CEST)
In-Reply-To: <20070724125233.GA5389@fluff.org.uk> (Ben Dooks's message of
	"Tue, 24 Jul 2007 13:52:33 +0100")
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

Ben Dooks <ben-linux@fluff.org> writes:

> The implicit mapping has been removed from the arch
> as this should be handled in the driver, this patch
> fixes the s3c2410_fb driver to ioremap() the necessary
> registers.
>
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Acked-by: Arnaud Patard <arnaud.patard@rtp-net.org>


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
