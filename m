From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: framebuffer ioctl
Date: Mon, 6 Sep 2004 15:33:11 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <9e47339104090612334b3623ee@mail.gmail.com>
References: <Pine.GSO.4.58.0409041304080.3434@waterleaf.sonytel.be>
	 <413A3735.9E7D2F11@orpatec.ch> <413B4925.5000706@comcast.net>
	 <20040906184306.GA29544@guug.org>
	 <9e47339104090612086149bfd7@mail.gmail.com>
	 <20040906192400.GB29544@guug.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4PEm-00019W-Tj
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 06 Sep 2004 12:33:12 -0700
Received: from rproxy.gmail.com ([64.233.170.202] helo=mproxy.gmail.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C4PEm-0003gL-IH
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 06 Sep 2004 12:33:12 -0700
Received: by mproxy.gmail.com with SMTP id 77so141424rnl
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 06 Sep 2004 12:33:11 -0700 (PDT)
In-Reply-To: <20040906192400.GB29544@guug.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net

It is still being worked on. The have been a lot of changes to DRM
recently. The PCI ROM patch is finished and waiting to go into the
kernel. I'm starting on the VGA driver next. Jess@sgi is working on
the user space reset app.

After all that is done we can start on printk support.


On Mon, 6 Sep 2004 13:24:00 -0600, Otto Solares <solca@guug.org> wrote:
> On Mon, Sep 06, 2004 at 03:08:40PM -0400, Jon Smirl wrote:
> > On Mon, 6 Sep 2004 12:43:06 -0600, Otto Solares <solca@guug.org> wrote:
> >
> > Teach him about mesa-solo and he won't want to extend fbdev.
> 
> What about the new graphics interface that will unify
> fbdev/drm you talk about in kernel summit?
> 
> 
> 
> -otto
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by BEA Weblogic Workshop
> FREE Java Enterprise J2EE developer tools!
> Get your free copy of BEA WebLogic Workshop 8.1 today.
> http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 



-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
