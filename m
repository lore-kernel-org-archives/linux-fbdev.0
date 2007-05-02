From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] fbdev sysfs updates.
Date: Thu, 03 May 2007 05:36:09 +0800
Message-ID: <1178141769.4606.48.camel@daplas>
References: <Pine.LNX.4.64.0705022040200.28169@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HjMUi-0007Zx-Ab for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 May 2007 14:36:16 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HjMUi-0005wq-0c
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 May 2007 14:36:16 -0700
Received: by py-out-1112.google.com with SMTP id a29so238827pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 02 May 2007 14:36:15 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0705022040200.28169@pentafluge.infradead.org>
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
Cc: Andrew Morton <akpm@osdl.org>, James Simmons <jsimmons@infradead.org>

On Wed, 2007-05-02 at 20:45 +0100, James Simmons wrote:
> Andrew can you try this patch. The goal of the patch is to allow the 
> hardware behind fbdev to be shared with out types of devices i.e 
> backlight, drm, and display. Please give it a try.
> 

Any real world examples on how this patch can allow sharing with DRM?
I'm not sure if your changelog reflects the content of this patch.

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
