From: romain@dolbeau.org (Romain Dolbeau)
Subject: Re: [PATCH] pm3fb: preliminary support for
	2.6	kernel
Date: Mon, 7 May 2007 14:08:56 +0200
Message-ID: <1hxqxt8.1dr1xgy136212oM%romain@dolbeau.org>
References: <463e3edaad7a2@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hl22J-0008Vi-8a for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 07 May 2007 05:09:51 -0700
Received: from gandalf.caps-entreprise.com ([212.180.111.10])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Hl22G-0007EM-J2
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 07 May 2007 05:09:51 -0700
In-Reply-To: <463e3edaad7a2@wp.pl>
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
To: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

Krzysztof Helt <krzysztof.h1@wp.pl> wrote:

> This is a basic port from 2.4 kernel to 2.6. Acceleration is lost
> and big endian support probably too. The driver works in 8, 16
> and 32 bit mode.

> - *  CHANGELOG:
> - *  Mon Feb 11 10:35:48 MET 2002, v 1.4.11B: Cosmetic update.

There was a 1.4.11C, which I believe was included in 2.4.26-pre2 .

And if my IRISA e-mail address is still in the source, it's probably
best to update it to <romain@dolbeau.org>.

-- 
Romain Dolbeau
<romain@dolbeau.org>

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
