From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: directcolor colormap question
Date: Mon, 19 Sep 2005 20:00:47 +0600
Message-ID: <432EC48F.40804@ums.usu.ru>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EHMHG-0005Hm-Ev
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 19 Sep 2005 07:05:50 -0700
Received: from relay4.usu.ru ([194.226.235.39])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EHMHC-0004uq-M5
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 19 Sep 2005 07:05:50 -0700
Received: from relay4.usu.ru (localhost [127.0.0.1])
	by relay4.usu.ru (PostSystem) with ESMTP id 1055316A66
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 19 Sep 2005 20:05:35 +0600 (YEKST)
Received: from usu2.usu.ru (usu2.usu.ru [194.226.237.16])
	by relay4.usu.ru (PostSystem) with ESMTP id 9896616A66
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 19 Sep 2005 20:05:34 +0600 (YEKST)
Received: from localhost.usu2.usu.ru (localhost.usu2.usu.ru [127.0.0.1])
	by usu2.usu.ru (Postfix) with ESMTP id 60183A7A32
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 19 Sep 2005 20:05:32 +0600 (YEKST)
Received: from ums.usu.ru (ums.usu.ru [194.226.236.116])
	by usu2.usu.ru (Postfix) with ESMTP id 55E1FA7A2F
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 19 Sep 2005 20:05:32 +0600 (YEKST)
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hello,

I am still writing a framebuffer driver for S3 Trio 3D/2X cards. Since 
this card supports (hardware) gamma correction in Windows 98, I decided 
to implement directcolor visuals (Xorg guys: you can set SR1B to 0x18 if 
bpp>8, and then standard VGA PEL registers will alter the hardware 
colormap).

The problem here is that I don't know the proper semantics for colormap 
persistence.

Consider the following scenario:

fbset -depth 16 -rgba 5,5,5,1 -nonstd 1
run some program that sets a colormap, e.g. Xorg with the "fbdev" driver
fbset -depth 16 -rgba 5,6,5,0 -nonstd 1
(oops, the text is all purple!)

The problem is that the program sets the following colormap:

reg 0 -> (0,0,0)
reg 1 -> (8,4,8)
...
reg 31 -> (255,125,255)
reg 32 -> (0,129,0)
reg 33 -> (0,133,0)
...
reg 62 -> (0,250,0)
reg 63 -> (0,255,0)

(i.e. just a linear colormap for 16 bpp). When I switch the framebuffer 
to 15bpp, the colormap persists, but it is no longer a proper colormap 
for that mode! Is this colormap persistence an expected behaviour, or 
should I somehow initialize the colormap to something sane on depth 
switch? If that's a bug in my driver, could you please point me where 
some other driver does this colormap initialization?

-- 
Alexander E. Patrakov


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
