From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: Problems with rotated Logos
Date: Thu, 15 Jun 2006 00:35:02 +0100
Message-ID: <1150328102.9240.21.camel@localhost.localdomain>
References: <1150279997.27375.15.camel@localhost.localdomain>
	<4490091B.4090900@gmail.com>
	<1150311401.9240.9.camel@localhost.localdomain>
	<44907F49.7050609@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FqetB-0005nL-Ej for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 16:35:09 -0700
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Fqet9-0001Dw-PO
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 16:35:09 -0700
In-Reply-To: <44907F49.7050609@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Thu, 2006-06-15 at 05:27 +0800, Antonino A. Daplas wrote:
> Yes, you're right, the dimensions where reversed. Can you revert the previous
> patch, and then apply this one?

I've applied this and it displays perfectly, thanks! :)

> PS: If this still doesn't work, can you send me your logo ppm file?

In case you still want it, I have a few logos available at:
http://www.rpsys.net/openzaurus/patches/archive/logo_oz-r0.patch.bz2
http://www.rpsys.net/openzaurus/patches/archive/logo_oh-r0.patch.bz2

(the oz640 one is the one I was testing with)

Cheers,

Richard
