From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] sm501fb: fix printk format warnings
Date: Thu, 03 May 2007 07:16:56 +0800
Message-ID: <1178147816.4606.50.camel@daplas>
References: <20070430175853.4f315a1e.randy.dunlap@oracle.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HjO4G-0005zb-N8 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 May 2007 16:17:04 -0700
Received: from py-out-1112.google.com ([64.233.166.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HjO4G-0008ME-6w
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 May 2007 16:17:04 -0700
Received: by py-out-1112.google.com with SMTP id a29so259771pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 02 May 2007 16:17:03 -0700 (PDT)
In-Reply-To: <20070430175853.4f315a1e.randy.dunlap@oracle.com>
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
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: akpm <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net

On Mon, 2007-04-30 at 17:58 -0700, Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Fix printk format warnings:
> drivers/video/sm501fb.c:992: warning: format '%08x' expects type 'unsigned int', but argument 3 has type 'long unsigned int'
> drivers/video/sm501fb.c:992: warning: format '%08x' expects type 'unsigned int', but argument 4 has type 'long unsigned int'
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>

This is already in the -mm tree.

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
