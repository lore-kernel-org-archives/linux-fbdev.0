From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] pm2fb: accelerated fillrect
	and	copyarea
Date: Tue, 01 May 2007 05:21:49 +0800
Message-ID: <1177968109.4372.4.camel@daplas>
References: <46363c001f8a0@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HidJm-0002t9-Ta for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Apr 2007 14:21:59 -0700
Received: from py-out-1112.google.com ([64.233.166.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HidJl-0004S2-Aa
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Apr 2007 14:21:58 -0700
Received: by py-out-1112.google.com with SMTP id a29so1443788pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 14:21:56 -0700 (PDT)
In-Reply-To: <46363c001f8a0@wp.pl>
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

On Mon, 2007-04-30 at 20:57 +0200, Krzysztof Helt wrote:
> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> This is port of accelerated functions from 2.4 kernel. Only
> fillrect and copyarea are accelerated. Fillrect is not
> accelerated in 24-bit mode.

For the best scrolling mode, you would want to advertise the driver's
capability with:

info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN |
FBINFO_HWACCEL_COPYAREA | FBINFO_HWACCEL_FILLRECT;

I'll add this myself.

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
