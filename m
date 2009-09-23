From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: How to test overlay functionalities
Date: Wed, 23 Sep 2009 15:23:24 +0200
Message-ID: <4ABA214C.4080605@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sedji.gaouaou@atmel.com>) id 1MqRoz-0002Ge-Bm
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 23 Sep 2009 13:23:49 +0000
Received: from mail.atmel.fr ([81.80.104.162] helo=atmel-es2.atmel.fr)
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MqRou-0001Oi-QL for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 23 Sep 2009 13:23:49 +0000
Received: from fwat.rfo.atmel.com (gateway [192.168.1.1])
	by atmel-es2.atmel.fr (8.11.6+Sun/8.11.6) with SMTP id n8NDGxO21141
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 23 Sep 2009 15:17:07 +0200 (MEST)
Received: from [10.159.245.197] ([10.159.245.197])
	by meyreuil.atmel.fr (8.11.7p1+Sun/8.11.7) with ESMTP id n8NDNNg04179
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 23 Sep 2009 15:23:23 +0200 (MEST)
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

Hi,

I am currently writing a driver for a LCD controller that has overlay 
layers.
My concern is that I would like to know how can I test such 
functionalities? For instance is mplayer able to handle overlay layers?
I can see in the kernel 2.6.30 that the pxa handles overlay layers, so 
there should be a way to use/test these layers.

Regards,
Sedji

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
