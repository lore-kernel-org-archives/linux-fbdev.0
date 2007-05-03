From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] fbdev sysfs updates.
Date: Thu, 3 May 2007 15:03:07 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705031456330.15445@pentafluge.infradead.org>
References: <Pine.LNX.4.64.0705022040200.28169@pentafluge.infradead.org>
	<1178141769.4606.48.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hjbto-0002V6-87 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 May 2007 07:03:12 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Hjbtn-00055P-Kn
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 May 2007 07:03:12 -0700
In-Reply-To: <1178141769.4606.48.camel@daplas>
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
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net


> On Wed, 2007-05-02 at 20:45 +0100, James Simmons wrote:
> > Andrew can you try this patch. The goal of the patch is to allow the 
> > hardware behind fbdev to be shared with out types of devices i.e 
> > backlight, drm, and display. Please give it a try.
> > 
> 
> Any real world examples on how this patch can allow sharing with DRM?
> I'm not sure if your changelog reflects the content of this patch.

DRM would need to be updated to use a child device. The idea is simple. 
Use the device created with device_create instead of the parent device.
The conflict was storing our private data with the parent device. Now it 
is stored in the child device. Other subsystems already use this approach. 
The drivers would need to be be cleaned up. Right now they use the parent 
device to stored fb_info. 


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
