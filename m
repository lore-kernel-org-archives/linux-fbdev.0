From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 05/24] ffb: The pseudo_palette is
	only 16 elements long
Date: Tue, 05 Jun 2007 13:13:55 -0700 (PDT)
Message-ID: <20070605.131355.13769338.davem@davemloft.net>
References: <46613F10.4050005@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HvfPS-0004hl-Of for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Jun 2007 13:13:42 -0700
Received: from [74.93.104.97] (helo=sunset.davemloft.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HvfPS-0004YU-CK
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Jun 2007 13:13:42 -0700
In-Reply-To: <46613F10.4050005@gmail.com>
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
Date: Sat, 02 Jun 2007 17:57:36 +0800

> The pseudo_palette is only 16 elements long.
> 
> Signed-off-by: Antonino Daplas <adaplas@gmail.com>

Antonio, if you don't mind I'll merge the ffb, xvr2500,
and xvr500 pseudo palette fixes in via my Sparc tree.

Thanks for doing this audit!

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
