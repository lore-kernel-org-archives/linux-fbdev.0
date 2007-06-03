From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 11/24] pvr2fb: Fix pseudo_palette
	array overrun and typecast
Date: Mon, 4 Jun 2007 08:25:10 +0900
Message-ID: <20070603232510.GA29291@linux-sh.org>
References: <46613FBE.2000507@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HuzSo-0003ge-QI for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 03 Jun 2007 16:26:23 -0700
Received: from smtp.ocgnet.org ([64.20.243.3])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HuzSn-0005m3-Gp
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 03 Jun 2007 16:26:22 -0700
Content-Disposition: inline
In-Reply-To: <46613FBE.2000507@gmail.com>
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
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, Jun 02, 2007 at 06:00:30PM +0800, Antonino A. Daplas wrote:
> - the pseudo_palette has only 16 elements. Do not write if regno (the array
>   index) is more than 15.
> - if using generic drawing libraries, the typecast of pseudo_palette is 
>   always u32 *
> 
> Signed-off-by: Antonino Daplas <adaplas@gmail.com>

Acked-by: Paul Mundt <lethal@linux-sh.org>

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
