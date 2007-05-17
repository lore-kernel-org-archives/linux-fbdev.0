From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 01/10] fbdev: Clean up of sparc FB
	options
Date: Wed, 16 May 2007 17:05:50 -0700 (PDT)
Message-ID: <20070516.170550.85686786.davem@davemloft.net>
References: <1179357305.4743.20.camel@daplas>
	<20070516.161717.115911096.davem@davemloft.net>
	<1179360118.4743.32.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HoTV2-0003US-VK for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 May 2007 17:05:45 -0700
Received: from [74.93.104.97] (helo=sunset.davemloft.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HoTV2-00047S-Ej
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 May 2007 17:05:44 -0700
In-Reply-To: <1179360118.4743.32.camel@daplas>
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
To: adaplas@gmail.com
Cc: akpm@osdl.org, linux-fbdev-devel@lists.sourceforge.net

From: "Antonino A. Daplas" <adaplas@gmail.com>
Date: Thu, 17 May 2007 08:01:58 +0800

> The question is, will this work for sparc?

It can't be just by type, we need to be able to able to select
individual instances of the same kind of device.  I can't tell if
you're saying your scheme handles this or not :-)))

I can have two ffb cards in my machine and I can tell fbcon precisely
which of those ffb instances is the primary one.  That's what I'd need
to work.

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
