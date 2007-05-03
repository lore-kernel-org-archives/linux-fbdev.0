From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] fbdev sysfs updates.
Date: Fri, 04 May 2007 03:22:06 +0800
Message-ID: <1178220126.28617.3.camel@daplas>
References: <Pine.LNX.4.64.0705022040200.28169@pentafluge.infradead.org>
	<1178141769.4606.48.camel@daplas>
	<Pine.LNX.4.64.0705031456330.15445@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hjgsb-0002Ml-9s for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 May 2007 12:22:17 -0700
Received: from py-out-1112.google.com ([64.233.166.179])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hjgsa-00080P-Lb
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 May 2007 12:22:17 -0700
Received: by py-out-1112.google.com with SMTP id a29so502411pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 03 May 2007 12:22:15 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0705031456330.15445@pentafluge.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net

On Thu, 2007-05-03 at 15:03 +0100, James Simmons wrote:
> > On Wed, 2007-05-02 at 20:45 +0100, James Simmons wrote:
> > > Andrew can you try this patch. The goal of the patch is to allow the 
> > > hardware behind fbdev to be shared with out types of devices i.e 
> > > backlight, drm, and display. Please give it a try.
> > > 
> > 
> > Any real world examples on how this patch can allow sharing with DRM?
> > I'm not sure if your changelog reflects the content of this patch.
> 
> DRM would need to be updated to use a child device. The idea is simple. 
> Use the device created with device_create instead of the parent device.
> The conflict was storing our private data with the parent device. Now it 
> is stored in the child device. Other subsystems already use this approach. 
> The drivers would need to be be cleaned up. Right now they use the parent 
> device to stored fb_info. 

What I basically see in this patch, unless I miss something, is moving
device code from fbmem.c to fbsysfs.c and the creation of fb_power()
hook. I have nothing against the patch in principle, I just think the
changelog is not very clear. 

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
